# theses-batch-docker 🐳

Configuration Docker Compose pour déployer les batchs de l'application **theses-batch** :
1. **`theses-batch-anr`** : Extraction et enrichissement Solr des financements ANR dans les thèses PDF.
2. **`theses-batch-datagouv`** : Export semestriel et téléversement des thèses soutenues vers data.gouv.fr (formats CSV, JSON, JSONL, JSONL.gz).

Les deux conteneurs s'appuient sur la **même image Docker** (`abesesr/theses:batch-latest`), tournent en permanence pour être supervisés par **WUD**, et partagent le **même fichier `.env`**.

---

## Démarrage rapide

### 1. Configuration de l'environnement
Copier le fichier d'exemple et adapter les variables selon le serveur :
```bash
cp .env-dist .env
```

### 2. Démarrage des conteneurs
```bash
docker compose up -d
```
Les deux conteneurs démarrent et restent actifs en continu pour la surveillance par **WUD** :
- `theses-batch-anr` reste en veille prêt pour l'exécution à la demande via `./scripts/run-anr.sh`.
- `theses-batch-datagouv` exécute **cronie** en continu pour planifier automatiquement le job selon l'expression cron (`THESES_BATCH_DATAGOUV_CRON`, par défaut tous les jours à 2h00 pour évaluer la règle des 6 mois).

---

## Déclenchement manuel

Les scripts du dossier `scripts/` lancent les batchs à tout moment depuis l'hôte (via `docker exec`).
Leur code de sortie est celui du batch : 0 = succès, autre valeur = échec (le conteneur continue de tourner).

* **Lancer le batch ANR :**
  ```bash
  ./scripts/run-anr.sh
  ```
  *(ou avec des options : `./scripts/run-anr.sh --app.anr.max-files=100`)*

* **Lancer le batch Datagouv (toujours forcé : la règle des 6 mois ne s'applique qu'au cron) :**
  ```bash
  ./scripts/run-datagouv.sh
  ```

* **Script générique** (utilisé par les deux précédents, sans forçage pour Datagouv) :
  ```bash
  ./scripts/run-batch.sh anr|datagouv [options spring additionnelles...]
  ```

`THESES_API_BASE_URL` n'a pas de valeur par défaut : si elle est vide, le batch Datagouv refuse de démarrer (le batch ANR n'est pas concerné).

---

## Consultation des logs

```bash
docker compose logs -f theses-batch-anr
docker compose logs -f theses-batch-datagouv
```
