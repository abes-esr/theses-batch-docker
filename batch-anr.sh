#!/bin/bash
# Lance l'extraction ANR dans le conteneur theses-batch
# Usage : ./batch-anr.sh [options spring supplémentaires]
set -euo pipefail

sudo docker exec theses-batch /scripts/theses-batch.sh \
  --logging.level.fr.theses.batch.job.processor.ANRProcessor=DEBUG \
  "$@"
