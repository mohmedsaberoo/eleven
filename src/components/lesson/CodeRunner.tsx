import { IDE } from '@/components/ide/IDE'

export function CodeRunner({
  initialCode,
  height = '180px',
  storageKey,
  lessonName,
  chapterName,
  challengePrompt,
}: {
  initialCode: string
  height?: string
  storageKey?: string
  lessonName?: string
  chapterName?: string
  challengePrompt?: string
}) {
  return (
    <IDE
      initialCode={initialCode}
      storageKey={storageKey ?? `eleven_code_runner_${Date.now()}`}
      title="Python"
      height={height}
      lessonName={lessonName}
      chapterName={chapterName}
      challengePrompt={challengePrompt}
    />
  )
}
