@echo off
set BACKUPDIR="backupdir for monthly retention"
set PGHOST="host ip"
set PGUSER="user"
set PGBIN="C:\Program Files\PostgreSQL\10\bin\"

for /f "tokens=1-4 delims=/ " %%i in ("%date%") do (
 set dow=%%i
 set month=%%j
 set day=%%k
 set year=%%l
)
REM Set doctype for restoring layer_style in postgis
echo SET XML OPTION DOCUMENT; > %BACKUPDIR%%year%%month%%day%_fullpgbackup.sql

REM Append the pg_dump
%PGBIN%pg_dumpall -h %PGHOST% -U %PGUSER% >> %BACKUPDIR%%year%%month%%day%_fullpgbackup.sql

REM Clean up backups older than (6) Months
forfiles /p %BACKUPDIR% /m *.sql /d -183 /c "CMD /c del @path"







