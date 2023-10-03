#!/usr/bin/env bash
# xargs would be more ellegant here.
# Avoid using relative paths here for safety.

SCALE_FACTOR=1
TARGET_DIR="/home/dionisius/bdma/ulb/data_warehouses/TPC-DS/workspace/sc_${SCALE_FACTOR}"
DSDGEN_PATH="/home/dionisius/bdma/ulb/data_warehouses/TPC-DS/DSGen-software-code-3.2.0rc1/tools/"

# There is a `delimiter` argument as well, but the default `|` works just fine.
OPTIONS="-scale ${SCALE_FACTOR} -dir ${TARGET_DIR} -terminate N -force Y -parallel 4"

echo "Writing data to ${TARGET_DIR}"
mkdir -p ${TARGET_DIR}
pushd ${DSDGEN_PATH}

./dsdgen ${OPTIONS} -child 4 &
./dsdgen ${OPTIONS} -child 3 &
./dsdgen ${OPTIONS} -child 2 &
./dsdgen ${OPTIONS} -child 1

echo "Done!"
popd
