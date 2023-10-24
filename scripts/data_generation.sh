#!/usr/bin/env bash
# Usage instructions:
# Modify the paths of `TARGET_DIR` and `DSDGEN_PATH` accordingly.
# Avoid using relative paths here for safety.
# Execute `./data_generation.sh <SF>` from inside the `scripts` folder.
# <SF> is the scale factor used to generate the data.
# As a result, the `TARGET_DIR` will contain the data generated (both throughput and maintenance).

set -eu

SCALE_FACTOR=${1}
RNG_SEED=1
DSDGEN_PATH="/home/dionisius/bdma/ulb/data_warehouses/TPC-DS/DSGen-software-code-3.2.0rc1/tools/"

# There is a `delimiter` argument as well, but the default `|` works just fine.
TARGET_DIR="/home/dionisius/bdma/ulb/data_warehouses/TPC-DS/data/sc_${SCALE_FACTOR}"
OPTIONS="-scale ${SCALE_FACTOR} -dir ${TARGET_DIR} -terminate N -force Y -rngseed ${RNG_SEED} -parallel 4"

# Throughput Data
echo "Writing data to ${TARGET_DIR}"
mkdir -p ${TARGET_DIR}
pushd ${DSDGEN_PATH}

./dsdgen ${OPTIONS} -child 4 &
./dsdgen ${OPTIONS} -child 3 &
./dsdgen ${OPTIONS} -child 2 &
./dsdgen ${OPTIONS} -child 1

echo "Finished generating throughput data."

# Maintenance Data
TARGET_DIR="/home/dionisius/bdma/ulb/data_warehouses/TPC-DS/data/maintenance_sc_${SCALE_FACTOR}"
OPTIONS="-scale ${SCALE_FACTOR} -dir ${TARGET_DIR} -terminate N -force Y -rngseed ${RNG_SEED} -update 1 -parallel 4"
echo "Writing data to ${TARGET_DIR}"
mkdir -p ${TARGET_DIR}

./dsdgen ${OPTIONS} -child 4 &
./dsdgen ${OPTIONS} -child 3 &
./dsdgen ${OPTIONS} -child 2 &
./dsdgen ${OPTIONS} -child 1

echo "Finished generating maintenance data."

echo "Done!"

popd

