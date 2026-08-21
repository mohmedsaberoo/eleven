import Editor, { type OnMount } from '@monaco-editor/react'

const lightTheme = 'eleven-light'
const darkTheme = 'eleven-dark'

function registerMonacoThemes(monaco: any) {
  monaco.editor.defineTheme(lightTheme, {
    base: 'vs',
    inherit: true,
    rules: [
      { token: '', foreground: '1f2937' },
      { token: 'keyword', foreground: 'd73a49' },
      { token: 'string', foreground: '0f766e' },
      { token: 'number', foreground: '1d4ed8' },
      { token: 'comment', foreground: '64748b' },
      { token: 'function', foreground: '7c3aed' },
      { token: 'variable', foreground: '111827' },
      { token: 'operator', foreground: 'b91c1c' },
    ],
    colors: {
      'editor.background': '#f8fafc',
      'editor.foreground': '#111827',
      'editorLineNumber.foreground': '#64748b',
      'editorLineNumber.activeForeground': '#0f172a',
      'editorCursor.foreground': '#0f172a',
      'editor.selectionBackground': '#bfdbfe',
      'editor.inactiveSelectionBackground': '#e2e8f0',
      'editor.lineHighlightBackground': '#e2e8f0',
      'editorIndentGuide.background': '#dbeafe',
      'editorIndentGuide.activeBackground': '#94a3b8',
      'editorGutter.background': '#f8fafc',
      'editorWidget.background': '#ffffff',
      'editorWidget.border': '#dbeafe',
      'editorBracketMatch.background': '#dbeafe',
      'editorBracketMatch.border': '#60a5fa',
      'editor.findMatchBackground': '#fde68a',
    },
  })

  monaco.editor.defineTheme(darkTheme, {
    base: 'vs-dark',
    inherit: true,
    rules: [
      { token: '', foreground: 'f8fafc' },
      { token: 'keyword', foreground: 'ff7b72' },
      { token: 'string', foreground: '7dd3fc' },
      { token: 'number', foreground: 'c4b5fd' },
      { token: 'comment', foreground: '94a3b8' },
      { token: 'function', foreground: 'c084fc' },
      { token: 'variable', foreground: 'e2e8f0' },
      { token: 'operator', foreground: 'fbbf24' },
    ],
    colors: {
      'editor.background': '#0f172a',
      'editor.foreground': '#e2e8f0',
      'editorLineNumber.foreground': '#94a3b8',
      'editorLineNumber.activeForeground': '#f8fafc',
      'editorCursor.foreground': '#f8fafc',
      'editor.selectionBackground': '#334155',
      'editor.inactiveSelectionBackground': '#1f2937',
      'editor.lineHighlightBackground': '#111827',
      'editorIndentGuide.background': '#374151',
      'editorIndentGuide.activeBackground': '#cbd5e1',
      'editorGutter.background': '#0f172a',
      'editorWidget.background': '#111827',
      'editorWidget.border': '#334155',
      'editorBracketMatch.background': '#1e3a8a',
      'editorBracketMatch.border': '#7dd3fc',
      'editor.findMatchBackground': '#f59e0b',
    },
  })
}

export interface IDEEditorProps {
  value: string
  onChange: (value: string) => void
  onRun: () => void
  onSave: () => void
  onCursorChange?: (position: { lineNumber: number; column: number }) => void
  theme: 'light' | 'dark'
  height?: string
  readOnly?: boolean
  wordWrap?: 'on' | 'off'
}

export function IDEEditor({
  value,
  onChange,
  onRun,
  onSave,
  onCursorChange,
  theme,
  height = '420px',
  readOnly = false,
  wordWrap = 'on',
}: IDEEditorProps) {
  const handleMount: OnMount = (editor, monaco) => {
    registerMonacoThemes(monaco)

    editor.addCommand(monaco.KeyMod.CtrlCmd | monaco.KeyCode.Enter, () => {
      onRun()
    })

    editor.addCommand(monaco.KeyMod.CtrlCmd | monaco.KeyCode.KeyS, () => {
      onSave()
    })

    editor.onDidChangeCursorPosition((event) => {
      onCursorChange?.({ lineNumber: event.position.lineNumber, column: event.position.column })
    })

    editor.focus()
  }

  return (
    <div className="eleven-ide-editor h-full min-h-[280px] w-full overflow-hidden rounded-b-xl border-t border-slate-200 bg-slate-50 dark:border-slate-700 dark:bg-slate-950">
      <Editor
        height={height}
        width="100%"
        language="python"
        value={value}
        theme={theme === 'dark' ? darkTheme : lightTheme}
        beforeMount={(monaco) => registerMonacoThemes(monaco)}
        onMount={handleMount}
        onChange={(nextValue) => onChange(nextValue ?? '')}
        options={{
          automaticLayout: true,
          minimap: { enabled: true, side: 'right' },
          scrollBeyondLastLine: false,
          padding: { top: 14, bottom: 14 },
          fontSize: 14,
          fontFamily: 'JetBrains Mono, Fira Code, monospace',
          lineNumbers: 'on',
          lineNumbersMinChars: 3,
          roundedSelection: true,
          tabSize: 4,
          insertSpaces: true,
          wordWrap,
          renderLineHighlight: 'all',
          cursorBlinking: 'smooth',
          smoothScrolling: true,
          autoClosingBrackets: 'always',
          autoClosingQuotes: 'always',
          quickSuggestions: true,
          folding: true,
          bracketPairColorization: { enabled: true },
          glyphMargin: false,
          readOnly: false,
          domReadOnly: false,
          contextmenu: true,
          mouseWheelZoom: false,
          find: { addExtraSpaceOnTop: true, autoFindInSelection: 'never' },
          fontLigatures: true,
          cursorStyle: 'line',
          tabFocusMode: false,
          acceptSuggestionOnCommitCharacter: true,
          acceptSuggestionOnEnter: 'on',
          wordBasedSuggestions: 'matchingDocuments',
          snippetSuggestions: 'inline',
        }}
      />
    </div>
  )
}
