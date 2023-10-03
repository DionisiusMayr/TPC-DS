#!/usr/bin/env bash

DATA_DIR="/home/dionisius/bdma/ulb/data_warehouses/TPC-DS/workspace/sc_1"
OUTPUT_SCRIPT_PATH="/home/dionisius/bdma/ulb/data_warehouses/TPC-DS/scripts/load_data.sql"

if [ -f ${OUTPUT_SCRIPT_PATH} ]; then
    echo "Found a previous ${OUTPUT_SCRIPT_PATH}"
    rm -i ${OUTPUT_SCRIPT_PATH}
fi

for file in ${DATA_DIR}/*
do
    echo "Adding file ${file}..."

    NO_EXTENSION=${file::-8}
    TABLE=${NO_EXTENSION##*/}
    # There are multiple possible encodings for ISO-8859.
    # Let's try to use the LATIN1 one.
    # https://www.postgresql.org/docs/current/multibyte.html#MULTIBYTE-CHARSET-SUPPORTED
    COMMAND="COPY ${TABLE} FROM '${file}' DELIMITER '|' NULL '' ENCODING 'LATIN1';"

    echo "${COMMAND}" >> ${OUTPUT_SCRIPT_PATH}
done

echo "Done!"

