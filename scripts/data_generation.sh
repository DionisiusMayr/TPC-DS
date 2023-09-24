#!/usr/bin/env bash
# xargs would be more ellegant here.
# Avoid using relative paths here for safety.

SCALE_FACTOR=1
TARGET_DIR="/home/dionisius/Documents/academics/universities/bdma/ulb/data_warehouses/data/sc_${SCALE_FACTOR}"
DSDGEN_PATH="/home/dionisius/Documents/academics/universities/bdma/ulb/data_warehouses/tpc_ds/DSGen-software-code-3.2.0rc1/tools/"

mkdir -p ${TARGET_DIR}
pushd ${DSDGEN_PATH}

./dsdgen -scale ${SCALE_FACTOR} -dir ${TARGET_DIR} -parallel 4 -child 1 &
./dsdgen -scale ${SCALE_FACTOR} -dir ${TARGET_DIR} -parallel 4 -child 2 &
./dsdgen -scale ${SCALE_FACTOR} -dir ${TARGET_DIR} -parallel 4 -child 3 &
./dsdgen -scale ${SCALE_FACTOR} -dir ${TARGET_DIR} -parallel 4 -child 4

popd
