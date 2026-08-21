import { serve } from 'https://deno.land/std@0.177.0/http/server.ts'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
}

function parsePythonSnippet(raw: string) {
  const match = raw.match(/```(?:python)?\s*([\s\S]*?)```/i)
  return match?.[1]?.trim() || raw.trim()
}

function buildFallbackTeachingResponse(payload: any) {
  const code = payload?.code?.trim() || 'print("Hello Eleven")'
  const lesson = payload?.lessonName || 'this lesson'
  const chapter = payload?.chapterName || 'this chapter'
  const output = payload?.output || 'No output yet.'
  const error = payload?.error || ''
  const challenge = payload?.challengePrompt || 'This is a beginner Python challenge.'

  const guidance = `I can see your current code in ${lesson} inside ${chapter}.\n\nCurrent code:\n${code}\n\nCurrent output:\n${output}\n\n${error ? `Current error:\n${error}\n` : ''}\nI’m teaching you the idea rather than giving the direct final answer. The goal is to help you understand why this code behaves this way and what to try next. For a beginner challenge, the best next step is to identify the smallest change that makes the logic more readable or correct, then test it in the editor.`

  return `${guidance}\n\nChallenge context:\n${challenge}`
}

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  if (req.method !== 'POST') {
    return new Response(JSON.stringify({ error: 'Method not allowed' }), {
      status: 405,
      headers: { ...corsHeaders, 'content-type': 'application/json' },
    })
  }

  try {
    const payload = await req.json()
    const apiKey = Deno.env.get('ANTHROPIC_API_KEY')

    if (!apiKey) {
      return new Response(
        JSON.stringify({
          answer: buildFallbackTeachingResponse(payload),
          suggestion: null,
        }),
        {
          status: 200,
          headers: { ...corsHeaders, 'content-type': 'application/json' },
        },
      )
    }

    const challengePrompt = payload?.challengePrompt || 'This is a beginner Python challenge. Explain the logic, not the final answer.'
    const code = payload?.code || 'print("Hello Eleven")'
    const output = payload?.output || 'No output yet.'
    const error = payload?.error || ''
    const lessonName = payload?.lessonName || 'current lesson'
    const chapterName = payload?.chapterName || 'current chapter'
    const question = payload?.question || 'Explain this Python code for a beginner.'
    const action = payload?.action || 'explain'

    const systemPrompt = `You are Claude acting as a patient Python teacher for beginners in ELEVEN. Use the actual code and context provided by the student. Explain concepts clearly, in plain language, and do not give the final challenge solution directly unless the user clearly asks for a general improvement idea. When there is a challenge, teach the idea, explain the bug, and suggest a small safe experiment or modification instead of a full direct answer. Always keep the answer grounded in the code shown by the student. If the student asks to fix an error, explain the root cause and the smallest safe change.`

    const userMessage = `Action: ${action}\nLesson: ${lessonName}\nChapter: ${chapterName}\nChallenge: ${challengePrompt}\nQuestion: ${question}\n\nCurrent code:\n${code}\n\nCurrent output:\n${output}\n\nCurrent error:\n${error || 'No error currently.'}`

    const response = await fetch('https://api.anthropic.com/v1/messages', {
      method: 'POST',
      headers: {
        'content-type': 'application/json',
        'x-api-key': apiKey,
        'anthropic-version': '2023-06-01',
      },
      body: JSON.stringify({
        model: 'claude-3-5-sonnet-20241022',
        max_tokens: 700,
        system: systemPrompt,
        messages: [{ role: 'user', content: userMessage }],
      }),
    })

    const responseJson = await response.json()

    if (!response.ok) {
      throw new Error(responseJson?.error?.message || 'Anthropic request failed')
    }

    const answer = responseJson?.content?.[0]?.text || 'I can help explain this code step by step.'
    const suggestion = action === 'fix_error' || action === 'improve_code' ? parsePythonSnippet(answer) : null

    return new Response(
      JSON.stringify({
        answer,
        suggestion,
      }),
      {
        status: 200,
        headers: { ...corsHeaders, 'content-type': 'application/json' },
      },
    )
  } catch (error) {
    const message = error instanceof Error ? error.message : 'AI unavailable'

    return new Response(
      JSON.stringify({
        answer: `I can’t reach the Claude API right now, but I can still explain the code from the current context. Based on the editor state, the issue is likely around the actual code and runtime output shown to me. I’ll focus on the root cause and suggest the smallest next step instead of a direct final answer.\n\nTechnical note: ${message}`,
        suggestion: null,
      }),
      {
        status: 200,
        headers: { ...corsHeaders, 'content-type': 'application/json' },
      },
    )
  }
})
