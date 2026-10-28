#!/bin/bash
# ===================================================================
# run-batch.sh : Lance un batch dans son conteneur (theses-batch-anr ou theses-batch-datagouv)
# Usage :
#   ./scripts/run-batch.sh anr [options spring additionnelles...]
#   ./scripts/run-batch.sh datagouv [options spring additionnelles...]
# Le code de sortie est celui du batch : 0 = succès, autre valeur = échec.
# ===================================================================
set -euo pipefail

usage() {
    echo "Usage : $0 anr|datagouv [options spring additionnelles...]" >&2
    exit 2
}

[ $# -ge 1 ] || usage
BATCH="$1"
shift

case "${BATCH}" in
    anr)      CONTAINER_NAME="${CONTAINER_NAME_ANR:-theses-batch-anr}" ;;
    datagouv) CONTAINER_NAME="${CONTAINER_NAME_DATAGOUV:-theses-batch-datagouv}" ;;
    *)        usage ;;
esac

# Terminal interactif seulement s'il y en a un : le script reste utilisable depuis un autre script
TTY_OPTION=""
if [ -t 0 ] && [ -t 1 ]; then
    TTY_OPTION="-it"
fi

echo "-> Lancement du batch ${BATCH} dans le conteneur '${CONTAINER_NAME}'..."
# shellcheck disable=SC2086
exec sudo docker exec ${TTY_OPTION} "${CONTAINER_NAME}" "/scripts/theses-batch-${BATCH}.sh" "$@"
