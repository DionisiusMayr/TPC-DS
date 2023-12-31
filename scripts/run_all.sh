#!/usr/bin/env bash
# Usage instructions:
# Modify all the paths here accordingly.
# Avoid using relative paths for safety.
# Execute `./run_all.sh <SF>` from inside the `scripts` folder.
# <SF> is the scale factor used to run the tests.

set -eu

SCALE_FACTOR=${1}

ROOT_PATH=$(wslpath "D:/TPC-DS/DW_project")
DATA_PATH=$(wslpath "D:/TPC-DS/DW_project/Copy_data/data")
CREATE_TABLES_FILE=$(wslpath "D:/TPC-DS/DW_project/tpcds.sql")
QUERY_FILES_PATH=$(wslpath "D:/TPC-DS/DW_project/queries/queries")
MAINTENANCE_QUERY_FILES_PATH=$(wslpath "D:/TPC-DS/DW_project/maintenance/maintenance_data")

ROOT_PATH="${ROOT_PATH}/Results_SF_${SCALE_FACTOR}"
DATA_PATH="${DATA_PATH}_sf_${SCALE_FACTOR}.sql"
QUERY_FILES_PATH="${QUERY_FILES_PATH}_sf_${SCALE_FACTOR}_optimized"
MAINTENANCE_QUERY_FILES_PATH="${MAINTENANCE_QUERY_FILES_PATH}_sf_${SCALE_FACTOR}"

python3 ./load_test.py -rp ${ROOT_PATH} -dp ${DATA_PATH} -ct ${CREATE_TABLES_FILE} -sf ${SCALE_FACTOR}
python3 ./power_test.py -rp ${ROOT_PATH} -qp ${QUERY_FILES_PATH} -sf ${SCALE_FACTOR}
python3 ./throughput_test.py -rp ${ROOT_PATH} -qp ${QUERY_FILES_PATH} -sf ${SCALE_FACTOR}
python3 ./maintenance_test.py -rp ${ROOT_PATH} -mp ${MAINTENANCE_QUERY_FILES_PATH} -sf ${SCALE_FACTOR}
python3 ./throughput_test.py -rp ${ROOT_PATH} -qp ${QUERY_FILES_PATH} -sf ${SCALE_FACTOR}
python3 ./maintenance_test.py -rp ${ROOT_PATH} -mp ${MAINTENANCE_QUERY_FILES_PATH} -sf ${SCALE_FACTOR}
python3 ./db_postprocess.py -rp ${ROOT_PATH} -sf ${SCALE_FACTOR}

