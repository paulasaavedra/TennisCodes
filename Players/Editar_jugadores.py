# -*- coding: utf-8 -*-
"""
Created on Wed Sep 27 19:50:04 2023

@author: Paula
"""

import pandas as pd

# Especifica la ruta de tu archivo CSV
archivo_csv = 'C:/Users/Paula/Documents/GitHub/TennisData/SQL/Tabla_jugadores/players2.csv'

# Lee el archivo CSV en un DataFrame
df = pd.read_csv(archivo_csv)
df['dob'] = df['dob'].fillna(0)
df['dob'] = df['dob'].astype(int)

elementos_unicos = df['birth_country'].unique()

df['birth_country'] = df['birth_country'].replace('USA', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('U.S.A.', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('TX', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('MO', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('CA', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('VA', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('OH', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('WA', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('NY', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('IA', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('CT', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('TN', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('MD', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('D.C.', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('FL', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('WI', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('NJ', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('KY', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('CO', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('NC', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('MA', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('OK', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('IL', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('MN', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('PA', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('MS', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('LA', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('IN', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('OR', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('AL', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('GA', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('AZ', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('AK', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('HI', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('PA U.S.A.', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('CA USA', 'Estados Unidos')
df['birth_country'] = df['birth_country'].replace('SC', 'Estados Unidos')


