#!/bin/bash
# ===================================================================
# run-anr.sh : Lance l'extraction ANR dans le conteneur theses-batch-anr
# Usage :
#   ./scripts/run-anr.sh
#   ./scripts/run-anr.sh [options spring additionnelles...]
# ===================================================================
set -euo pipefail

exec "$(dirname "$0")/run-batch.sh" anr "$@"
