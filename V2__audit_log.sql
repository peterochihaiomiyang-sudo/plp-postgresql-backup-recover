-- V2: Reusable JSONB audit log and students trigger.
CREATE TABLE IF NOT EXISTS public.audit_log (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  tbl TEXT NOT NULL,
  op TEXT NOT NULL,
  old_row JSONB,
  new_row JSONB,
  changed_by TEXT NOT NULL DEFAULT current_user,
  at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp()
);

CREATE OR REPLACE FUNCTION public.audit_row_change()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO public.audit_log(tbl, op, old_row, new_row)
    VALUES (TG_TABLE_NAME, TG_OP, NULL, to_jsonb(NEW));
    RETURN NEW;
  ELSIF TG_OP = 'UPDATE' THEN
    INSERT INTO public.audit_log(tbl, op, old_row, new_row)
    VALUES (TG_TABLE_NAME, TG_OP, to_jsonb(OLD), to_jsonb(NEW));
    RETURN NEW;
  ELSIF TG_OP = 'DELETE' THEN
    INSERT INTO public.audit_log(tbl, op, old_row, new_row)
    VALUES (TG_TABLE_NAME, TG_OP, to_jsonb(OLD), NULL);
    RETURN OLD;
  END IF;

  RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS trg_audit_students ON public.students;

CREATE TRIGGER trg_audit_students
AFTER INSERT OR UPDATE OR DELETE ON public.students
FOR EACH ROW
EXECUTE FUNCTION public.audit_row_change();
