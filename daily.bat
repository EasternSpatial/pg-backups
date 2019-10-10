@echo off
set BACKUPDIR="backupdir"
set PGHOST="host ip"
set PGUSER="user"
set PGBIN="C:\Program Files\PostgreSQL\10\bin\"
set PGDB="dbname"

for /f "tokens=1-4 delims=/ " %%i in ("%date%") do (
 set dow=%%i
 set month=%%j
 set day=%%k
 set year=%%l
)
REM Set doctype for restoring layer_style in postgis
echo SET XML OPTION DOCUMENT; > %BACKUPDIR%%year%%month%%day%_%PGDB%_dailybackup.sql

REM Append the pg_dump
%PGBIN%pg_dump -d %PGDB% -h %PGHOST% -U %PGUSER% >> %BACKUPDIR%%year%%month%%day%_%PGDB%_dailybackup.sql

REM Clean up daily backups older than (7) days
forfiles /p %BACKUPDIR% /m *.sql /d -7 /c "CMD /c del @path"

