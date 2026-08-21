import { useCallback, useEffect, useRef, useState } from 'react'

// Loads Pyodide (a real CPython build compiled to WebAssembly) from the
// official CDN and runs student code entirely inside the browser sandbox —
// no server, no backend, no access to the user's filesystem or network.
// This gives genuine Python execution safely, satisfying the "real Python,
// no dangerous system access" requirement without a custom backend.

declare global {
  interface Window {
    loadPyodide?: (opts?: any) => Promise<any>
  }
}

const PYODIDE_VERSION = '0.26.2'
const PYODIDE_CDN = `https://cdn.jsdelivr.net/pyodide/v${PYODIDE_VERSION}/full/`

let pyodideSingleton: any = null
let loadingPromise: Promise<any> | null = null

function loadScript(src: string): Promise<void> {
  return new Promise((resolve, reject) => {
    if (document.querySelector(`script[src="${src}"]`)) return resolve()
    const script = document.createElement('script')
    script.src = src
    script.onload = () => resolve()
    script.onerror = () => reject(new Error('فشل تحميل محرك Python'))
    document.body.appendChild(script)
  })
}

async function getPyodide() {
  if (pyodideSingleton) return pyodideSingleton
  if (!loadingPromise) {
    loadingPromise = (async () => {
      await loadScript(`${PYODIDE_CDN}pyodide.js`)
      const py = await window.loadPyodide!({ indexURL: PYODIDE_CDN })
      pyodideSingleton = py
      return py
    })()
  }
  return loadingPromise
}

export interface RunResult {
  stdout: string
  error: string | null
}

function normalizePythonError(raw: string): string {
  if (!raw) return 'Python Error'

  const cleaned = raw
    .replace(/\r/g, '')
    .replace(/Traceback \(most recent call last\):\s*/i, '')
    .trim()

  const patterns = [
    /(?:NameError|SyntaxError|IndentationError|TypeError|ValueError|ZeroDivisionError|IndexError|KeyError|AttributeError|ImportError|ModuleNotFoundError|RuntimeError|AssertionError):.*$/i,
    /File ".*?", line \d+, in .*\n(.*)$/s,
  ]

  for (const pattern of patterns) {
    const match = cleaned.match(pattern)
    if (match) {
      const [, candidate = ''] = match as [string, string]
      const value = candidate || match[0]
      return value.replace(/^\s+/, '').replace(/\s+$/g, '')
    }
  }

  return cleaned
}

export function usePyodide() {
  const [ready, setReady] = useState(false)
  const [initializing, setInitializing] = useState(false)
  const [loadError, setLoadError] = useState<string | null>(null)
  const pyRef = useRef<any>(null)

  useEffect(() => {
    let cancelled = false
    setInitializing(true)
    setLoadError(null)

    getPyodide()
      .then((py) => {
        if (cancelled) return
        pyRef.current = py
        setReady(true)
      })
      .catch((error) => {
        if (cancelled) return
        setLoadError(error instanceof Error ? error.message : 'تعذر تحميل runtime الخاص بـ Python.')
      })
      .finally(() => !cancelled && setInitializing(false))

    return () => {
      cancelled = true
    }
  }, [])

  const runPython = useCallback(async (code: string, stdinValues: string[] = []): Promise<RunResult> => {
    const py = pyRef.current
    if (!py) {
      return { stdout: '', error: loadError ?? 'محرك Python لم يجهز بعد، حاول بعد لحظة.' }
    }

    py.globals.set('__eleven_stdin__', stdinValues)

    const setup = `
import sys, io
_stdin_values = list(__eleven_stdin__)
_stdin_i = 0

def _eleven_input(prompt=""):
    global _stdin_i
    if _stdin_i < len(_stdin_values):
        v = _stdin_values[_stdin_i]
        _stdin_i += 1
        return v
    raise EOFError("لا توجد قيمة إدخال إضافية متاحة")

import builtins
builtins.input = _eleven_input
__eleven_stdout__ = io.StringIO()
__eleven_stderr__ = io.StringIO()
sys.stdout = __eleven_stdout__
sys.stderr = __eleven_stderr__
`

    try {
      await py.runPythonAsync(setup)
      await py.runPythonAsync(code)
      const stdout = await py.runPythonAsync('__eleven_stdout__.getvalue()')
      const stderr = await py.runPythonAsync('__eleven_stderr__.getvalue()')
      const output = String(stdout ?? '')
      const errorOutput = String(stderr ?? '')
      const normalizedError = errorOutput ? normalizePythonError(errorOutput) : null
      return {
        stdout: output,
        error: normalizedError,
      }
    } catch (err: any) {
      let partial = ''
      let errorText = normalizePythonError(String(err?.message ?? err))

      try {
        const stdout = await py.runPythonAsync('__eleven_stdout__.getvalue()')
        const stderr = await py.runPythonAsync('__eleven_stderr__.getvalue()')
        partial = String(stdout ?? '')
        const stderrText = String(stderr ?? '')
        if (stderrText) {
          errorText = normalizePythonError(stderrText)
        }
      } catch {
        // Ignore recovery errors and preserve the original exception message.
      }

      return { stdout: partial, error: errorText }
    }
  }, [loadError])

  return { ready, initializing, loadError, runPython }
}
