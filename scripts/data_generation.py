import pandas as pd
import os
import argparse

parser = argparse.ArgumentParser()

# flags for obtaining and cleaning the data files
parser.add_argument("-rp", "--root_path", help="enter the root directory path")
parser.add_argument("-dp", "--data_path", help="enter the path of all data files")

args = parser.parse_args()

# root_path= "D:/TPC-DS/DSGen-software-code-3.2.0rc1"
root_path= args.root_path

# data_path= os.path.join(root_path, "Data")
data_path= args.data_path

csv_data_folder= os.path.join(root_path, "Data_csv")

if not os.path.exists(csv_data_folder):
  os.makedirs(csv_data_folder) 

for file_name in os.listdir(data_path):
  file= os.path.join(data_path, file_name)
  df= pd.read_csv(file, delimiter="|", header=None, encoding='latin-1')
  df.drop(columns={df.columns[len(df.columns)-1]}, axis=1, inplace=True)
  df.to_csv(os.path.join(csv_data_folder, file_name + ".csv"), index=False, float_format="%.0f")
  print("processed file "+ file_name)
