#!/usr/bin/env bash
# Usage instructions:
# Modify the paths of `TARGET_DIR` and `DSDGEN_PATH` accordingly.
# Avoid using relative paths here for safety.
# Execute `./data_generation.sh <SF>` from inside the `scripts` folder.
# <SF> is the scale factor used to generate the data.
# As a result, the `TARGET_DIR` will contain the data generated.
#
# Obs: `xargs` would be more ellegant here.

SCALE_FACTOR=$1
TARGET_DIR="/home/dionisius/bdma/ulb/data_warehouses/TPC-DS/data/sc_${SCALE_FACTOR}"
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
