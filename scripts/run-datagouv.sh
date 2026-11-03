#!/bin/bash
# ===================================================================
# run-datagouv.sh : Lance le dump data.gouv dans le conteneur theses-batch-datagouv
# Usage :
#   ./scripts/run-datagouv.sh
#   ./scripts/run-datagouv.sh [options spring additionnelles...]
# Le lancement manuel force toujours l'exécution : la règle des 6 mois ne s'applique qu'au cron.
# ===================================================================
set -euo pipefail

exec "$(dirname "$0")/run-batch.sh" datagouv --app.datagouv.force-run=true "$@"
