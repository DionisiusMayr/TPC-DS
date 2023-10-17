import os
import shutil 
import argparse

parser = argparse.ArgumentParser()

# flags for obtaining and cleaning the data files
parser.add_argument("-rp", "--root_path", help="enter the root directory path")
parser.add_argument("-dp", "--data_path", help="enter the path of all data files")

args = parser.parse_args()

# root_path= "D:/TPC-DS/DSGen-software-code-3.2.0rc1"
root_path= args.root_path

# data_path= os.path.join(root_path, "Data_csv")
data_path= args.data_path

data_list= os.listdir(data_path)

#creating a new sql file to store all the queries
# sql_file= os.path.join(root_path,"data.sql")
# if not os.path.exists(sql_file):
#   os.makedirs(sql_file)

# list to store names of all the data files
list=[]

# creating the copy commands for the sql file
for data_file in data_list:
  copy_string= f"COPY {data_file[:-8]} FROM '{os.path.join(data_path, data_file)}' DELIMITER ',' NULL '' ENCODING 'LATIN1' CSV header;"
  list.append(copy_string)
  print(copy_string)
  print(f"added {data_file} into the database")

# generating the data.sql file from the copy commands
with open (os.path.join(root_path, "data.sql"), "w") as f:
   for command in list:
      f.write(command + "\n")

# printing the list with all the copy command strings of postgresql
print(list)