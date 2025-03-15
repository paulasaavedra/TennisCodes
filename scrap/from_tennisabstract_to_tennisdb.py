
# -*- coding: utf-8 -*-
"""
Created on Sat Jan  4 10:21:05 2025

@author: Paula
"""

import pandas as pd
import random
import numpy as np
import glob
import os

categoria = 'atp'

# Define la ruta donde están los archivos CSV
ruta_archivos = "C:/Users/Paula/Documents/Projects/tennisabstract/tennis_atp"

# Utiliza glob para encontrar todos los archivos que coinciden con el patrón
archivos = glob.glob(os.path.join(ruta_archivos, "atp_matches_*.csv"))

# Crea una lista para almacenar los DataFrames
list_df = []

# Itera sobre los archivos y carga cada uno en un DataFrame
for archivo in archivos:
    # Lee el CSV y agrégalo a la lista
    df = pd.read_csv(archivo, low_memory=False, dtype={'tourney_date': str})
    list_df.append(df)

# Concatenar todos los DataFrames en uno solo
df_completo = pd.concat(list_df, ignore_index=True)

# Lista de columnas para el DataFrame
columnas_simple = ["MATCH_ID","TOURNEY_LEVEL", "TOURNEY_NAME", "COUNTRY", "SURFACE", 
                   "ROUND_MATCH", "DATE_MATCH", "W_PLAYER", "W_NAC", "W_SEED", "L_PLAYER", 
                   "L_NAC", "L_SEED", "TIMESTART", "SCORE", "MATCH_STATUS", "BEST", "TIME_TOTAL",
                   "TIME_1S", "TIME_2S", "TIME_3S", "TIME_4S", "TIME_5S", "COMENTS", "WINNER"]

# Crear un DataFrame vacío con estas columnas
df_simple = pd.DataFrame(columns=columnas_simple)

df_completo['winner_entrada'] = df_completo['winner_seed'].fillna(df_completo['winner_entry'])
df_completo['loser_entrada'] = df_completo['loser_seed'].fillna(df_completo['loser_entry'])

# Definir el mapeo de los valores
map_tourney_level = {
    'A': 'ATP',
    'G': 'GS',
    'O': 'JJOO',
    'M': 'M1000',
    'D': 'DC',
    'C': 'CH',
    'W': 'WTA',
    'I': 'INTERNATIONAL',
    'P': 'PREMIER'
}

df_completo['tourney_level'] = df_completo['tourney_level'].map(map_tourney_level)

# Reemplazar los valores no mapeados (NaN) por np.nan
df_completo['tourney_level'].fillna(np.nan, inplace=True)


# Conjunto para hacer seguimiento de los valores generados para cada year_id
generated_ids = {}

# Función para generar el nuevo tourney_id
def generate_tourney_id(tourney_id):
    # Verificar si el tourney_id tiene el formato esperado
    if isinstance(tourney_id, str) and '-' in tourney_id:
        # Dividir el tourney_id en año e id
        try:
            year, id_number = tourney_id.split('-')
        except:
            year = tourney_id.split('-')[0]
            id_number = tourney_id.split('-')[1] + tourney_id.split('-')[2]

        # Asegurar que id_number tenga 4 caracteres, agregando ceros a la izquierda si es necesario
        id_number = id_number.zfill(4)

        # Asegurarse de que el conjunto de generados para el 'year' existe
        if year not in generated_ids:
            generated_ids[year] = set()  # Crear un conjunto vacío para ese año

        # Generar valores aleatorios para aa, bb y cc, asegurándose de que no se repitan
        while True:
            aa = str(random.randint(0, 23)).zfill(2)  # Número entre 00 y 23
            bb = str(random.randint(0, 59)).zfill(2)  # Número entre 00 y 59
            cc = str(random.randint(0, 59)).zfill(2)  # Número entre 00 y 59

            aabbcc = aa + bb + cc
            # Si el valor generado no se repite, se puede usar
            if aabbcc not in generated_ids[year]:
                generated_ids[year].add(aabbcc)
                break  # Salir del ciclo y usar el nuevo valor

        # Crear el nuevo tourney_id
        return f"{year}_{id_number}_{aabbcc}"
    else:
        return None  # Si no tiene el formato esperado, retorna None

# Aplicar la función a la columna 'tourney_id'
df_completo['tourney_id'] = df_completo['tourney_id'].apply(generate_tourney_id)



column_mapping = {
    'tourney_id': 'MATCH_ID',
    'tourney_level': 'TOURNEY_LEVEL',
    'tourney_name': 'TOURNEY_NAME',
    'surface': 'SURFACE',
    'round': 'ROUND_MATCH',
    'tourney_date': 'DATE_MATCH',
    'winner_name': 'W_PLAYER',
    'winner_ioc': 'W_NAC',
    'winner_entrada': 'W_SEED',
    'loser_name': 'L_PLAYER',
    'loser_ioc': 'L_NAC',
    'loser_entrada': 'L_SEED',
    'score': 'SCORE',
    'best_of': 'BEST',
    'minutes': 'TIME_TOTAL',
    'm_status': 'MATCH_STATUS'
}

# Crear la columna 'm_status' inicializándola con None
df_completo['m_status'] = None

# Actualizar los valores de 'm_status' según las condiciones
df_completo.loc[df_completo['score'].str.contains(r'\b[Ww]\b', na=False), 'm_status'] = 'Walkover'
df_completo.loc[df_completo['score'].str.contains(r'\bWalkover\b', na=False), 'm_status'] = 'Walkover'
df_completo.loc[df_completo['score'].str.contains(r'\bRET\b', na=False), 'm_status'] = 'Finished / retired'
df_completo.loc[df_completo['score'].str.contains(r'\bRet.\b', na=False), 'm_status'] = 'Finished / retired'
df_completo.loc[df_completo['score'].str.contains(r'\bDEF\b', na=False), 'm_status'] = 'Finished / retired'
df_completo.loc[df_completo['score'].str.contains(r'\bABD\b', na=False), 'm_status'] = 'Finished / retired'
df_completo.loc[df_completo['score'].str.contains(r'\bABN\b', na=False), 'm_status'] = 'Finished / retired'
df_completo.loc[df_completo['score'].str.contains(r'\bDef\b', na=False), 'm_status'] = 'Finished / retired'
df_completo.loc[df_completo['score'].str.contains(r'\bPlayed and abandoned\b', na=False), 'm_status'] = 'Finished / retired'
df_completo.loc[df_completo['score'].str.contains(r'\bPlayed and unfinished\b', na=False), 'm_status'] = 'Finished / retired'
df_completo.loc[df_completo['score'].str.contains(r'\bDefault\b', na=False), 'm_status'] = 'Finished / retired'
df_completo.loc[df_completo['score'].str.contains(r'\bRE\b', na=False), 'm_status'] = 'Finished / retired'


# Crear df_simple solo con las columnas necesarias
df_simple = df_completo[list(column_mapping.keys())].rename(columns=column_mapping)

missing_columns = [col for col in columnas_simple if col not in df_simple.columns]

# Actualizar 'MATCH_STATUS' a 'Finished' donde sea None y 'SCORE' no contenga letras
df_simple.loc[
    (df_simple['MATCH_STATUS'].isnull()) & (~df_simple['SCORE'].str.contains('[a-zA-Z]', na=False)),
    'MATCH_STATUS'
] = 'Finished'


# Añadir las columnas faltantes con valores None
for col in missing_columns:
    df_simple[col] = None

country_mapping = {
    'AFG': 'Afghanistan', 'ALB': 'Albania', 'DZA': 'Algeria', 'AND': 'Andorra', 'AGO': 'Angola',
    'ARG': 'Argentina', 'ARM': 'Armenia', 'AUS': 'Australia', 'AUT': 'Austria', 'AZE': 'Azerbaijan',
    'BHS': 'Bahamas', 'BHR': 'Bahrain', 'BGD': 'Bangladesh', 'BRB': 'Barbados', 'BLR': 'Belarus',
    'BEL': 'Belgium', 'BLZ': 'Belize', 'BEN': 'Benin', 'BTN': 'Bhutan', 'BOL': 'Bolivia',
    'BIH': 'Bosnia and Herzegovina', 'BWA': 'Botswana', 'BRA': 'Brazil', 'BRN': 'Brunei', 'BGR': 'Bulgaria',
    'BUL': 'Bulgaria', 'BFA': 'Burkina Faso', 'BDI': 'Burundi', 'CPV': 'Cabo Verde', 'KHM': 'Cambodia', 'CMR': 'Cameroon',
    'CAN': 'Canada', 'CAF': 'Central African Republic', 'TCD': 'Chad', 'CHL': 'Chile', 'CHN': 'China',
    'COL': 'Colombia', 'COM': 'Comoros', 'COG': 'Congo', 'COD': 'Democratic Republic of the Congo',
    'CRI': 'Costa Rica', 'HRV': 'Croatia', 'CUB': 'Cuba', 'CYP': 'Cyprus', 'CZE': 'Czechia',
    'DNK': 'Denmark', 'DEN': 'Denmark', 'DJI': 'Djibouti', 'DMA': 'Dominica', 'DOM': 'Dominican Republic', 'ECU': 'Ecuador',
    'EGY': 'Egypt', 'SLV': 'El Salvador', 'GNQ': 'Equatorial Guinea', 'ERI': 'Eritrea', 'EST': 'Estonia',
    'SWZ': 'Eswatini', 'ETH': 'Ethiopia', 'FJI': 'Fiji', 'FIN': 'Finland', 'FRA': 'France',
    'GAB': 'Gabon', 'GMB': 'Gambia', 'GEO': 'Georgia', 'DEU': 'Germany', 'GHA': 'Ghana',
    'GRC': 'Greece', 'GRD': 'Grenada', 'GTM': 'Guatemala', 'GIN': 'Guinea', 'GNB': 'Guinea-Bissau',
    'GUY': 'Guyana', 'HTI': 'Haiti', 'HND': 'Honduras', 'HUN': 'Hungary', 'ISL': 'Iceland',
    'IND': 'India', 'IDN': 'Indonesia', 'IRN': 'Iran', 'IRQ': 'Iraq', 'IRL': 'Ireland',
    'ISR': 'Israel', 'ITA': 'Italy', 'CIV': "Ivory Coast", 'JAM': 'Jamaica', 'JPN': 'Japan',
    'JOR': 'Jordan', 'KAZ': 'Kazakhstan', 'KEN': 'Kenya', 'KIR': 'Kiribati', 'KWT': 'Kuwait',
    'KGZ': 'Kyrgyzstan', 'LAO': 'Laos', 'LVA': 'Latvia', 'LBN': 'Lebanon', 'LSO': 'Lesotho',
    'LBR': 'Liberia', 'LBY': 'Libya', 'LIE': 'Liechtenstein', 'LTU': 'Lithuania', 'LUX': 'Luxembourg',
    'MDG': 'Madagascar', 'MWI': 'Malawi', 'MYS': 'Malaysia', 'MDV': 'Maldives', 'MLI': 'Mali',
    'MLT': 'Malta', 'MHL': 'Marshall Islands', 'MRT': 'Mauritania', 'MUS': 'Mauritius', 'MEX': 'Mexico',
    'FSM': 'Micronesia', 'MDA': 'Moldova', 'MCO': 'Monaco', 'MNG': 'Mongolia', 'MNE': 'Montenegro',
    'MAR': 'Morocco', 'MOZ': 'Mozambique', 'MMR': 'Myanmar', 'NAM': 'Namibia', 'NRU': 'Nauru',
    'NPL': 'Nepal', 'NLD': 'Netherlands', 'NZL': 'New Zealand', 'NIC': 'Nicaragua', 'NER': 'Niger',
    'NGA': 'Nigeria', 'PRK': 'North Korea', 'MKD': 'North Macedonia', 'NOR': 'Norway', 'OMN': 'Oman',
    'PAK': 'Pakistan', 'PLW': 'Palau', 'PAN': 'Panama', 'PNG': 'Papua New Guinea', 'PRY': 'Paraguay',
    'PER': 'Peru', 'PHL': 'Philippines', 'POL': 'Poland', 'PRT': 'Portugal', 'QAT': 'Qatar',
    'ROU': 'Romania', 'RUS': 'Russia', 'RWA': 'Rwanda', 'KNA': 'Saint Kitts and Nevis', 'LCA': 'Saint Lucia',
    'VCT': 'Saint Vincent and the Grenadines', 'WSM': 'Samoa', 'SMR': 'San Marino', 'STP': 'Sao Tome and Principe',
    'SAU': 'Saudi Arabia', 'SEN': 'Senegal', 'SRB': 'Serbia', 'SYC': 'Seychelles', 'SLE': 'Sierra Leone',
    'SGP': 'Singapore', 'SVK': 'Slovakia', 'SVN': 'Slovenia', 'SLB': 'Solomon Islands', 'SOM': 'Somalia',
    'ZAF': 'South Africa', 'KOR': 'South Korea', 'SSD': 'South Sudan', 'ESP': 'Spain', 'LKA': 'Sri Lanka',
    'SDN': 'Sudan', 'SUR': 'Suriname', 'SWE': 'Sweden', 'CHE': 'Switzerland', 'SYR': 'Syria',
    'TWN': 'Taiwan', 'TJK': 'Tajikistan', 'TZA': 'Tanzania', 'THA': 'Thailand', 'TLS': 'Timor-Leste',
    'TGO': 'Togo', 'TON': 'Tonga', 'TTO': 'Trinidad and Tobago', 'TUN': 'Tunisia', 'TUR': 'Turkey',
    'TKM': 'Turkmenistan', 'TUV': 'Tuvalu', 'UGA': 'Uganda', 'UKR': 'Ukraine', 'ARE': 'United Arab Emirates',
    'GBR': 'United Kingdom', 'USA': 'United States', 'URY': 'Uruguay', 'UZB': 'Uzbekistan', 'VUT': 'Vanuatu',
    'VEN': 'Venezuela', 'VNM': 'Vietnam', 'YEM': 'Yemen', 'ZMB': 'Zambia', 'ZWE': 'Zimbabwe',
    'GER': 'Germany', 'GRE': 'Greece', 'CHI': 'Chile', 'CRO': 'Croatia', 'SUI': 'Switzerland', 'NED': 'Netherlands',
    'POR': 'Portugal', 'RSA': 'South Africa', 'BAR': 'Barbados', 'URU': 'Uruguay', 'ESA':'El Salvador', 'LIB':'Libano',
    'MON': 'Monaco', 'TOG': 'Togo', 'SLO': 'Slovenia', 'ZIM': 'Zimbabwe', 'IRI': 'Iran', 'INA': 'Indonesia',
    'VIE': 'Vietnam', 'TPE': 'Taiwan', 'HKG': 'Hong Kong', 'LAT': 'Latvia', 'POC': 'Puerto Rico',
    'PAR': 'Paraguay', 'CRC': 'Costa Rica',
    'UNK': 'Unknown', 'TCH': 'Czech Republic', 'PHI': 'Philippines', 'PUR': 'Puerto Rico', 
    'SRI': 'Sri Lanka', 'MAS': 'Malaysia', 'RHO': 'Rhodesia', 'CAR': 'Central African Republic',
    'CUW': 'Curaçao', 'SUD': 'Sudan', 'FRG': 'West Germany', 'GDR': 'East Germany', 'YUG': 'Yugoslavia', 
    'UAE': 'United Arab Emirates', 'NIG': 'Nigeria', 'NGR': 'Nigeria', 'BAH': 'Bahrain', 'ALG': 'Algeria', 
    'BER': 'Bermuda', 'BUR': 'Burkina Faso', 'BAN': 'Bangladesh', 'LBA': 'Libya', 'HAI': 'Haiti', 
    'KUW': 'Kuwait', 'GUA': 'Guatemala', 'TRI': 'Trinidad and Tobago', 'ZAM': 'Zambia', 
    'CGO': 'Congo', 'ECA': 'Ecuador', 'KSA': 'Saudi Arabia', 'SOL': 'Solomon Islands', 
    'FIJ': 'Fiji', 'AHO': 'Aruba', 'COK': 'Cook Islands', 'SAM': 'Samoa', 'OMA': 'Oman',
    'VAN': 'Vanuatu', 'MAD': 'Madagascar', 'BOT': 'Botswana', 'GUD': 'Guadeloupe',
    'ITF': 'French Southern Territories', 'ANT': 'Netherlands Antilles',
    'URS': 'Soviet Union', 'NMI': 'Northern Mariana Islands', 
    'BRU': 'Brunei', 'ARU': 'Aruba', 'MRI': 'Mauritius', 'GUM': 'Guam'
    
}



df_simple['W_NAC'] = df_simple['W_NAC'].replace(country_mapping)
df_simple['L_NAC'] = df_simple['L_NAC'].replace(country_mapping)

df_simple['W_NAC'] = df_simple['W_NAC'].fillna('Unknown')
df_simple['L_NAC'] = df_simple['L_NAC'].fillna('Unknown')

df_simple['W_PLAYER'] = df_simple['W_PLAYER'].str.replace('-', ' ', regex=False)
df_simple['L_PLAYER'] = df_simple['L_PLAYER'].str.replace('-', ' ', regex=False)



# Diccionario de ciudades y sus respectivos países
city_to_country = {
    'Dublin': 'Ireland',     'Buenos Aires': 'Argentina',    'Gstaad': 'Switzerland',    'Bournemouth': 'United Kingdom',
    'Philadelphia WCT': 'United States',    'Monte Carlo': 'Monaco',    'Hamburg': 'Germany',    'Rome': 'Italy',    'Cincinnati': 'United States',
    'Los Angeles': 'United States',    'Barcelona': 'Spain',    'Roland Garros': 'France',    'Wimbledon': 'United Kingdom',    'US Open': 'United States',
    'Australian Chps.': 'Australia',    'Dusseldorf': 'Germany',    'London': 'United Kingdom',    'Bloemfontein': 'South Africa',
    'Durban 1': 'South Africa',    'Hobart': 'Australia',    'Macon': 'United States',    'Auckland': 'New Zealand',    'Salisbury': 'United Kingdom',
    'Miami WCT': 'United States',    'Richmond': 'United States',    'Sydney WCT': 'Australia',    'Shreveport WCT': 'United States',
    'Houston WCT': 'United States',    'New Orleans WCT': 'United States',    'Orlando WCT': 'United States',    'New York 1': 'United States',
    'Caracas': 'Venezuela',    'Barranquilla': 'Colombia',    'Kingston': 'Jamaica',    'Curacao': 'Curacao',
    'Tulsa WCT': 'United States',    'Sao Paulo NTL 1': 'Brazil',    'San Diego WCT': 'United States',    'Buenos Aires NTL': 'Argentina',    'Bogota NTL': 'Colombia',
    'Parioli': 'Italy',    'Palermo': 'Italy',    'Houston 2': 'United States',    'Johannesburg 1': 'South Africa',    'Charlotte': 'United States',    'San Juan': 'Puerto Rico',
    'St. Petersburg': 'Rusia',      'Los Altos Hills WCT': 'United States',    'Bakersfield WCT': 'United States',    'Fresno WCT': 'United States',    'Hollywood NTL': 'United States',
    'Tampa': 'United States',    'WCT World Cup': 'United States',    'Catania': 'Italy',    'Haverford': 'United States',    'Munich': 'Germany',
    'Bastad 1': 'Sweden',    'Hilversum': 'Netherlands',    'Boston 2': 'United States',   'Boston 1': 'United States',
    'Toronto': 'Canada',    'Berkeley': 'United States',    'Wembley 3': 'United Kingdom',    'Fort Worth NTL': 'United States',    'Sacramento': 'United States',
    'Corpus Christi NTL': 'United States',    'Midland NTL': 'United States',    'South Orange': 'United States',    'Milwaukee': 'United States',    'Adelaide': 'Australia',
    'Beckenham': 'United Kingdom',    'New York 3': 'United States',    'Berlin': 'Germany',    'New Orleans 2': 'United States',
    'New York NTL': 'United States',    'Binghamton NTL': 'United States',    'Southampton': 'United Kingdom',    'Newport WCT': 'United States',    'Paris NTL': 'France',    'Evansville WCT': 'United States',
    'Minneapolis WCT': 'United States',    'Buffalo WCT': 'United States',    'Baltimore WCT': 'United States',    'Paris 2': 'France',    'Bastad WCT': 'Sweden',    'Cannes WCT': 'France',
    'Pretoria WCT': 'South Africa',    'Johannesburg WCT': 'South Africa',    'Durban WCT': 'South Africa',    'Port Elizabeth WCT': 'South Africa',    'Cape Town WCT': 'South Africa',    'Sao Paulo NTL 2': 'Brazil',
    'Vienna WCT': 'Austria',    'Nashville': 'United States',    'Lugano': 'Switzerland',    'Indianapolis': 'United States',    'La Jolla': 'United States',
    'Naples': 'Italy',    'Brisbane': 'Australia',    'Reggio Calabria': 'Italy',    'Kitzbuehel': 'Austria',    'Perth': 'Australia',
    'Bristol': 'United Kingdom',    'Manchester': 'United Kingdom',    'Mexico City': 'Mexico',    'Bombay': 'India',    'Calcutta': 'India',
    'Port Elizabeth': 'South Africa',    'Bremen Indoors': 'Germany',    'Pittsburgh Indoors': 'United States',   'Concord Indoors': 'United States',
    'Munich Indoors': 'Germany',    'Long Island Indoors': 'United States',    'Phoenix': 'United States',    'Cannes': 'France',    'Oakland': 'United States',
    'La Coruna': 'Spain',    'Viareggio': 'Italy',    'Ortisei': 'Italy',    'Aberavon': 'United Kingdom',    'Woodside': 'United States',
    'Helsinki': 'Finland',    'Saltsjoebaden': 'Sweden',    'San Antonio Collegiate': 'United States',    'Senigallia': 'Italy',    'Scheveningen': 'Netherlands',
    'Quebec City': 'Canada',    'Bucharest': 'Romania',    'Mamaia': 'Romania',    'Las Vegas': 'United States',    'Belgrade': 'Serbia',    'Valencia': 'Spain',
    'Cannes Chps': 'France',    'Hanau': 'Germany',    'Narberth': 'United States',    'New York': 'United States',   'Durban': 'South Africa',
    'Sydney': 'Australia',    'Melbourne': 'Australia',    'Bastad': 'Sweden',    'Brussels': 'Belgium',    'Boston': 'United States',    'Washington': 'United States',
    'Johannesburg': 'South Africa',    'Stockholm Open': 'Sweden',    'Wembley': 'United Kingdom',
    'Omaha': 'United States','Jacksonville': 'United States','Kitzbuhel': 'Austria','Cologne': 'Germany','Aix-en-Provence': 'France','Dallas': 'United States','Denver': 'United States',
'Houston': 'United States','Atlanta': 'United States','St. Louis': 'United States','Fort Worth': 'United States','Hollywood': 'United States','Midland': 'United States','Tucson': 'United States',
'Paris': 'France','Chicago': 'United States','New Orleans': 'United States','Japanese Championships': 'Japan','Amsterdam': 'Netherlands','Portschach': 'Austria','Binghamton': 'United States',
'Newport': 'United States','Anaheim': 'United States','Baltimore': 'United States','Vienna': 'Austria','Pittsburgh': 'United States','Buffalo': 'United States','Merion': 'United States',
'Vancouver': 'Canada','Eastbourne': 'United Kingdom','Casablanca WCT': 'Morocco','Nottingham': 'United Kingdom','Paris Indoor': 'France','Masters': 'United States',
'St. Louis WCT': 'United States','Hampton': 'United States','Louisville': 'United States','Miami': 'United States','Corpus Christi': 'United States','Hoylake': 'United Kingdom','Leicester': 'United Kingdom',
'Cambridge': 'United Kingdom',    'Kimberley': 'South Africa',    'La Paz': 'Bolivia',    'Lima': 'Peru',    'Cape Town': 'South Africa',   'Columbus': 'United States',    'Kansas City': 'United States',
    'Tehran': 'Iran',    'Quebec': 'Canada',    'Des Moines': 'United States',    'Queen\'s Club': 'United Kingdom',    'Bologna': 'Italy',    'Nice': 'France',    'Hilton Head': 'United States',    'Pensacola': 'United States',
    'Roanoke': 'United States',    'Seattle': 'United States',    'Montreal': 'Canada',    'Essen': 'Germany',    'Cleveland': 'United States',    'Rotterdam': 'Netherlands',    'Albany': 'United States',    'Stockholm': 'Sweden',
    'Gothenburg': 'Sweden',    'Bretton Woods': 'United States',    'Tokyo': 'Japan',    'Hartford': 'United States',    'Hong Kong': 'Hong Kong',    'Christchurch': 'New Zealand',    'Paramus': 'United States',    'Calgary': 'Canada',
    'Salt Lake City': 'United States',    'Aptos': 'United States',    'New Delhi': 'India',    'Jakarta': 'Indonesia',    'Florence': 'Italy',    'Prague': 'Czech Republic',    'Milan': 'Italy',    'San Francisco': 'United States',
    'Copenhagen': 'Denmark',    'Osaka': 'Japan',    'Birmingham': 'United Kingdom',    'Jackson': 'United States',    'Charleston': 'United States',    'Columbia': 'United States',    'Manila': 'Philippines',    'Tempe': 'United States',    'Oslo': 'Norway',
    'Palm Desert': 'United States',    'Sao Paulo': 'Brazil',    'Maui': 'United States',    'Little Rock': 'United States',    'Lakeway': 'United States',    'Dayton': 'United States',    'Surbiton': 'United Kingdom',    'Tucson': 'United States',
    'Acapulco': 'Mexico',    'San Antonio': 'United States',    'Bermuda': 'Bermuda',    'Freeport': 'Bahamas',    'Fairfield': 'United States',    'Shreveport': 'United States',    'Istanbul': 'Turkey',    'Aviles': 'Spain',
    'Cairo': 'Egypt',    'Basel': 'Switzerland',    'Memphis': 'United States',    'North Conway': 'United States',    'Boca Raton': 'United States',    'Algiers': 'Algeria',    'Bangalore': 'India',
    'Lagos': 'Nigeria',    'Monterrey': 'Mexico',    'Santiago': 'Chile',    'Khartoum': 'Sudan',   'Jackson': 'United States',
    'Nuremberg': 'Germany',    'Columbus': 'United States',    'Palm Springs': 'United States',    'La Costa': 'United States',    'Palma': 'Spain',    'Birmingham': 'United Kingdom',    'Murcia': 'Spain',    'Oviedo': 'Spain',    'Ocean City': 'United States',
    'Laguna Niguel': 'United States',    'Taipei': 'Taiwan',    'Aix en Provence': 'France',    'San Jose': 'United States',    'Bogota': 'Colombia',    'Virginia Beach': 'United States',    'Springfield': 'United States',    'Zurich': 'Switzerland',
    'Lagos': 'Nigeria',    'Guadalajara': 'Mexico',    'Bologna': 'Italy',    'Stuttgart': 'Germany',    'Stowe': 'United States',    'Forest Hills': 'United States',    'Sarasota': 'United States',    'Tulsa': 'United States',
    'Lafayette': 'United States',    'Nancy': 'France',    'Bordeaux': 'France',    'Tel Aviv': 'Israel',    'Quito': 'Ecuador',    'Rancho Mirage': 'United States',    'Milan': 'Italy',    'Dorado Beach': 'Puerto Rico',    'New Haven': 'United States',
    'Geneva': 'Switzerland',    'Bangkok': 'Thailand',    'Metz': 'France',    'Frankfurt': 'Germany',    'Sofia': 'Bulgaria',    'Republic Of China': 'Taiwan',    'Palm Harbor': 'United States',    'Vina del Mar': 'Chile',    'Guaruja': 'Brazil',    'Linz': 'Austria',
    'Napa': 'United States',    'Mar Del Plata': 'Argentina',    'Venice': 'Italy',    'La Quinta': 'United States',    'Toulouse': 'France',    'Monterrey': 'Mexico',    'Ancona': 'Italy',    'Bahia': 'Brazil',    'Delray Beach': 'United States',    'Genova': 'Italy',    'Strasbourg': 'France',
    'Zell Am See': 'Austria',    'Cap D\'Agde': 'France',    'Dortmund': 'Germany',    'Ferrara': 'Italy',    'Lisbon': 'Portugal',    'Detroit': 'United States',    'Bari': 'Italy',    'Livingston': 'United States',    'Honolulu': 'United States',    'Treviso': 'Italy',    'Luxembourg': 'Luxembourg',
    'Boca West': 'United States',    'Marbella': 'Spain',    'Stratton Mountain': 'United States',    'Fort Myers': 'United States',    'Itaparica': 'Brazil',    'St. Vincent': 'Saint Vincent and the Grenadines',    'Athens': 'Greece',    'Scottsdale': 'United States',
    'Schenectady': 'United States',    'Lyon': 'France',    'Key Biscayne': 'United States',    'Indian Wells': 'United States',    'Orlando': 'United States',    'Seoul': 'South Korea',    'Rye Brook': 'United States',
    'Wellington': 'New Zealand',    'Singapore': 'Singapore',    'San Marino': 'San Marino',    'Casablanca': 'Morocco',    'Estoril': 'Portugal',
    'Kiawah Island': 'United States', 'King\'s Cup 2R': 'United States',    'Montana Vermala': 'Switzerland',    'Kings Cup SF': 'United States',    'Kings Cup Final': 'United States',    'Champions Classic': 'United States',    'Tanglewood': 'United States',    'Alamo WCT': 'United States',    'Gothenberg WCT': 'Sweden',
    'Djakarta': 'Indonesia',    'Lacosta WCT': 'United States',    'World Invitational Classic': 'United States',    'Hempstead WCT': 'United States',    'Cedar Grove': 'United States',    'Tuscon': 'United States',    'Pepsi Grand Slam': 'United States',    'WCT Challenge Cup': 'United States',    'Tournament of Champions WCT': 'United States',
    'Colombus': 'United States',    'Nations Cup': 'United States',    'WCT Invitational': 'United States',    'Cap D\'Adge WCT': 'France',    'Umag': 'Croatia',    'Rosmalen': 'Netherlands',    'San Remo': 'Italy',    'Long Island': 'United States',    'Moscow': 'Russia',    'Tour Finals': 'United States',
    'Grand Slam Cup': 'United States',    'Brasilia': 'Brazil',    'Buzios': 'Brazil',    'Maceio': 'Brazil',    'Bolzano': 'Italy',    'Antwerp': 'Belgium',    'Doha': 'Qatar',    'Kuala Lumpur-1': 'Malaysia',   'Dubai': 'United Arab Emirates',    'Marseille': 'France',    'Zaragoza': 'Spain',    'Coral Springs': 'United States',    'Halle': 'Germany',    'Kuala Lumpur-2': 'Malaysia',
    'Beijing': 'China',    'Oahu': 'United States',    'Sun City': 'South Africa',    'Pinehurst': 'United States',    'St. Poelten': 'Austria',   'Kuala Lumpur': 'Malaysia',   'Ostrava': 'Czech Republic',    'Montevideo': 'Uruguay',    'Oporto': 'Portugal',    'Shanghai': 'China',    'Zagreb': 'Croatia',    'Chennai': 'India',
    'Tashkent': 'Uzbekistan',    'Split': 'Croatia',    's Hertogenbosch': 'Netherlands',    'Mallorca': 'Spain',    'Merano': 'Italy',    'Brighton': 'United Kingdom',    'Sopot': 'Poland',    'Costa Do Sauipe': 'Brazil',    'Amersfoort': 'Netherlands',    'Ho Chi Minh City': 'Vietnam',    'Poertschach': 'Austria',    'Mumbai': 'India',
    'Warsaw': 'Poland',    'Beijing Olympics': 'China',    'Montpellier': 'France',    'Winston-Salem': 'United States',    'Shenzhen': 'China',    'Marrakech': 'Morocco',    'Los Cabos': 'Mexico',    'Rio Olympics': 'Brazil',    'Chengdu': 'China',    'Budapest': 'Hungary',    'Antalya': 'Turkey',    'NextGen Finals': 'Italy',
    'Laver Cup': 'United States',    'Pune': 'India',    'Cordoba': 'Argentina',    'Zhuhai': 'China',    'Atp Cup': 'Australia',    'Us Open': 'United States',    'Sardinia': 'Italy',    'St Petersburg': 'Russia',    'Nur-Sultan': 'Kazakhstan',    'Great Ocean Road Open': 'Australia',    'Murray River Open': 'Australia',    'Cagliari': 'Italy',
    'Parma': 'Italy',    'San Diego': 'United States',    'Astana': 'Kazakhstan',    'Gijon': 'Spain',    'United Cup': 'Australia',    'Banja Luka': 'Bosnia and Herzegovina',   'Hangzhou': 'China',   'Almaty': 'Kazakhstan',    'Next Gen Finals': 'Italy',    'Asheville CH': 'United States',    'Raleigh CH': 'United States',    'Wall CH': 'United States',
    'Cape Cod CH': 'United States',    'Lancaster CH': 'United States',    'Tinton Falls CH': 'United States',    'Lincoln CH': 'United States',    'San Ramon CH': 'United States',    'Pasadena CH': 'United States',    'Kyoto CH': 'Japan',    'Indian River CH': 'United States',    'Nagoya CH': 'Japan',    'Cuneo CH': 'Italy',    'Galatina CH': 'Italy',
    'Green Bay CH': 'United States',    'Concord CH': 'United States',    'San Diego CH': 'United States',    'Porto Alegre CH': 'Brazil',    'Salvador CH': 'Brazil',    'Ribeiro Preto CH': 'Brazil',    'Biarritz CH': 'France',    'Royan CH': 'France',    'Le Touquet CH': 'France',    'Huntington Beach CH': 'United States',    'Austin CH': 'United States',
    'Kaduna CH': 'Nigeria',    'San Luis Potosi CH': 'Mexico',    'Shimizu City CH': 'Japan',    'Maebashi City CH': 'Japan',    'Toyota City CH': 'Japan',    'Lugo CH': 'Spain',    'Curitiba CH': 'Brazil',    'Turin CH': 'Italy',    'Campinas CH': 'Brazil',    'Cozenza CH': 'Italy',    'Messina CH': 'Italy',    'Ogun CH': 'Nigeria',    'Rio De La Plata CH': 'Argentina',
    'West Worthing CH': 'United Kingdom',    'Chitchester CH': 'United Kingdom',    'Mexicali CH': 'Mexico',    'Napoli CH': 'Italy',    'Torino CH': 'Italy',    'Travemunde CH': 'Germany',    'San Remo CH': 'Italy',    'La Spezia CH': 'Italy',    'Bara CH': 'France',    'Ostende CH': 'Belgium',
    'San Benedetto CH': 'Italy',    'Brasilia CH': 'Brazil',    'Tarragona CH': 'Spain',    'Reus CH': 'Spain',    'Layetano CH': 'Spain',    'Benin City CH': 'Nigeria',    'Nairobi CH': 'Kenya',    'Buchholz CH': 'Germany',    'Tunis CH': 'Tunisia',    'Chigasaki CH': 'Japan',    'Nagareyama CH': 'Japan',
    'Solihull CH': 'United Kingdom',    'Lee-On-Solent CH': 'United Kingdom',    'Brescia CH': 'Italy',    'Tampere CH': 'Finland',    'Campos CH': 'Mexico',    'Neu Ulm CH': 'Germany',    'Knokke CH': 'Belgium',    'Ostend CH': 'Belgium',    'Thessaloniki CH': 'Greece',    'Oporto CH': 'Portugal',
    'Kuwait City CH': 'Kuwait',    'Ashkelon CH': 'Israel',    'Spring CH': 'United States',    'Santos CH': 'Brazil',    'Vigo CH': 'Spain',    'Amarillo CH': 'United States',    'Agadir CH': 'Morocco',    'Vina Del Mar CH': 'Chile',    'Bahrain CH': 'Bahrain',    'Marrakech CH': 'Morocco',    'Sutton CH': 'United Kingdom',    'Bielefeld CH': 'Germany',
    'Neunkirchen CH': 'Germany',    'Winnetka CH': 'United States',    'Jerusalem CH': 'Israel',    'Bergen CH': 'Norway',    'West Palm CH': 'United States',    'Belo Horizonte CH': 'Brazil',    'Enugu CH': 'Nigeria',    'Loipersdorf CH': 'Austria',    'Clermont Ferrand CH': 'France',    'Chartres CH': 'France',    'Hanko CH': 'Finland',
    'Sapporo CH': 'Japan',    'Budapest CH': 'Hungary',    'Fukuoka CH': 'Japan',    'Valkenswaard CH': 'Netherlands',    'Cherbourg CH': 'France',    'Graz CH': 'Austria',    'Martinique CH': 'Martinique',    'Guadeloupe CH': 'Guadeloupe',    'Waiblingen CH': 'Germany',    'Montabaur CH': 'Germany',    'Tarbes CH': 'France',    'Furth CH': 'Germany',
    'Coquitlam CH': 'Canada',    'Bossonnens CH': 'Switzerland',    'Munster CH': 'Germany',    'Capetown CH': 'South Africa',    'Heilbronn CH': 'Germany',    'Liege CH': 'Belgium',    'Madeira CH': 'Portugal',    'Vilamoura CH': 'Portugal',    'Salzburg CH': 'Austria',    'Dijon CH': 'France',    'Salou CH': 'Spain',    'Lins CH': 'Brazil',    'Crans Montana CH': 'Switzerland',
    'Eger CH': 'Hungary',    'Pescara CH': 'Italy',    'Rumikon CH': 'Switzerland',    'Azores CH': 'Portugal',    'Nyon CH': 'Switzerland',    'Verona CH': 'Italy',    'Nugra Santana CH': 'Brazil',    'Guangzhou CH': 'China',    'Tasmania CH': 'Australia',    'Brest CH': 'France',    'Ogbe CH': 'Nigeria',    'Cascais CH': 'Portugal',    'Okada CH': 'Japan',
    'Telford CH': 'United Kingdom',    'Croydon CH': 'United Kingdom',    'Troia Setubal CH': 'Portugal',    'Modena CH': 'Italy',    'Zaragoza CH': 'Spain',    'Hossegor CH': 'France',    'Salerno CH': 'Italy',    'Chicoutimi CH': 'Canada',    'Kuala Lumpur CH': 'Malaysia',    'Odrimont CH': 'Belgium',    'Goiania CH': 'Brazil',    'Nicosia CH': 'Cyprus',    'Beijing CH': 'China',
    'Nairobi1 CH': 'Kenya',    'Nairobi2 CH': 'Kenya',    'Brasilia1 CH': 'Brazil',    'Capetown1 CH': 'South Africa',    'Pretoria CH': 'South Africa',    'Ljubljana CH': 'Slovenia',    'Gramado CH': 'Brazil',    'Brasilia2 CH': 'Brazil',    'Canberra CH': 'Australia',    'Manaus CH': 'Brazil',    'Ilheus CH': 'Brazil',
    'Ponte Vedra CH': 'United States',    'The Hague CH': 'Netherlands',    'Guam CH': 'United States',    'Knokke CH': 'Belgium',    'Lausanne CH': 'Switzerland',    'Ostend CH': 'Belgium',    'Utrecht CH': 'Netherlands',    'Newport Beach CH': 'United States',
    'Djkarta': 'Indonesia','Americana CH': 'Brazil','Ribeirao CH': 'Brazil','Sevilla CH': 'Spain','Kakegawa CH': 'Japan','Newcastle CH': 'United Kingdom','Fortaleza CH': 'Brazil','Cervia CH': 'Italy','Segovia CH': 'Spain','Maderia1 CH': 'Portugal','Whistler CH': 'Canada','Bloomfield CH': 'United States','Cali CH': 'Colombia','Siracusa CH': 'Italy','Pembroke Pines CH': 'United States',
'Reggio Calabri CH': 'Italy','Puebla CH': 'Mexico','Rennes CH': 'France','Yvetot CH': 'France','Oberstaufen CH': 'Germany','Poznan CH': 'Poland','Ixtapa CH': 'Mexico','Recife CH': 'Brazil','Brunei CH': 'Brunei','Halifax CH': 'Canada','Sao Luis CH': 'Brazil','Launceston CH': 'Australia','Tenerife CH': 'Spain','Lippstadt CH': 'Germany','Punta Del Este CH': 'Uruguay','Wolfsburg CH': 'Germany',
'Emden CH': 'Germany','Garmisch CH': 'Germany','Bergamo CH': 'Italy','Riemerling CH': 'Germany','Dresden CH': 'Germany','Bruck CH': 'Germany','Bochum CH': 'Germany','Kosice CH': 'Slovakia','Porto1 CH': 'Portugal','Eisenach CH': 'Germany','Oostende CH': 'Belgium','Montauban CH': 'France','Montebello CH': 'United States','Bronx CH': 'United States','Natal CH': 'Brazil','Porto2 CH': 'Portugal','Cotia CH': 'Brazil','Reunion Island CH': 'France',
'Rogaska CH': 'Slovenia','Andorra CH': 'Andorra','Celle CH': 'Germany','Belem CH': 'Brazil','Puerto Vallarta CH': 'Mexico','Malta CH': 'Malta','Annenheim CH': 'Germany','Weiden CH': 'Germany','Braunschweig CH': 'Germany','Porto CH': 'Portugal','Seville CH': 'Spain','Campos Do Jordao CH': 'Brazil','Pilzen CH': 'Czech Republic','Ribeirao Preta CH': 'Brazil','Guayaquil CH': 'Ecuador','Glendale CH': 'United States','Nantes CH': 'France','Prostejov CH': 'Czech Republic',
'Hamburen CH': 'Germany','Mendoza CH': 'Argentina','Punta Del Este2 CH': 'Uruguay','Asuncion CH': 'Paraguay','Medellin CH': 'Colombia','Ulm CH': 'Germany','Granby CH': 'United States','Lillehammer CH': 'Norway','Lexington CH': 'United States','Aruba CH': 'Aruba','Charleroi CH': 'Belgium','Goa CH': 'India','Salinas CH': 'United States','Bromma CH': 'Sweden','Puerta Vallarta CH': 'Mexico','West Bloomfield CH': 'United States','Fergana CH': 'Uzbekistan','Andijan CH': 'Uzbekistan','Bratislava CH': 'Slovakia',
'Szczecin CH': 'Poland','Alicante CH': 'Spain','Alpirsbach CH': 'Germany','Samarkand CH': 'Uzbekistan','Brasov CH': 'Romania','Madras CH': 'India','Olbia CH': 'Italy','Bad Saarow CH': 'Germany','Budva CH': 'Montenegro','Skopje CH': 'North Macedonia','Urbana CH': 'United States','Tanagura CH': 'Japan','Ahmedabad CH': 'India','Neumunster CH': 'Germany',
   'Mauritius Island CH': 'Mauritius',    'Portoroz CH': 'Slovenia',    'Lubeck CH': 'Germany',    'Magdeburg CH': 'Germany',    'Barletta CH': 'Italy',    'Flushing Meadow CH': 'United States',    'Contrexeville CH': 'France',    'Nettingsdorf CH': 'Austria',    'Santa Cruz CH': 'United States',    'Edinburgh CH': 'United Kingdom',    'Espinho CH': 'Portugal',    'Sedona CH': 'United States',    'Eckental CH': 'Germany',    'Rio Grande CH': 'United States',    'Burbank CH': 'United States',    'Bad Lippspringe CH': 'Germany',    'Eilat CH': 'Israel',    'Wismar CH': 'Germany',    'Ho Chi Minh CH': 'Vietnam',
    'Vadodara CH': 'India',    'Kiev CH': 'Ukraine',    'Biella CH': 'Italy',    'Pribram CH': 'Czech Republic',    'Tijuana CH': 'Mexico',    'Florianopolis CH': 'Brazil',    'Maia CH': 'Portugal',    'Toluca CH': 'Mexico',    'Nuembrecht CH': 'Germany',    'Lucknow CH': 'India',    'Laguna Hills CH': 'United States',    'Grenoble CH': 'France',    'Besancon CH': 'France',
    'Bressanone CH': 'Italy',    'Sylt CH': 'Germany',    'Manerbio CH': 'Italy',    'Freudenstadt CH': 'Germany',    'Aschaffenburg CH': 'Germany',    'Yokohama CH': 'Japan',    'Lucknow2 CH': 'India',    'Jaipur CH': 'India',    'Knoxville CH': 'United States',    'Waikoloa CH': 'United States',    'Hamilton CH': 'New Zealand',    'Tangier CH': 'Morocco',    'Bukhara CH': 'Uzbekistan',    'Costa Rica CH': 'Costa Rica',    'Armonk CH': 'United States',
    'Togliatti CH': 'Russia',    'Tallahassee CH': 'United States',    'Sassuolo CH': 'Italy',    'Wroclaw CH': 'Poland',    'Hull CH': 'United Kingdom',    'Wrexham CH': 'United Kingdom',    'Monchengladbach CH': 'Germany',    'Tyler CH': 'United States',    'Campinas1 CH': 'Brazil',    'Budaors CH': 'Hungary',    'Bolton CH': 'United Kingdom',    'Kerrville CH': 'United States',    'Luebeck CH': 'Germany',    'Kamnik CH': 'Slovenia',    'Rocky Mount CH': 'United States',    'Calabasas CH': 'United States',    'Ribeirao Preto CH': 'Brazil',
    'Tarzana CH': 'United States',    'Andrezieux CH': 'France',    'Chandigarh CH': 'India',    'Brindisi CH': 'Italy',    'Mantova CH': 'Italy',    'Campos Do Jordao1 CH': 'Brazil',   'Campinas2 CH': 'Brazil',    'Campos Do Jordao2 CH': 'Brazil',    'Zabrze CH': 'Poland',    'Joplin CH': 'United States',    'Gosford CH': 'Australia',    'Leon CH': 'Mexico',    'Trani CH': 'Italy',    'Donetsk CH': 'Ukraine',   'Fresno CH': 'United States',
    'Waco CH': 'United States',    'Champaign CH': 'United States',    'Sarajevo CH': 'Bosnia and Herzegovina',    'Aix En Provence CH': 'France',    'Atlantic City CH': 'United States',    'Reggio Emilia CH': 'Italy',    'Kosice2 CH': 'Slovakia',    'Zell CH': 'Germany',    'Busan CH': 'South Korea',    'Recanati CH': 'Italy',    'Valladolid CH': 'Spain',    'Mordovia CH': 'Russia',    'St. Jean De Luz CH': 'France',    'Groningen CH': 'Netherlands',    'Mandeville CH': 'United States',    'Tiburon CH': 'United States',
    'Torrance CH': 'United States',    'Tumkur CH': 'India',    'Dharwad CH': 'India',    'Belgaum CH': 'India',    'Dnepropetrovsk CH': 'Ukraine',    'Ischgl CH': 'Austria',    'New Caledonia CH': 'New Caledonia',    'St. Brieuc CH': 'France',    'Rimini CH': 'Italy',    'Saransk CH': 'Russia',    'Timisoara CH': 'Romania',    'Cordenons CH': 'Italy',    'Manta CH': 'Ecuador',    'Covington CH': 'United States',    'Dubrovnik CH': 'Croatia',    'Homestead CH': 'United States',    'Caloundra CH': 'Australia',    'Aracaju CH': 'Brazil',    'Kish Island CH': 'Iran',
    'Mauritius CH': 'Mauritius',    'College Station CH': 'United States', 'Santa Cruz de la Sierra CH': 'Bolivia',    'Burnie CH': 'Australia',    'Noumea CH': 'New Caledonia',    'La Serena CH': 'Chile',    'Sunrise CH': 'United States',    'Monza CH': 'Italy',    'Tunica Resorts CH': 'United States',   'Ettlingen CH': 'Germany',    'Yuba City CH': 'United States',    'Pamplona CH': 'Spain',    'Orleans CH': 'France',    'Lubbock CH': 'United States',    'Cuenca CH': 'Ecuador',    'Mons CH': 'Belgium',    'Kolding CH': 'Denmark',   'Carson CH': 'United States',    'Sunderland CH': 'United Kingdom',    'Aguascalientes CH': 'Mexico',
    'Cardiff CH': 'United Kingdom',    'Chiasso CH': 'Switzerland',    'Lanzarote CH': 'Spain',    'Chikmagalur CH': 'India',    'Telde CH': 'Spain',    'Constanta CH': 'Romania',    'Penza CH': 'Russia',    'Joinville CH': 'Brazil',    'Como CH': 'Italy',    'Kranj CH': 'Slovenia',    'Kawana CH': 'Australia',    'Shrewsbury CH': 'United Kingdom',    'Rimouski CH': 'Canada',    'Mas Palomas CH': 'Spain',    'Rabat CH': 'Morocco',    'Fes CH': 'Morocco',    'Rijeka CH': 'Croatia',    'Karlsruhe CH': 'Germany',   'Bytom CH': 'Poland',    'Cherkassy CH': 'Ukraine',    'Alphen aan den Rijn CH': 'Netherlands',    'Todi CH': 'Italy',    'Trnava CH': 'Slovakia',    'Karshi CH': 'Uzbekistan',    'Barnstaple CH': 'United Kingdom',
    'Kaohsiung CH': 'Taiwan',    'Burnie2 CH': 'Australia',    'Florianopolis II CH': 'Brazil',    'Meknes CH': 'Morocco',    'Tanger CH': 'Morocco',    'Humacao CH': 'Puerto Rico',    'Baton Rouge CH': 'United States',    'Cremona CH': 'Italy',    'Aarhus CH': 'Denmark',    'Bradenton CH': 'United States',    'Izmir CH': 'Turkey',    'Alessandria CH': 'Italy',    'Ramat Hasharon CH': 'Israel',    'Moncton CH': 'Canada',    'Medjugorje CH': 'Bosnia and Herzegovina',    'San Sebastian CH': 'Spain',    'Cali2 CH': 'Colombia',
    'Jersey CH': 'United Kingdom',    'Cancun CH': 'Mexico',    'Toyota CH': 'Japan',    'Blumenau CH': 'Brazil',    'Napoli2 CH': 'Italy',    'Pozoblanco CH': 'Spain',    'Bucaramanga CH': 'Colombia',    'Iquique CH': 'Chile',    'Caltanissetta CH': 'Italy',    'Khorat CH': 'Thailand',    'Rhodes CH': 'Greece',    'Pereira CH': 'Colombia',    'Savannah CH': 'United States',    'Carson2 CH': 'United States',    'Orbetello CH': 'Italy',    'St. Remy CH': 'France',    'Chuncheon CH': 'South Korea',
    'Jersey2 CH': 'United Kingdom',    'Khanty-Mansiysk CH': 'Russia',    'Arad CH': 'Romania',    'Ojai CH': 'United States',    'Kazan CH': 'Russia',    'Marburg CH': 'Germany',    'Belo Horizonte2 CH': 'Brazil',    'Loughborough CH': 'United Kingdom',    'Courmayeur CH': 'Italy',    'Quimper CH': 'France',    'Le Gosier CH': 'Guadeloupe',    'Bath CH': 'United Kingdom',    'Pingguo CH': 'China',    'Wuhai CH': 'China',    'Ningbo CH': 'China',    'Recife2 CH': 'Brazil',   'Sao Jose Do Rio Preto CH': 'Brazil',
    'Sao Leopoldo CH': 'Brazil',    'Mersin CH': 'Turkey',    'Rio Quente CH': 'Brazil',    'Panama City CH': 'Panama',    'An-Ning CH': 'China',    'Bercuit CH': 'Belgium',    'Wuhan CH': 'China',    'Sibiu CH': 'Romania',    'Petange CH': 'Luxembourg',    'Lermontov CH': 'Russia',    'Villa Allende CH': 'Argentina',    'Tyumen CH': 'Russia',    'West Lakes CH': 'Australia',    'Kun-Ming CH': 'China',    'Blois CH': 'France',    'Eskisehir CH': 'Turkey',    'Guimaraes CH': 'Portugal',    'Liberec CH': 'Czech Republic',    'Meerbusch CH': 'Germany',    'Kenitra CH': 'Morocco',
    'Mouilleron-Le-Captif CH': 'France',    'Kazan2 CH': 'Russia',    'Traralgon CH': 'Australia',    'Yeongwol CH': 'South Korea',    'Andria CH': 'Italy',    'Irving CH': 'United States',    'Mouilleron Le Captif CH': 'France',    'Chitre CH': 'Panama',    'Kolkata CH': 'India',    'Morelos CH': 'Mexico',    'Vercelli CH': 'Italy',    'Gimcheon CH': 'South Korea',    'Heilbronn II CH': 'Germany',    'Vicenza CH': 'Italy',    'Mestre CH': 'Italy',    'Tianjin CH': 'China',    'Mohammedia CH': 'Morocco',    'Nanchang CH': 'China',    'Padova CH': 'Italy',    'Cortina CH': 'Italy',
    'Cali II CH': 'Colombia',    'Indore CH': 'India',    'Traralgon2 CH': 'Australia',    'St Brieuc CH': 'France',    'Alphen CH': 'Netherlands',    'Braunschweig CH': 'Germany',  'Potro Alegre CH': 'Brazil',    'Happy Valley CH': 'Hong Kong',    'Santo Domingo CH': 'Dominican Republic',    'Glasgow CH': 'United Kingdom',    'Drummondville CH': 'Canada',    'Raanana CH': 'Israel',    'Batman CH': 'Turkey',    'Cary CH': 'United States',    'Agri CH': 'Turkey',    'Corrientes CH': 'Argentina',    'Suzhou CH': 'China',    'Hua Hin CH': 'Thailand',    'Kobe CH': 'Japan',    'Perugia CH': 'Italy',    'Slovakia CH': 'Slovakia',    'Ilkley CH': 'United Kingdom',    'Stockton CH': 'United States',
    'San Benedetto del Tronto CH': 'Italy',    'St Remy de Provence CH': 'France',    'Anning CH': 'China',    'Jonkoping CH': 'Sweden',    'Gwangju CH': 'South Korea',    'Nanjing CH': 'China',    'Winnipeg CH': 'Canada',    'Qingdao CH': 'China',    'Gatineau CH': 'Canada',    'Fano CH': 'Italy',    'Poprad CH': 'Slovakia',    'Lahaina CH': 'United States',    'Saint Brieuc CH': 'France',    'Alphen Aan Den Rijn CH': 'Netherlands',    'San Benedetto Del Tronto CH': 'Italy',    'Floridablanca CH': 'Colombia',    'Cuernavaca CH': 'Mexico',    'Tigre CH': 'Argentina',
    'Koblenz CH': 'Germany',    'Quanzhou CH': 'China',    'Sophia Antipolis CH': 'France',    'Francavilla Al Mare CH': 'Italy',    'Shymkent CH': 'Kazakhstan',    'Jinan CH': 'China',    'Zhangjiagang CH': 'China',    'Ismaning CH': 'Germany',    'Poprad-Tatry CH': 'Slovakia',    'St.Brieuc CH': 'France',    'L\'Aquila CH': 'Italy',    'Bengaluru CH': 'India',    'Playford CH': 'Australia',    'Lille CH': 'France',    'Qujing CH': 'China',    'Braga CH': 'Portugal',    'Pullach CH': 'Germany',    'Poprad Tatry CH': 'Slovakia',    'Cassis CH': 'France',    'Liuzhou CH': 'China',    'Champaign-Urbana CH': 'United States',    'Lisboa CH': 'Portugal',    'Villena CH': 'Spain',
    'Augsburg CH': 'Germany',    'Yokkaichi CH': 'Japan',    'Baotou CH': 'China',    'Da Nang CH': 'Vietnam',    'Pau CH': 'France',    'Ludwigshafen CH': 'Germany',    'Ann Arbor CH': 'United States',    'Bendigo CH': 'Australia',    'Koblenz CH': 'Germany',    'Potchefstroom CH': 'South Africa',    'Iasi CH': 'Romania',    'Trieste CH': 'Italy',    'Forli CH': 'Italy',    'Salinas 1 CH': 'United States',    'Bratislava 1 CH': 'Slovakia',    'Oeiras 1 CH': 'Portugal',    'Bratislava 2 CH': 'Slovakia',    'Quimper 1 CH': 'France',    'Liberec CH': 'Czech Republic',    'Aix-En-Provence CH': 'France',    'Biella 1 CH': 'Italy',    'Cary 1 CH': 'United States',
    'Manacor CH': 'Spain',    'Maia 1 CH': 'Portugal',    'Potchefstroom 1 CH': 'South Africa',    'Biella 2 CH': 'Italy',    'Potchefstroom 2 CH': 'South Africa',    'Concepcion CH': 'Chile',    'Quimper 2 CH': 'France',    'Biella 3 CH': 'Italy',    'Biella 4 CH': 'Italy',    'Zadar CH': 'Croatia',    'Oeiras 2 CH': 'Portugal',    'Biella 5 CH': 'Italy',    'Biella 7 CH': 'Italy',    'Biella 6 CH': 'Italy',    'Oeiras 4 CH': 'Portugal',    'Salinas 2 CH': 'United States',    'Oeiras 3 CH': 'Portugal',    'Luedenscheid CH': 'Germany',    'St. Tropez CH': 'France',    'Tulln CH': 'Austria',    'Kyiv CH': 'Ukraine',    'Cary 2 CH': 'United States',    'Ambato CH': 'Ecuador',    'Biel CH': 'Switzerland',    'Ercolano CH': 'Italy',
    'Losinj CH': 'Croatia',    'Roanne CH': 'France',    'Manama CH': 'Bahrain',    'Forli 2 CH': 'Italy',    'Forli 3 CH': 'Italy',    'Maia 2 CH': 'Portugal',    'El Espinar CH': 'Spain',    'Coquimbo CH': 'Chile',    'Troisdorf CH': 'Germany',    'Forli 6 CH': 'Italy',    'Malaga CH': 'Spain',    'Troyes CH': 'France',    'Genoa CH': 'Italy',    'Saint-Brieuc CH': 'France',    'Zug CH': 'Switzerland',    'Grodzisk Mazowiecki CH': 'Poland',    'Nonthaburi 1 CH': 'Thailand',    'Nonthaburi 2 CH': 'Thailand',    'Nonthaburi 3 CH': 'Thailand',    'Villa Maria CH': 'Argentina',    'Vilnius CH': 'Lithuania',    'Maspalomas CH': 'Spain',    'Temuco CH': 'Chile',    'Shymkent 1 CH': 'Kazakhstan',    'Bengaluru 1 CH': 'India',    'Matsuyama CH': 'Japan',    'Shymkent 2 CH': 'Kazakhstan',
    'Oeiras CH': 'Portugal',    'Saint Tropez CH': 'France',    'Forli 1 CH': 'Italy',    'Sanremo CH': 'Italy',    'Mauthausen CH': 'Austria',    'Bengaluru 2 CH': 'India',    'Forli 4 CH': 'Italy',    'Forli 5 CH': 'Italy',    'Roseto Degli Abruzzi 1 CH': 'Italy',    'Roseto Degli Abruzzi 2 CH': 'Italy',    'Santa Cruz De La Sierra CH': 'Bolivia',    'Santa Fe CH': 'Argentina',    'Szekesfehervar CH': 'Hungary',    'Piracicaba CH': 'Brazil',    'Ottignies Louvain CH': 'Belgium',    'Tenerife 2 CH': 'Spain',    'Tenerife 3 CH': 'Spain',    'Rovereto CH': 'Italy',    'Les Franqueses Del Valles CH': 'Spain',    'Girona CH': 'Spain',    'Bloomfield Hills CH': 'United States',    'Palo Alto CH': 'United States',    'Antofagasta CH': 'Chile',    'Bad Waltersdorf CH': 'Austria',    'Danderyd CH': 'Sweden',
    'Saint-Tropez CH': 'France',    'Biel-Bienne CH': 'Switzerland',    'Tenerife 1 CH': 'Spain',    'Tigre 1 CH': 'Argentina',    'Tigre 2 CH': 'Argentina',    'Roseto Degli Abruzzi CH': 'Italy',    'Montechiarugolo CH': 'Italy',    'Ottignies-Louvain-la-Neuve CH': 'Belgium',    'Burnie 2 CH': 'Australia',    'Kigali 1 CH': 'Rwanda',    'Kigali 2 CH': 'Rwanda',    'Merida CH': 'Mexico',    'San Miguel De Tucuman CH': 'Argentina',    'Wuxi CH': 'China',    'Kachreti CH': 'Georgia',    'Ibague CH': 'Colombia',    'Bonn CH': 'Germany',    'Dobrich CH': 'Bulgaria',    'Nonthaburi 4 CH': 'Thailand',    'Mouilleron le Captif CH': 'France',    'Sioux Falls CH': 'United States',    'Brazzaville CH': 'Republic of the Congo',
    'Montemar CH': 'Chile',    'Manzanillo CH': 'Mexico',    'St Remy CH': 'France', 'Braunschweig': 'Germany', 'Koblenz': 'Germany',  'Liberec': 'Czech Republic', 'Braunchweig': 'Germany'  }

# Reemplazar valores en la columna COUNTRY basándose en TOURNEY_NAME
for city, country in city_to_country.items():
    df_simple.loc[df_simple['TOURNEY_NAME'].str.contains(city, na=False), 'COUNTRY'] = country

df_none_country = df_simple[df_simple['COUNTRY'].isna() & ~df_simple['TOURNEY_NAME'].str.contains('Davis Cup', na=False)]


df_simple['TOURNEY_NAME'] = df_simple['TOURNEY_NAME'].replace({
    'Indian Wells Masters': 'Indian Wells',
    'Canada Masters': 'Canada',
    'Cincinnati Masters': 'Cincinnati',
    'Hamburg Masters': 'Hamburg',
    'Madrid Masters': 'Madrid',
    'Miami Masters': 'Miami',
    'Rome Masters': 'Rome',
    'Paris Masters': 'Paris',
    'Shanghai Masters': 'Shanghai',
    'Monte Carlo Masters': 'Monte Carlo',
    'Stockholm Masters': 'Stockholm', 
    'Stuttgart Masters': 'Stuttgart' 
    
})


columns_stat = [
    'MATCH_ID', 'W_T_ACES', 'W_T_DOUBLE_FAULTS', 'W_T_WINNERS', 'W_T_UNFORCED_ERRORS',
    'W_T_AVERAGE_1ST_SERVE_SPEED', 'W_T_AVERAGE_2ND_SERVE_SPEED', 'W_T_1ST_SERVE_PERCENTAGE',
    'W_T_1ST_SERVE_POINTS_WON_PERCENTAGE', 'W_T_1ST_SERVE_POINTS_WON', 'W_T_1ST_SERVE_POINTS_PLAYED',
    'W_T_2ND_SERVE_POINTS_WON_PERCENTAGE', 'W_T_2ND_SERVE_POINTS_WON', 'W_T_2ND_SERVE_POINTS_PLAYED',
    'W_T_BREAK_POINTS_SAVED_PERCENTAGE', 'W_T_BREAK_POINTS_SAVED', 'W_T_BREAK_POINTS_FACED',
    'W_T_1ST_RETURN_POINTS_WON_PERCENTAGE', 'W_T_1ST_RETURN_POINTS_WON', 'W_T_1ST_RETURN_POINTS_PLAYED',
    'W_T_2ND_RETURN_POINTS_WON_PERCENTAGE', 'W_T_2ND_RETURN_POINTS_WON', 'W_T_2ND_RETURN_POINTS_PLAYED',
    'W_T_BREAK_POINTS_CONVERTED_PERCENTAGE', 'W_T_BREAK_POINTS_CONVERTED', 'W_T_BREAK_POINTS_CHANCES',
    'W_T_SERVICE_POINTS_WON_PERCENTAGE', 'W_T_SERVICE_POINTS_WON', 'W_T_SERVICE_POINTS_PLAYED',
    'W_T_RETURN_POINTS_WON_PERCENTAGE', 'W_T_RETURN_POINTS_WON', 'W_T_RETURN_POINTS_PLAYED',
    'W_T_TOTAL_POINTS_WON_PERCENTAGE', 'W_T_TOTAL_POINTS_WON', 'W_T_TOTAL_POINTS_PLAYED',
    'W_T_LAST_10_BALLS', 'W_T_MATCH_POINTS_SAVED', 'W_T_SERVICE_GAMES_WON_PERCENTAGE',
    'W_T_SERVICE_GAMES_WON', 'W_T_SERVICE_GAMES_PLAYED', 'W_T_RETURN_GAMES_WON_PERCENTAGE',
    'W_T_RETURN_GAMES_WON', 'W_T_RETURN_GAMES_PLAYED', 'W_T_TOTAL_GAMES_WON_PERCENTAGE',
    'W_T_TOTAL_GAMES_WON', 'W_T_TOTAL_GAMES_PLAYED', 'W_T_NET_POINTS_WON_PERCENTAGE', 
    'W_T_NET_POINTS_WON', 'W_T_NET_POINTS_WON_PLAYED', 'W_T_DISTANCE_COVERED_METERS'
]

# Crear un DataFrame vacío con las columnas especificadas
stats_w_t = pd.DataFrame(columns=columns_stat)

column_mapping = {
    'tourney_id': 'MATCH_ID',
    'w_ace': 'W_T_ACES',
    'w_df': 'W_T_DOUBLE_FAULTS',
    'w_svpt': 'W_T_SERVICE_POINTS_PLAYED',
    'w_1stIn': 'W_T_1ST_SERVE_POINTS_PLAYED',
    'w_1stWon': 'W_T_1ST_SERVE_POINTS_WON',
    'w_2ndWon': 'W_T_2ND_SERVE_POINTS_WON',
    'w_SvGms': 'W_T_SERVICE_GAMES_PLAYED',
    'w_bpSaved': 'W_T_BREAK_POINTS_SAVED',
    'w_bpFaced': 'W_T_BREAK_POINTS_FACED'
}

stats_w_t = df_completo[list(column_mapping.keys())].rename(columns=column_mapping)

missing_columns = [col for col in columns_stat if col not in stats_w_t.columns]

# Añadir las columnas faltantes con valores None
for col in missing_columns:
    stats_w_t[col] = None


columns_stat = [
    'MATCH_ID', 'L_T_ACES', 'L_T_DOUBLE_FAULTS', 'L_T_WINNERS', 'L_T_UNFORCED_ERRORS',
    'L_T_AVERAGE_1ST_SERVE_SPEED', 'L_T_AVERAGE_2ND_SERVE_SPEED', 'L_T_1ST_SERVE_PERCENTAGE',
    'L_T_1ST_SERVE_POINTS_WON_PERCENTAGE', 'L_T_1ST_SERVE_POINTS_WON', 'L_T_1ST_SERVE_POINTS_PLAYED',
    'L_T_2ND_SERVE_POINTS_WON_PERCENTAGE', 'L_T_2ND_SERVE_POINTS_WON', 'L_T_2ND_SERVE_POINTS_PLAYED',
    'L_T_BREAK_POINTS_SAVED_PERCENTAGE', 'L_T_BREAK_POINTS_SAVED', 'L_T_BREAK_POINTS_FACED',
    'L_T_1ST_RETURN_POINTS_WON_PERCENTAGE', 'L_T_1ST_RETURN_POINTS_WON', 'L_T_1ST_RETURN_POINTS_PLAYED',
    'L_T_2ND_RETURN_POINTS_WON_PERCENTAGE', 'L_T_2ND_RETURN_POINTS_WON', 'L_T_2ND_RETURN_POINTS_PLAYED',
    'L_T_BREAK_POINTS_CONVERTED_PERCENTAGE', 'L_T_BREAK_POINTS_CONVERTED', 'L_T_BREAK_POINTS_CHANCES',
    'L_T_SERVICE_POINTS_WON_PERCENTAGE', 'L_T_SERVICE_POINTS_WON', 'L_T_SERVICE_POINTS_PLAYED',
    'L_T_RETURN_POINTS_WON_PERCENTAGE', 'L_T_RETURN_POINTS_WON', 'L_T_RETURN_POINTS_PLAYED',
    'L_T_TOTAL_POINTS_WON_PERCENTAGE', 'L_T_TOTAL_POINTS_WON', 'L_T_TOTAL_POINTS_PLAYED',
    'L_T_LAST_10_BALLS', 'L_T_MATCH_POINTS_SAVED', 'L_T_SERVICE_GAMES_WON_PERCENTAGE',
    'L_T_SERVICE_GAMES_WON', 'L_T_SERVICE_GAMES_PLAYED', 'L_T_RETURN_GAMES_WON_PERCENTAGE',
    'L_T_RETURN_GAMES_WON', 'L_T_RETURN_GAMES_PLAYED', 'L_T_TOTAL_GAMES_WON_PERCENTAGE',
    'L_T_TOTAL_GAMES_WON', 'L_T_TOTAL_GAMES_PLAYED', 'L_T_NET_POINTS_WON_PERCENTAGE', 
    'L_T_NET_POINTS_WON', 'L_T_NET_POINTS_WON_PLAYED', 'L_T_DISTANCE_COVERED_METERS'
]

# Crear un DataFrame vacío con las columnas especificadas
stats_l_t = pd.DataFrame(columns=columns_stat)

column_mapping = {
    'tourney_id': 'MATCH_ID',
    'l_ace': 'L_T_ACES',
    'l_df': 'L_T_DOUBLE_FAULTS',
    'l_svpt': 'L_T_SERVICE_POINTS_PLAYED',
    'l_1stIn': 'L_T_1ST_SERVE_POINTS_PLAYED',
    'l_1stWon': 'L_T_1ST_SERVE_POINTS_WON',
    'l_2ndWon': 'L_T_2ND_SERVE_POINTS_WON',
    'l_SvGms': 'L_T_SERVICE_GAMES_PLAYED',
    'l_bpSaved': 'L_T_BREAK_POINTS_SAVED',
    'l_bpFaced': 'L_T_BREAK_POINTS_FACED'
}

stats_l_t = df_completo[list(column_mapping.keys())].rename(columns=column_mapping)

missing_columns = [col for col in columns_stat if col not in stats_l_t.columns]

# Añadir las columnas faltantes con valores None
for col in missing_columns:
    stats_l_t[col] = None
    

stats_w_t = stats_w_t.where(pd.notnull(stats_w_t), None)
stats_w_t = stats_w_t.applymap(lambda x: None if pd.isna(x) else x)
stats_w_t['W_T_BREAK_POINTS_SAVED'] = stats_w_t['W_T_BREAK_POINTS_SAVED'].apply(lambda x: None if x < 0 else x)


stats_l_t = stats_l_t.where(pd.notnull(stats_l_t), None)
stats_l_t = stats_l_t.applymap(lambda x: None if pd.isna(x) else x)
stats_l_t['L_T_BREAK_POINTS_SAVED'] = stats_l_t['L_T_BREAK_POINTS_SAVED'].apply(lambda x: None if x < 0 else x)


   ###################################### 
    
from sqlalchemy import create_engine

# Reemplaza con tus credenciales de base de datos
user = 'root'
password = 'etsol521'
host = '127.0.0.1'  # O la IP del servidor
database = 'tennis_db'

# Crea el engine de conexión
engine = create_engine(f'mysql+pymysql://{user}:{password}@{host}/{database}')

simple_name = categoria + "_simple"
df_simple.to_sql(simple_name, con=engine, if_exists='append', index=False)

stats_w_name = categoria + "_stats_w_t"
stats_w_t.to_sql(stats_w_name, con=engine, if_exists='append', index=False)

stats_l_name = categoria + "_stats_l_t"
stats_l_t.to_sql(stats_l_name, con=engine, if_exists='append', index=False)

