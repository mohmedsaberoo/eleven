import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL as string
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY as string

if (!supabaseUrl || !supabaseAnonKey) {
  console.error(
    'Missing Supabase environment variables. Copy .env.example to .env and fill VITE_SUPABASE_URL / VITE_SUPABASE_ANON_KEY.'
  )
}

// IMPORTANT: only the public anon key is used on the client.
// The service_role key must NEVER be shipped to the frontend.
//
// NOTE ON TYPES: we intentionally don't pass a `Database` generic here.
// supabase-js's generated-types generic requires precise literal table/row
// shapes (via `supabase gen types typescript`) to type `.from()` and `.rpc()`
// calls correctly; a hand-written placeholder generic resolves every table
// and RPC argument to `never` and breaks the whole app's type-checking.
// The concrete row shapes for each table already live in
// `src/types/database.types.ts` and are used explicitly at each call site
// in `src/services/content.ts`, which gives the same safety where it matters
// without fighting the generic. Once the project is connected to a real
// Supabase instance, run `supabase gen types typescript` and wire the
// generated `Database` type back in for full end-to-end inference.
export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  auth: {
    persistSession: true,
    autoRefreshToken: true,
    detectSessionInUrl: true,
  },
})

