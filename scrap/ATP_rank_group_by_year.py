# -*- coding: utf-8 -*-
"""
Created on Tue Dec 27 21:44:01 2022

@author: Paula

This code take all ranking week into ranking years.
"""
import os
import glob
import pandas as pd

os.chdir('C:/Users/Paula/Documents/Projects/TennisData/ATP_ranking/rank_weeks/')

list_data = []
for year in range(1973,2024):
    name = 'ranking_' + str(year) + '*.csv'
    csv_files = glob.glob(name)   
    #list_data = []
    for filename in csv_files:
        data = pd.read_csv(filename, header = None)
        list_data.append(data)
        
data = pd.concat(list_data, ignore_index = True)
data = data.fillna(0)

data.columns = ['date','rank', 'rank_change', 'country', 'player_id','player', 'points', 'points_change', 'age', , 'tourneyPlayed', 'dropping', 'nextBest']
data.to_csv('ATP_' + name[:-5] + '.csv', header=True, index=False)

