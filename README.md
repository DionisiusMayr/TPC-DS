# TPC DS

## Data Generation

Required packages:
`apt install flex yacc`

Change the makefile line 58 to `LINUX_CFLAGS    = -g -Wall -fcommon` (i.e. add the `-fcommon` flag to make newer versions of GCC compatible with the code provided).

Run with `make clean && make -B`

### Script to generate data

There is a script inside `scripts/data_generation.sh` that can be used to generate the data using multiple processes.

To use it, keep in mind that it is necessary to specify the paths inside the script.
I.e. it is necessary to adjust the `TARGET_DIR` and `DSDGEN_PATH` accordingly.

After that, execute the script with
```sh
./data_generation.sh <SF>
```

Where `<SF>` is the target Scale Factor of the data.

## Creating the tables

There is a file `tpcds.sql` inside the `tools` folder that contains all the necessary DDL to create the tables.

## Loading the data into Postgres

There is another utility script (`load_data.sh`) that can be used to generate SQL code (`load_data.sql`) to load all data to Postgres.

As usual, one need to adjust the paths inside the script accordingly.

## Query Generation

In `scripts/query_generation.sh` you can find a script that generates all the 99 queries.

To use it, just execute from withing the `scripts` folder:

```sh
query_generation.sh <SF>
```

Where `<SF>` is your target Scale Factor.
This will generate a folder `queries` with all the 99 queries inside.
Be warned: it overwrites the content of that folder every time it is executed.
