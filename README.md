# PostgreSQL Audit Logging, Category Trees, and Safe Migrations

**PLP Software Engineering Training**

## Project overview

This lab demonstrates trigger-based audit logging, hierarchical category data,
versioned schema migrations with Flyway, and least-privilege database roles.

**Database:** PostgreSQL 16  
**Migration tool:** Flyway  
**Environment:** Linux / GitHub Codespaces

## Lab tasks

1. Create a reusable JSONB audit log and attach a trigger to `students`.
2. Verify that inserts, updates, and deletes are recorded.
3. Model categories with a self-referencing `parent_id` and query the hierarchy
   using a recursive CTE.
4. Organize schema changes into ordered Flyway migrations.
5. Create read/write roles and grant only the permissions they need.

## Repository structure

```text
.
├── README.md
├── migrations/
│   ├── V1__core_tables.sql
│   ├── V2__audit_log.sql
│   ├── V3__categories.sql
│   └── V4__least_privilege_roles.sql
└── verification/
    ├── audit_test.sql
    ├── category_tree_test.sql
    └── security_checks.sql
```

## Before running

- Connect to the intended `bootcamp` database.
- Take a backup before applying schema changes.
- Check that the `students` table exists and has an `id` column.
- Do not commit real passwords or database credentials.
- The audit test uses a clearly marked test row and removes it after recording
  the test events. Review the SQL before running it.
- Flyway migrations are versioned and should not be edited after they have
  been applied. Create a new migration for later changes.

## Apply migrations

From the repository root, configure Flyway for your environment, then run:

```bash
flyway -url="jdbc:postgresql://localhost:5433/bootcamp" \
  -user="codespace" migrate

flyway -url="jdbc:postgresql://localhost:5433/bootcamp" \
  -user="codespace" info
```

Adjust host, port, and username to match your PostgreSQL connection. Ensure the
Flyway PostgreSQL driver is available to your Flyway installation.

## Verify

Run the SQL files in `verification/` using `psql`:

```bash
psql -h "$HOME" -p 5433 -U codespace -d bootcamp \
  -f verification/audit_test.sql

psql -h "$HOME" -p 5433 -U codespace -d bootcamp \
  -f verification/category_tree_test.sql

psql -h "$HOME" -p 5433 -U codespace -d bootcamp \
  -f verification/security_checks.sql
```

## Security note

The migration creates the `api` login role without embedding a password in
source control. Set its password interactively on the database:

```sql
\password api
```

Use a unique secret and do not place it in this repository.

## Evidence to add before submission

After running the lab, add screenshots or copied terminal output showing:

- audit rows for INSERT, UPDATE, and DELETE;
- the recursive category tree output;
- successful `flyway migrate` and `flyway info`;
- role memberships and grants.

Do not describe a step as completed until its command has run successfully and
the result has been checked.

## Conclusion

This project provides a repeatable structure for recording data changes,
querying hierarchical data, managing schema evolution, and limiting database
permissions.
