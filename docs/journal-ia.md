# Journal d'utilisation de l'IA

## Prompt 1

### Prompt

Créer un docker-compose.yml avec Odoo 17, PostgreSQL 15, un réseau privé, un fichier .env et un .env.example.

### Réponse générée

L'IA a généré un fichier docker-compose.yml contenant les services PostgreSQL et Odoo avec les variables d'environnement.

### Modifications

- Ajout des volumes Docker nommés.
- Correction des variables d'environnement.
- Adaptation de la configuration au sujet du test.

### Pourquoi

Pour respecter exactement les exigences du test technique.

---

## Prompt 2

### Prompt

Créer une configuration Nginx permettant d'accéder à Odoo via http://erp.local.

### Réponse générée

L'IA a proposé un reverse proxy Nginx.

### Modifications

- Correction de la configuration du proxy.
- Résolution des problèmes DNS entre les conteneurs.
- Ajout de l'entrée dans /etc/hosts.

### Pourquoi

Pour obtenir un accès fonctionnel via erp.local.

---

## Prompt 3

### Prompt

Créer un script Bash permettant de sauvegarder PostgreSQL et le filestore Odoo.

### Réponse générée

L'IA a généré un script utilisant pg_dump et une archive tar.gz.

### Modifications

- Ajout de la journalisation.
- Adaptation des chemins.
- Vérification de la restauration.

### Pourquoi

Pour satisfaire les critères de la partie Sauvegarde & Restauration.

---

# Ce que j'ai appris

Cette journée m'a permis de mieux comprendre Docker Compose, les volumes Docker, la sauvegarde et restauration PostgreSQL, le reverse proxy Nginx, la planification avec Cron ainsi que les bonnes pratiques Git dans un projet DevOps.
