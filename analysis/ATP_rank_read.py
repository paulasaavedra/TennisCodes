import os
import pandas as pd

folder_path = 'C:/Users/Paula/Documents/Projects/TennisData/ATP_ranking/rank_years/'
file_list = [os.path.join(folder_path, file) for file in os.listdir(folder_path) if file.endswith('.csv')]

all_dataframes = [pd.read_csv(file) for file in file_list]
df_ranks = pd.concat(all_dataframes, ignore_index=True)
