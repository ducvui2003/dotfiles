#!/bin/bash

# ----------------------
# SESSION CREDENTIALS
# ----------------------
if [[ -z "$PGUSER" ]]; then
    read -p "Enter PostgreSQL username: " PGUSER
    read -s -p "Enter PostgreSQL password: " PGPASSWORD
    echo
    read -p "Enter PostgreSQL host (default 127.0.0.1): " PGHOST
    PGHOST=${PGHOST:-127.0.0.1}
    read -p "Enter PostgreSQL port (default 5432): " PGPORT
    PGPORT=${PGPORT:-5432}
fi

export PGPASSWORD

# ----------------------
# BACKUP DIRECTORY
# ----------------------
BACKUP_ROOT="$(dirname "$PWD")/postgres"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# ----------------------
# UTILITY FUNCTIONS
# ----------------------
mkdir_safe() {
    mkdir -p "$1" || { echo "❌ Failed to create directory $1"; exit 1; }
}

run_cmd() {
    "$@" || { echo "❌ Command failed: $*"; return 1; }
}

# ----------------------
# BACKUP FUNCTIONS
# ----------------------
backup_all() {
    read -p "Enter a postfix for this backup folder (optional): " POSTFIX
    BACKUP_DIR="$BACKUP_ROOT/$DATE"
    [[ -n "$POSTFIX" ]] && BACKUP_DIR="${BACKUP_DIR}_$POSTFIX"
    mkdir_safe "$BACKUP_DIR"

    echo "Backing up all databases to $BACKUP_DIR..."

    databases=$(psql -h "$PGHOST" -U "$PGUSER" -p "$PGPORT" -d postgres -t -c "SELECT datname FROM pg_database WHERE datistemplate = false;")

    for db in $databases; do
        [[ "$db" =~ ^(postgres)$ ]] && continue
        FILE="$BACKUP_DIR/$db.sql"
        echo "Dumping $db -> $FILE"
        run_cmd pg_dump -h "$PGHOST" -U "$PGUSER" -p "$PGPORT" -d "$db" -F p > "$FILE"
    done

    echo "✅ Backup complete."
}

backup_select() {
    read -p "Enter a postfix for this backup folder (optional): " POSTFIX
    BACKUP_DIR="$BACKUP_ROOT/$DATE"
    [[ -n "$POSTFIX" ]] && BACKUP_DIR="${BACKUP_DIR}_$POSTFIX"
    mkdir_safe "$BACKUP_DIR"

    echo "Enter databases to backup (space-separated):"
    read -r dbs
    if [[ -z "$dbs" ]]; then
        echo "❌ No databases entered. Aborting."
        return
    fi

    for db in $dbs; do
        FILE="$BACKUP_DIR/$db.sql"
        echo "Dumping $db -> $FILE"
        run_cmd pg_dump -h "$PGHOST" -U "$PGUSER" -p "$PGPORT" -d "$db" -F p > "$FILE"
    done

    echo "✅ Backup complete."
}

# ----------------------
# RESTORE FUNCTIONS
# ----------------------
restore_all() {
    echo "Enter the backup folder (full path):"
    read -r folder
    if [[ ! -d "$folder" ]]; then
        echo "❌ Folder not found!"
        return
    fi

    for file in "$folder"/*.sql; do
        db=$(basename "$file" .sql)
        echo "Restoring $db from $file..."

        run_cmd psql -h "$PGHOST" -U "$PGUSER" -p "$PGPORT" -d postgres -c "CREATE DATABASE \"$db\";"
        run_cmd psql -h "$PGHOST" -U "$PGUSER" -p "$PGPORT" -d "$db" < "$file"
    done

    echo "✅ Restore complete."
}

restore_single() {
    echo "Enter the backup folder (full path):"
    read -r folder
    if [[ ! -d "$folder" ]]; then
        echo "❌ Folder not found!"
        return
    fi

    echo "Enter the database name to restore:"
    read -r db
    FILE="$folder/$db.sql"

    if [[ ! -f "$FILE" ]]; then
        echo "❌ File $FILE not found!"
        return
    fi

    echo "Restoring $db from $FILE..."

    run_cmd psql -h "$PGHOST" -U "$PGUSER" -p "$PGPORT" -d postgres -c "CREATE DATABASE \"$db\";"
    run_cmd psql -h "$PGHOST" -U "$PGUSER" -p "$PGPORT" -d "$db" < "$FILE"

    echo "✅ Restore of $db complete."
}

# ----------------------
# MAIN MENU LOOP
# ----------------------
while true; do
    echo
    echo "Choose an option:"
    echo "1) Backup all databases"
    echo "2) Backup selected databases"
    echo "3) Restore all databases from backup"
    echo "4) Restore a single database from backup"
    echo "5) Exit"
    read -r choice

    case $choice in
        1) backup_all ;;
        2) backup_select ;;
        3) restore_all ;;
        4) restore_single ;;
        5) exit 0 ;;
        *) echo "❌ Invalid choice";;
    esac
done