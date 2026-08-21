import { IDE } from '@/components/ide/IDE'
import { BackButton } from '@/components/common/BackButton'

const DEFAULT_CODE = `name = "Mohamed"
print(f"Hello {name}")
print("Welcome to the Eleven Python Playground 🐍")
`

export default function PlaygroundPage() {
  return (
    <div className="mx-auto max-w-6xl space-y-5">
      <div className="flex items-center justify-between gap-3">
        <BackButton to="/dashboard" label="العودة إلى لوحة التحكم" />
      </div>

      <div className="space-y-2">
        <h1 className="text-2xl font-extrabold text-gray-900 dark:text-white">Python Playground</h1>
        <p className="text-sm text-gray-500 dark:text-gray-400">
          اكتب وتشغّل كود Python الحقيقي مباشرة داخل المتصفح.
        </p>
      </div>

      <IDE initialCode={DEFAULT_CODE} storageKey="eleven-playground-code" height="440px" title="Python" />
    </div>
  )
}
