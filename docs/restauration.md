# Runbook de restauration Odoo

## Prérequis

- Docker et Docker Compose installés
- Archive de sauvegarde disponible dans `/backup`

## 1. Arrêter la stack

```bash
docker compose down -v
```

## 2. Démarrer uniquement PostgreSQL

```bash
docker compose up -d db
```

## 3. Extraire la sauvegarde

```bash
mkdir -p /tmp/restore

tar -xzf /backup/backup_YYYYMMDD_HHMMSS.tar.gz -C /tmp/restore
```

## 4. Restaurer la base PostgreSQL

```bash
docker exec db createdb -U odoo odoo

docker exec -i db psql -U odoo odoo < /tmp/restore/odoo.sql
```

## 5. Restaurer le filestore

```bash
docker volume create apps_odoo-filestore

docker run --rm \
  -v apps_odoo-filestore:/restore \
  -v /tmp/restore:/backup \
  alpine \
  sh -c "cd /restore && tar -xzf /backup/odoo-filestore.tar.gz"
```

## 6. Démarrer la stack

```bash
docker compose up -d
```

## 7. Vérification

- Accéder à http://erp.local
- Vérifier que le module Ventes est présent.
- Vérifier que les données sont restaurées.
