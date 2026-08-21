import { supabase } from '@/lib/supabase'

export type AIAssistantAction = 'explain' | 'fix_error' | 'improve_code' | 'custom'

export interface AIAssistantPayload {
  action: AIAssistantAction
  code: string
  output?: string
  error?: string | null
  lessonName?: string
  chapterName?: string
  challengePrompt?: string
  question?: string
}

export interface AIResponse {
  answer: string
  suggestion?: string | null
}

function extractPythonBlock(text: string) {
  const match = text.match(/```(?:python)?\s*([\s\S]*?)```/i)
  if (match?.[1]) return match[1].trim()
  return text.trim()
}

function buildFallbackEducationalResponse(payload: AIAssistantPayload): string {
  const codePreview = payload.code.trim() || 'لا يوجد كود حالي.'
  const lessonContext = payload.lessonName ? `في درس ${payload.lessonName}` : 'في هذا المثال'
  const chapterContext = payload.chapterName ? ` ضمن ${payload.chapterName}` : ''

  if (payload.action === 'fix_error' && payload.error) {
    return `أستطيع رؤية الخطأ الحالي في الكود ${lessonContext}${chapterContext}.\n\nالخطأ: ${payload.error}\n\nأول شيء ألاحظه هو أن الكود الحالي هو:\n${codePreview}\n\nفي تعليم Python للمبتدئين، عادةً نبدأ من: 1) التحقق من القيم والأنواع، 2) التحقق من السطر الذي يسبب الخطأ، 3) التأكد من بناء الجملة والوظائف. لا أحتاج إلى إعطاء حل نهائي مباشرة؛ سأساعدك على فهم سبب المشكلة ثم نعدل السطر المناسب معًا.`
  }

  if (payload.action === 'improve_code') {
    return `أستطيع رؤية الكود الحالي في هذا المشروع ${lessonContext}${chapterContext}. هذا الكود يعمل كقاعدة جيدة، لكن يمكن تحسينه بشكل تدريجي: 1) جعل المتغيرات أوضح، 2) تقسيم المهمة إلى خطوات منطقية، 3) إضافة التعليقات عند الحاجة، 4) استخدام أسماء ذات معنى.\n\nالكود الحالي:\n${codePreview}\n\nإذا أردت، أستطيع اقتراح نسخة أفضل بأسلوب تعليمي ومناسب لمبتدئ، مع إبقاء الفكرة واضحة وسهلة للفهم.`
  }

  if (payload.action === 'custom' && payload.question) {
    return `أستطيع أن أجيب بناءً على الكود الحالي ${lessonContext}${chapterContext}.\n\nالسؤال: ${payload.question}\n\nالكود الحالي:\n${codePreview}\n\nأركز على شرح الفكرة بدل إعطاء حل جاهز عند وجود تحدي. سأشرح ما يحدث خطوة بخطوة، لماذا هذا السطر مهم، وكيف يمكن تعديل الكود بنفسك أو بتلميح بسيط.`
  }

  return `أستطيع رؤية الكود الحالي ${lessonContext}${chapterContext}.\n\nالكود:\n${codePreview}\n\nإذا كانت هناك قيمة خرج، فهي: ${payload.output || 'لا يوجد خرج حالي.'}\n\nفي هذا السياق أشرح لك ما يحدث خطوة بخطوة، وأركز على الفكرة التعليمية بدل إعطاء إجابة جاهزة في التحديات. يمكنني أيضًا إظهار فكرة التصميم الصحيحة، أو اقتراح تعديل لنسخة أفضل بعد موافقتك.`
}

function buildFallbackSuggestion(payload: AIAssistantPayload) {
  if (payload.action === 'fix_error' && payload.error) {
    return `# مثال توضيحي للتصحيح\n${payload.code.trim() || 'print("Hello Eleven")'}`
  }

  if (payload.action === 'improve_code') {
    return payload.code.trim() || 'print("Hello Eleven")'
  }

  return null
}

export async function askAIAssistant(payload: AIAssistantPayload): Promise<AIResponse> {
  try {
    const { data, error } = await supabase.functions.invoke('eleven-ai', { body: payload })

    if (error) throw error

    const answer = typeof data?.answer === 'string' ? data.answer : 'I can help explain this code.'
    const suggestion = typeof data?.suggestion === 'string' ? data.suggestion : null

    return {
      answer,
      suggestion: suggestion ? extractPythonBlock(suggestion) : null,
    }
  } catch {
    return {
      answer: buildFallbackEducationalResponse(payload),
      suggestion: buildFallbackSuggestion(payload),
    }
  }
}
