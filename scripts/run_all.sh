#!/usr/bin/env bash
# Usage instructions:
# Modify all the paths here accordingly.
# Avoid using relative paths for safety.
# Execute `./run_all.sh <SF>` from inside the `scripts` folder.
# <SF> is the scale factor used to run the tests.

set -eu

SCALE_FACTOR=${1}

ROOT_PATH=""
DATA_PATH=""
CREATE_TABLES_FILE=""
QUERY_FILES_PATH=""
MAINTENANCE_DATA_PATH=""
MAINTENANCE_QUERY_FILES_PATH=""

DATA_PATH="${DATA_PATH}_sf_${SCALE_FACTOR}"
QUERY_FILES_PATH="${QUERY_FILES_PATH}_sf_${SCALE_FACTOR}"
MAINTENANCE_DATA_PATH="${MAINTENANCE_DATA_PATH}_sf_${SCALE_FACTOR}"
MAINTENANCE_QUERY_FILES_PATH="${MAINTENANCE_QUERY_FILES_PATH}_sf_${SCALE_FACTOR}"

python ./db_preprocess.py -rp ${ROOT_PATH} -dp ${DATA_PATH} -ct ${CREATE_TABLES_FILE} -sf ${SCALE_FACTOR}
python ./power_test.py -rp ${ROOT_PATH} -qp ${QUERY_FILES_PATH} -sf ${SCALE_FACTOR}
python ./throughput_test.py -rp ${ROOT_PATH} -qp ${QUERY_FILES_PATH} -sf ${SCALE_FACTOR}
python ./maintenance_test.py -rp ${ROOT_PATH} -dp ${MAINTENANCE_DATA_PATH} -qp ${MAINTENANCE_QUERY_FILES_PATH} -sf ${SCALE_FACTOR}
python ./throughput_test.py -rp ${ROOT_PATH} -qp ${QUERY_FILES_PATH} -sf ${SCALE_FACTOR}
python ./maintenance_test.py -rp ${ROOT_PATH} -dp ${MAINTENANCE_DATA_PATH} -qp ${MAINTENANCE_QUERY_FILES_PATH} -sf ${SCALE_FACTOR}

