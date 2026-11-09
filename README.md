# PostgreSQL Backup, Point-in-Time Recovery, and Replication Lab

**PLP Software Engineering Training**

## Project Overview

This project demonstrates PostgreSQL database backup, Write-Ahead Logging (WAL) archiving, Point-in-Time Recovery (PITR), and streaming replication.

## Technologies Used

- PostgreSQL 16
- SQL
- Linux / Ubuntu
- GitHub Codespaces
- GitHub

## Tasks Completed

### 1. Logical Backup and Verification

- Created a logical backup of the `bootcamp` database using `pg_dump`.
- Verified the backup using `pg_restore --list`.
- Restored the backup into a separate test database.

### 2. WAL Archiving and Base Backup

- Configured `wal_level = replica`.
- Enabled WAL archiving.
- Created a WAL archive directory.
- Created a physical base backup.
- Verified the base backup using `pg_verifybackup`.

### 3. Point-in-Time Recovery (PITR)

- Created a separate recovery directory from the base backup.
- Configured recovery using `recovery.signal`.
- Set the recovery target time to:

`2026-11-06 12:30:00 UTC`

- Started PostgreSQL on a separate port.
- Verified the recovery status.

### 4. Streaming Replication

- Created a replication role named `replicator`.
- Configured replication access in `pg_hba.conf`.
- Created a standby server using `pg_basebackup`.
- Confirmed that the standby connected to the primary server.

### 5. Replication Health Monitoring

- Checked the WAL receiver status.
- Verified streaming replication.
- Inserted a test record on the primary database.
- Confirmed that the record appeared on the standby database.

## Verification Evidence

The following PostgreSQL checks were successful:

```sql
SELECT pg_is_in_recovery();
```

Result: `t`

```sql
SELECT pg_is_wal_replay_paused(), pg_is_in_recovery();
```

Result: `t | t`

These results confirmed that the PITR recovery server was in recovery mode and WAL replay was paused at the configured recovery boundary.

## Screenshot Evidence

See the uploaded screenshot:

`postgresql-pitr-success.png`

## Conclusion

Successfully completed the PostgreSQL backup and recovery lab.

The exercise demonstrated logical backups, physical base backups, WAL archiving, point-in-time recovery, streaming replication, and replication monitoring.

These techniques help protect databases against accidental data loss and support database availability.

## GitHub Repository

https://github.com/peterochihaiomiyang-sudo/plp-postgresql-backup-recover
