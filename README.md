# PostgreSQL Backup and Recovery Lab

**PLP Software Engineering Training**

## Project Overview

This project demonstrates PostgreSQL database backup, Write-Ahead Logging (WAL) archiving, streaming replication, and Point-in-Time Recovery (PITR).

## Tasks Completed

### 1. Base Backup
Created a PostgreSQL base backup using `pg_basebackup`.

### 2. WAL Archiving
Configured WAL archiving and verified that WAL files were saved in the archive directory.

### 3. Streaming Replication
Created a standby server and verified that it was receiving data from the primary server.

### 4. Point-in-Time Recovery (PITR)
Restored a separate database copy using the base backup and archived WAL files.

Configured recovery to stop at:

`2026-11-06 12:30:00 UTC`

### 5. Final Verification

The following PostgreSQL checks were successful:

```sql
SELECT pg_is_in_recovery();
```

Result: `t`

```sql
SELECT pg_is_wal_replay_paused(), pg_is_in_recovery();
```

Result: `t | t`

This confirmed that the recovery server was in recovery mode and WAL replay was paused at the configured recovery boundary.

## Screenshot Evidence

[View PITR Success Screenshot](postgresql-pitr-success.png)

## Tools Used

- PostgreSQL 16
- Linux terminal
- GitHub Codespaces
- GitHub

## Conclusion

Successfully completed the PostgreSQL backup and recovery lab, including base backup creation, WAL archiving, streaming replication, and point-in-time recovery.
