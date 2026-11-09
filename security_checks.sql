-- Review roles, memberships, and effective table privileges.
SELECT rolname, rolsuper, rolcreaterole, rolcreatedb, rolcanlogin
FROM pg_roles
WHERE rolname IN ('app_read', 'app_write', 'api')
ORDER BY rolname;

SELECT
  has_database_privilege('api', current_database(), 'CONNECT') AS can_connect,
  has_schema_privilege('api', 'public', 'USAGE') AS can_use_public_schema,
  has_table_privilege('api', 'public.students', 'SELECT') AS can_select_students,
  has_table_privilege('api', 'public.students', 'INSERT') AS can_insert_students,
  has_table_privilege('api', 'public.students', 'UPDATE') AS can_update_students,
  has_table_privilege('api', 'public.students', 'DELETE') AS can_delete_students;
