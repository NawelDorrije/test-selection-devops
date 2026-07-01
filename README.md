# Test Technique Cloud & DevOps

## Présentation

Ce projet déploie une plateforme Odoo 17 avec PostgreSQL et un reverse proxy Nginx via Docker Compose.

## Prérequis

- Ubuntu 24.04
- Docker
- Docker Compose
- Git

## Démarrage (moins de 5 commandes)

```bash
git clone git@github.com:NawelDorrije/test-selection-devops.git
cd test-selection-devops/apps
cp .env.example .env
docker compose up -d
```

Accéder à :

http://erp.local

Ajouter dans `/etc/hosts` :

```
127.0.0.1 erp.local
```

---

## Sauvegarde

Exécuter :

```bash
cd apps
./backup.sh
```

Les sauvegardes sont créées dans :

```
/backup/
```

---

## Restauration

1. Arrêter la stack :

```bash
docker compose down -v
```

2. Démarrer PostgreSQL :

```bash
docker compose up -d db
```

3. Restaurer la base :

```bash
docker exec db createdb -U odoo odoo
docker exec -i db psql -U odoo odoo < /tmp/restore/odoo.sql
```

4. Restaurer le filestore :

```bash
docker volume create apps_odoo-filestore

docker run --rm \
-v apps_odoo-filestore:/restore \
-v /tmp/restore:/backup \
alpine \
sh -c "cd /restore && tar -xzf /backup/odoo-filestore.tar.gz"
```

5. Démarrer la stack :

```bash
docker compose up -d
```

Odoo est ensuite accessible via :

```
http://erp.local
```
