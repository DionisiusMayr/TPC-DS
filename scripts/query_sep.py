import os
import pandas as pd
import argparse
"D:/TPC-DS/DSGen-software-code-3.2.0rc1/final_queries/"
parser = argparse.ArgumentParser()

# flags for obtaining and cleaning the data files
parser.add_argument("-rp", "--root_path", help="enter the root directory path")
parser.add_argument("-qp", "--query_path", help="enter the path of query file")

args = parser.parse_args()

root_path= args.root_path

query_filepath= args.query_path

# base_path= "C:/Users/ariji/TPC_DS"
# sql_file_path= os.path.join(base_path, "query_0.sql")

# sql_sep_folder_path= os.path.join(base_path, "sep_sql_queries")
sql_sep_folder_path= os.path.join(root_path, "sep_sql_queries")

if not os.path.exists(sql_sep_folder_path):
  os.makedirs(sql_sep_folder_path)

with open(query_filepath, "r") as file:
  sql_queries= file.read().split("\n\n\n")

for i, query in enumerate(sql_queries):
  query_filename= os.path.join(sql_sep_folder_path, f"query_{i+1}.sql")

  with open(query_filename, "w") as query_file:
    query_file.write(query)
  
  print(f"processed query_{i+1}")

for file in os.listdir(sql_sep_folder_path):
  filepath= os.path.join(sql_sep_folder_path, file)
  if os.path.getsize(filepath) == 0:
    os.remove(filepath)