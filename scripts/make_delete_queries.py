if __name__ == '__main__':
    # Delete queries for inventory table
    filename = './inventory_delete_1.dat'
    output = './inventory_delete.sql'
    with open(filename) as file:
        lines = []
        for line in file.readlines():
            dates = line.split("|")
            query = (f"DELETE FROM inventory WHERE inv_date_sk IN\n"
                     f"(SELECT DISTINCT d_date_sk\n"
                     f"FROM date_dim d\n"
                     f"WHERE d.d_date >= '{dates[0]}' AND d.d_date <= '{dates[1]}'"
                     f");\n")
            lines += query + '\n'
    with open(output, 'w') as file:
        file.writelines(lines)

    # Delete queries for catalog, store and web tables
    filename = './delete_1.dat'
    output = './delete.sql'
    tables = [("catalog_sales", "cs_sold_date_sk"), ("catalog_returns", "cr_returned_date_sk"),
              ("store_sales", "ss_sold_date_sk"), ("store_returns", "sr_returned_date_sk"),
              ("web_sales", "ws_sold_date_sk"), ("web_returns", "wr_returned_date_sk")]
    with open(filename) as file:
        lines = []
        for line in file.readlines():
            dates = line.split("|")
            for table in tables:
                query = (f"DELETE FROM {table[0]} WHERE {table[1]} IN\n"
                         f"(SELECT DISTINCT d_date_sk\n"
                         f"FROM date_dim d\n"
                         f"WHERE d.d_date >= '{dates[0]}' AND d.d_date <= '{dates[1]}'"
                         f");\n")
                lines += query + '\n'
            lines += '\n'
    with open(output, 'w') as file:
        file.writelines(lines)
