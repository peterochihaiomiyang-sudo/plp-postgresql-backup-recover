-- V1: Core table prerequisite.
-- The training database already contains `students`; this migration checks
-- for that prerequisite without replacing or altering existing student data.
DO $$
BEGIN
  IF to_regclass('public.students') IS NULL THEN
    RAISE EXCEPTION
      'Required table public.students is missing. Create/restore it before applying this lab.';
  END IF;

  IF NOT EXISTS (
    SELECT 1
    FROM information_schema.columns
    WHERE table_schema = 'public'
      AND table_name = 'students'
      AND column_name = 'id'
  ) THEN
    RAISE EXCEPTION
      'Required column public.students.id is missing.';
  END IF;
END;
$$;
