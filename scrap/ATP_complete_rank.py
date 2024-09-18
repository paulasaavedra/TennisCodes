# -*- coding: utf-8 -*-
"""
Created on Tue Jan 27 21:44:01 2024
@author: Paula
This code take all ranking week into ranking years.
"""

import pandas as pd
import os
from datetime import datetime, timedelta

# Rutas
source_directory = 'C:/Users/Paula/Documents/Projects/TennisData/ATP_ranking/rank_weeks/'
destination_directory = 'C:/Users/Paula/Documents/Projects/TennisData/ATP_ranking/rank_weeks_completed/'

# Función para obtener la fecha del lunes anterior a partir de una fecha
def get_previous_monday(date):
    return date - timedelta(days=date.weekday())

# Obtiene la lista de archivos CSV en el directorio de origen
files = [f for f in os.listdir(source_directory) if f.endswith('.csv')]

# Extrae las fechas de los nombres de archivo
dates = []
for file in files:
    date_str = file.split('_')[1].replace('.csv', '')
    date = datetime.strptime(date_str, '%Y%m%d')
    dates.append(date)

# Ordena las fechas
dates.sort()

# Completa semanas faltantes
current_date = dates[0]
end_date = dates[-1]

while current_date <= end_date:
    filename = f'ranking_{current_date.strftime("%Y%m%d")}.csv'
    source_filepath = os.path.join(source_directory, filename)
    destination_filepath = os.path.join(destination_directory, filename)
    
    if not os.path.exists(source_filepath):
        # Encuentra el archivo CSV de la semana anterior
        previous_date = get_previous_monday(current_date - timedelta(weeks=1))
        previous_filename = f'ranking_{previous_date.strftime("%Y%m%d")}.csv'
        previous_filepath = os.path.join(source_directory, previous_filename)
        
        if os.path.exists(previous_filepath):
            # Lee el archivo de la semana anterior
            df = pd.read_csv(previous_filepath)
            # Guarda una copia para la semana faltante en el directorio de destino
            df.to_csv(destination_filepath, index=False)
            print(f'Archivo {filename} creado a partir de la semana anterior en {destination_directory}.')

    # Avanza a la siguiente semana
    current_date += timedelta(weeks=1)
