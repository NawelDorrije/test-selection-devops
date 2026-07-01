#!/bin/bash

set -e

BACKUP_DIR="/backup"
LOG_FILE="/var/log/backup.log"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="backup_${TIMESTAMP}"
WORK_DIR="/tmp/${BACKUP_NAME}"

DB_CONTAINER="db"
ODOO_CONTAINER="odoo"
DB_NAME="odoo"
DB_USER="odoo"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | sudo tee -a "$LOG_FILE" > /dev/null
}

log "Starting backup ${BACKUP_NAME}"

mkdir -p "$WORK_DIR"
mkdir -p "$BACKUP_DIR"

log "Running pg_dump from PostgreSQL container"
docker exec "$DB_CONTAINER" pg_dump -U "$DB_USER" "$DB_NAME" > "$WORK_DIR/${DB_NAME}.sql"

log "Archiving Odoo filestore"
docker run --rm \
  -v apps_odoo-filestore:/odoo-filestore:ro \
  -v "$WORK_DIR":/backup-work \
  alpine \
  tar -czf /backup-work/odoo-filestore.tar.gz -C /odoo-filestore .

log "Creating final archive"
tar -czf "$BACKUP_DIR/${BACKUP_NAME}.tar.gz" -C "$WORK_DIR" .

log "Backup created: $BACKUP_DIR/${BACKUP_NAME}.tar.gz"

rm -rf "$WORK_DIR"

log "Backup finished successfully"
