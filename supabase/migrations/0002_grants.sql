-- ============================================================
-- Eleven — Migration 0002b: Explicit role grants
-- Supabase projects normally pre-configure default privileges for the
-- anon/authenticated roles at project creation time, so this step is
-- usually redundant on Supabase itself. It's included here defensively
-- so the schema is fully self-contained and works even if default
-- privileges were altered, revoked, or when testing against vanilla
-- Postgres. RLS policies (0002_rls.sql) remain the real row-level gate;
-- these GRANTs only unlock table-level access for roles to reach that gate.
-- ============================================================

grant usage on schema public to anon, authenticated;

grant select, insert, update, delete on all tables in schema public to authenticated;
grant select on all tables in schema public to anon;

grant usage, select on all sequences in schema public to authenticated, anon;

-- Make sure future tables created in this schema inherit the same defaults.
alter default privileges in schema public
  grant select, insert, update, delete on tables to authenticated;
alter default privileges in schema public
  grant select on tables to anon;
