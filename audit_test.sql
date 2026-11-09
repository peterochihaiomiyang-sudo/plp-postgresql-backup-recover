-- Audit trigger smoke test.
-- Uses a generated test id and leaves existing student records untouched.
BEGIN;

-- This assumes students.id is generated automatically and students.name is
-- the only required non-generated column. Add any other required columns
-- from your own table definition if necessary.
DO $$
DECLARE
  test_id BIGINT;
BEGIN
  INSERT INTO public.students(name)
  VALUES ('AUDIT_TEST_ROW')
  RETURNING id INTO test_id;

  UPDATE public.students
  SET name = 'AUDIT_TEST_ROW_UPDATED'
  WHERE id = test_id;

  DELETE FROM public.students
  WHERE id = test_id;
END;
$$;

SELECT tbl, op,
       old_row->>'name' AS was,
       new_row->>'name' AS now,
       changed_by, at
FROM public.audit_log
WHERE COALESCE(old_row->>'name', '') LIKE 'AUDIT_TEST_ROW%'
   OR COALESCE(new_row->>'name', '') LIKE 'AUDIT_TEST_ROW%'
ORDER BY id;

COMMIT;
