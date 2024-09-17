# -*- coding: utf-8 -*-
"""
Created on Tue Dec 27 21:44:01 2022

@author: Paula

This code take all ranking week into ranking years.
"""
import os
import glob
import pandas as pd

weeks_path = 'C:/Users/Paula/Documents/Projects/TennisData/ATP_ranking/rank_weeks/'
years_path = 'C:/Users/Paula/Documents/Projects/TennisData/ATP_ranking/rank_years/'

# Nombres de las columnas que se quieren agregar (sin 'date' porque la añadiremos aparte)
columns_names = ['rank', 'rank_change', 'country', 'player_id', 'player', 
                 'age', 'points', 'points_change', 'tourneyPlayed', 'dropping', 'nextBest']

# Buscar todos los archivos que coincidan con el formato
csv_files = glob.glob(os.path.join(weeks_path, 'ranking_*.csv'))

# Diccionario para agrupar los archivos por año
files_per_year = {}

# Iterar sobre los archivos y agrupar por año
for file in csv_files:
    # Extraer la fecha del archivo (formato: ranking_yyyymmdd)
    file_name = os.path.basename(file)
    date_str = file_name[8:16]  # Extraer la fecha en formato 'yyyymmdd'
    year = date_str[:4]  # Extraer el año (primeros 4 dígitos)

    # Si el año no está en el diccionario, inicializar una lista
    if year not in files_per_year:
        files_per_year[year] = []

    # Agregar el archivo y su fecha a la lista correspondiente al año
    files_per_year[year].append((file, date_str))

# Crear un archivo CSV por cada año
for year, files in files_per_year.items():
    # Lista para almacenar los DataFrames
    df_list = []
    
    # Iterar sobre los archivos y sus fechas
    for file, date_str in files:
        # Leer el archivo CSV
        df = pd.read_csv(file, names=columns_names, header=None)
        
        # Agregar la columna de fecha
        df['date'] = pd.to_datetime(date_str, format='%Y%m%d')
        
        # Reordenar las columnas para que 'date' sea la primera
        df = df[['date'] + columns_names]
        
        # Agregar el DataFrame a la lista
        df_list.append(df)
    
    # Concatenar los DataFrames del año
    year_df = pd.concat(df_list)
    
    # Guardar el archivo concatenado con los datos del año
    year_df.to_csv(os.path.join(years_path, f'{year}.csv'), index=False)

    print(f'Archivo para el año {year} creado con éxito.')
