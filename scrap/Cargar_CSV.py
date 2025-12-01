# -*- coding: utf-8 -*-
"""
Created on Wed Jan  3 12:45:58 2024

@author: Paula
"""

import pandas as pd
import os
import numpy as np
from datetime import datetime

categoria = "atp"

os.chdir("/Users/paula/Documents/TennisData/TennisData/FS_matches/2025/")


# Función para cargar un archivo CSV en un DataFrame y agregar una columna de identificación
def cargar_csv_y_agregar_id(archivo, carpeta, id_partido, columnas):
    # Separar el id_partido en sus partes
    partes = id_partido.split("_")
    yyyy, id_code, hhmmss = partes[0], partes[1], partes[2]

    # Asegurar que id_code tenga 4 caracteres, agregando un 0 a la izquierda si tiene solo 3
    id_code = id_code.zfill(4)  # Rellena con ceros a la izquierda si es necesario

    # Reconstruir id_partido corregido
    id_partido = f"{yyyy}_{id_code}_{hhmmss}"

    # Leer el archivo CSV y asignar los nombres de columna
    if carpeta == "stats":
        df = pd.read_csv(os.path.join(carpeta, archivo))
        df["MATCH_ID"] = id_partido
    else:
        df = pd.read_csv(os.path.join(carpeta, archivo), header=None)
        df.columns = columnas
        df["MATCH_ID"] = id_partido

    return df


# Directorios de las carpetas
carpetas = ["pbyp", "simple", "stats"]

# Inicializar DataFrames para cada carpeta
df_pbyp = pd.DataFrame()
df_simple = pd.DataFrame()
df_stat = pd.DataFrame()


# Nombres de columnas para cada carpeta
columnas_simple = [
    "TOURNEY_LEVEL",
    "TOURNEY_NAME",
    "COUNTRY",
    "SURFACE",
    "ROUND_MATCH",
    "DATE_MATCH",
    "W_PLAYER",
    "W_NAC",
    "W_SEED",
    "L_PLAYER",
    "L_NAC",
    "L_SEED",
    "TIMESTART",
    "SCORE",
    "MATCH_STATUS",
    "BEST",
    "TIME_TOTAL",
    "TIME_1S",
    "TIME_2S",
    "TIME_3S",
    "TIME_4S",
    "TIME_5S",
    "COMENTS",
    "WINNER",
]

columnas_pbyp = [
    "MATCH_SCORE",
    "GAME_SCORE",
    "RETURN_GAME",
    "SERVE_GAME",
    "BREAK_POINT",
    "MATCH_POINT",
]

columnas_stat = []


# Iterar sobre los archivos y cargar los datos en los DataFrames correspondientes
for carpeta in carpetas:
    archivos = [f for f in os.listdir(carpeta) if f != ".DS_Store"]
    for archivo in archivos:
        id_torneo, nombre_torneo, anio, ganador, perdedor, id_partido = archivo.split(
            "_"
        )
        id_partido = anio + "_" + id_torneo + "_" + id_partido[:-4]

        # Selección de las columnas según la carpeta
        if carpeta == "pbyp":
            columnas = columnas_pbyp
        elif carpeta == "simple":
            columnas = columnas_simple
        else:
            columnas = columnas_stat

        # Cargar el DataFrame
        df = cargar_csv_y_agregar_id(archivo, carpeta, id_partido, columnas)

        if carpeta == "pbyp":
            # Agregar la columna de numeración en pbyp
            df["POINT_NUMBER"] = range(1, len(df) + 1)
            # Concatenar el DataFrame en df_pbyp
            df_pbyp = pd.concat([df_pbyp, df], ignore_index=True)
        elif carpeta == "simple":
            df_simple = pd.concat([df_simple, df], ignore_index=True)
        elif carpeta == "stats":
            df_stat = pd.concat([df_stat, df], ignore_index=True, sort=False)
            df_stat = df_stat.reindex(columns=df_stat.columns.union(df_stat.columns))


df_pbyp["PK_COLUMN"] = (
    df_pbyp["MATCH_ID"].astype(str) + "_" + df_pbyp["POINT_NUMBER"].astype(str)
)

df_simple["W_SEED"] = df_simple["W_SEED"].astype(str)

# Reemplazar los valores con más de 3 caracteres por NaN
df_simple["W_SEED"] = df_simple["W_SEED"].apply(lambda x: np.nan if len(x) > 3 else x)


df_simple["L_SEED"] = df_simple["L_SEED"].astype(str)

# Reemplazar los valores con más de 3 caracteres por NaN
df_simple["L_SEED"] = df_simple["L_SEED"].apply(lambda x: np.nan if len(x) > 3 else x)

# Condiciones específicas para Australian Open
cond1 = (
    (df_simple["TOURNEY_LEVEL"].str.contains("Qualification"))
    & (df_simple["TOURNEY_NAME"] == "Australian Open")
    & (df_simple["ROUND_MATCH"] == "Final")
)
cond2 = (
    (df_simple["TOURNEY_LEVEL"].str.contains("Qualification"))
    & (df_simple["TOURNEY_NAME"] == "Australian Open")
    & (df_simple["ROUND_MATCH"] == "Semi-finals")
)
cond3 = (
    (df_simple["TOURNEY_LEVEL"].str.contains("Qualification"))
    & (df_simple["TOURNEY_NAME"] == "Australian Open")
    & (df_simple["ROUND_MATCH"] == "Quarter-finals")
)

# Condiciones generales para torneos que no son Australian Open
cond4 = (
    (df_simple["TOURNEY_LEVEL"].str.contains("Qualification"))
    & (df_simple["TOURNEY_NAME"] != "Australian Open")
    & (df_simple["ROUND_MATCH"] == "Semi-finals")
)
cond5 = (
    (df_simple["TOURNEY_LEVEL"].str.contains("Qualification"))
    & (df_simple["TOURNEY_NAME"] != "Australian Open")
    & (df_simple["ROUND_MATCH"] == "Final")
)

# Asignación basada en condiciones
df_simple["ROUND_MATCH"] = np.select(
    [cond1, cond2, cond3, cond4, cond5],
    ["Q3", "Q2", "Q1", "Q1", "Q2"],
    default=df_simple[
        "ROUND_MATCH"
    ],  # Mantén el valor actual si no se cumplen las condiciones
)

# Eliminar " - Qualification" de TOURNEY_LEVEL si está presente
df_simple["TOURNEY_LEVEL"] = df_simple["TOURNEY_LEVEL"].str.replace(
    r" - Qualification$", "", regex=True
)

df_simple.loc[
    df_simple["ROUND_MATCH"].str.contains("Qualification", na=False), "ROUND_MATCH"
] = ""

"""
# Paso 2: Filtrar filas donde ROUND_MATCH está vacío
df_aux = df_simple[df_simple["ROUND_MATCH"].astype(str) == ""].copy()

df_aux = df_aux.sort_values(by="MATCH_ID", ascending=True)

# Paso 3: Definir variables de cantidad de rondas
rondas_q1 = 24
rondas_q2 = 12
rondas_q3 = 0

# Paso 4: Asignar valores a ROUND_MATCH en función de las variables
total_filas = len(df_aux)
df_aux.loc[df_aux.index[:rondas_q3], "ROUND_MATCH"] = "Q3"
df_aux.loc[df_aux.index[rondas_q3:rondas_q3 + rondas_q2], "ROUND_MATCH"] = "Q2"
df_aux.loc[df_aux.index[rondas_q3 + rondas_q2:rondas_q3 + rondas_q2 + rondas_q1], "ROUND_MATCH"] = "Q1"

# Incorporar los cambios en df_simple utilizando MATCH_ID como clave primaria
df_simple.update(df_aux.set_index("MATCH_ID"))

"""
# Reemplazar los valores en la columna 'ROUND_MATCH' según las reglas especificadas
df_simple["ROUND_MATCH"] = df_simple["ROUND_MATCH"].replace(
    {
        "1/64-finals": "R128",
        "1/32-finals": "R64",
        "1/16-finals": "R32",
        "Semi-finals": "SF",
        "Final": "F",
        "1/8-finals": "R16",
        "Quarter-finals": "QF",
        "hard": "RR",  # Reemplazar 'hard' por null
    }
)

df_simple.loc[df_simple["TOURNEY_NAME"] == "Australian Open", "TOURNEY_LEVEL"] = "GS"
df_simple.loc[
    df_simple["TOURNEY_LEVEL"].str.contains("CHALLENGER", case=False, na=False),
    "TOURNEY_LEVEL",
] = "CH"


"""
def convert_to_iso(country_name):
    # Si el valor ya es un código ISO 3166-1 alfa-3 (3 letras en mayúscula), lo dejamos tal cual
    if isinstance(country_name, str) and len(country_name) == 3 and country_name.isupper():
        return country_name  # Ya es un código ISO válido
    
    try:
        # Si no es un código ISO, lo convertimos al formato alfa-3
        country = pycountry.countries.get(name=country_name.title())  # Normaliza el nombre a título
        if country:
            return country.alpha_3
        else:
            return None  # Si no se encuentra el país
    except KeyError:
        return None  # Si ocurre un error al intentar acceder al país

# Aplicar la función a la columna 'W_NAC'
df_simple['W_NAC'] = df_simple['W_NAC'].apply(lambda x: convert_to_iso(x) if isinstance(x, str) else x)

df_simple['L_NAC'] = df_simple['L_NAC'].apply(lambda x: convert_to_iso(x) if isinstance(x, str) else x)

df_simple['COUNTRY'] = df_simple['COUNTRY'].apply(lambda x: convert_to_iso(x) if isinstance(x, str) else x)
# Aplicar la transformación a la columna 'SURFACE'

"""
df_simple["SURFACE"] = df_simple["SURFACE"].apply(
    lambda x: x.capitalize() if isinstance(x, str) else x
)


# Guardar los DataFrames en archivos CSV si es necesario
# df_pbyp.to_csv('C:/Users/Paula/Documents/Projects/TennisData/FS_matches/CSV_unidos/pbyp.csv', index=False)
# df_simple.to_csv('C:/Users/Paula/Documents/Projects/TennisData/FS_matches/CSV_unidos/simple.csv', index=False)
# df_stat.to_csv('C:/Users/Paula/Documents/Projects/TennisData/FS_matches/CSV_unidos/stats.csv', index=False)


########## fracciono df_stats ###################
# df_stat = df_stat.where(pd.notnull(df_stat), None)

for column in df_stat.columns:
    if "Percentage" in column:
        df_stat[column] = df_stat[column].apply(
            lambda x: "NADA" if pd.isna(x) or x == 0 else x
        )


# Crear las 6 partes basadas en el prefijo de las columnas
df_part_w_t = df_stat[
    ["MATCH_ID"] + [col for col in df_stat.columns if col.startswith("w_t_")]
].copy()
df_part_w_t.rename(columns={"MATCH_ID": "w_t_MATCH_ID"}, inplace=True)

df_part_w_1 = df_stat[
    ["MATCH_ID"] + [col for col in df_stat.columns if col.startswith("w_1_")]
].copy()
df_part_w_1.rename(columns={"MATCH_ID": "w_1_MATCH_ID"}, inplace=True)

df_part_w_2 = df_stat[
    ["MATCH_ID"] + [col for col in df_stat.columns if col.startswith("w_2_")]
].copy()
df_part_w_2.rename(columns={"MATCH_ID": "w_2_MATCH_ID"}, inplace=True)

df_part_w_3 = df_stat[
    ["MATCH_ID"] + [col for col in df_stat.columns if col.startswith("w_3_")]
].copy()
df_part_w_3.rename(columns={"MATCH_ID": "w_3_MATCH_ID"}, inplace=True)

df_part_w_4 = df_stat[
    ["MATCH_ID"] + [col for col in df_stat.columns if col.startswith("w_4_")]
].copy()
df_part_w_4.rename(columns={"MATCH_ID": "w_4_MATCH_ID"}, inplace=True)

df_part_w_5 = df_stat[
    ["MATCH_ID"] + [col for col in df_stat.columns if col.startswith("w_5_")]
].copy()
df_part_w_5.rename(columns={"MATCH_ID": "w_5_MATCH_ID"}, inplace=True)


df_part_l_t = df_stat[
    ["MATCH_ID"] + [col for col in df_stat.columns if col.startswith("l_t_")]
].copy()
df_part_l_t.rename(columns={"MATCH_ID": "l_t_MATCH_ID"}, inplace=True)

df_part_l_1 = df_stat[
    ["MATCH_ID"] + [col for col in df_stat.columns if col.startswith("l_1_")]
].copy()
df_part_l_1.rename(columns={"MATCH_ID": "l_1_MATCH_ID"}, inplace=True)

df_part_l_2 = df_stat[
    ["MATCH_ID"] + [col for col in df_stat.columns if col.startswith("l_2_")]
].copy()
df_part_l_2.rename(columns={"MATCH_ID": "l_2_MATCH_ID"}, inplace=True)

df_part_l_3 = df_stat[
    ["MATCH_ID"] + [col for col in df_stat.columns if col.startswith("l_3_")]
].copy()
df_part_l_3.rename(columns={"MATCH_ID": "l_3_MATCH_ID"}, inplace=True)

df_part_l_4 = df_stat[
    ["MATCH_ID"] + [col for col in df_stat.columns if col.startswith("l_4_")]
].copy()
df_part_l_4.rename(columns={"MATCH_ID": "l_4_MATCH_ID"}, inplace=True)

df_part_l_5 = df_stat[
    ["MATCH_ID"] + [col for col in df_stat.columns if col.startswith("l_5_")]
].copy()
df_part_l_5.rename(columns={"MATCH_ID": "l_5_MATCH_ID"}, inplace=True)


###################### corregir columnas ############################


# %% Pasos lentos ----- cambiar
# Primer servicio
df_part_w_t["w_t_1st Serve Percentage"] = df_part_w_t[
    "w_t_1st Serve Percentage"
].str.replace("%", "")
df_part_w_t["w_t_1st Serve Percentage"] = pd.to_numeric(
    df_part_w_t["w_t_1st Serve Percentage"], errors="coerce"
).astype("Int64")

df_part_w_t[
    [
        "w_t_1st Serve Points Won Percentage",
        "w_t_1st Serve Points Won",
        "w_t_1st Serve Points Played",
    ]
] = (
    df_part_w_t["w_t_1st Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_t["w_t_1st Serve Points Won Percentage"] = pd.to_numeric(
    df_part_w_t["w_t_1st Serve Points Won Percentage"], errors="coerce"
)
df_part_w_t["w_t_1st Serve Points Won"] = pd.to_numeric(
    df_part_w_t["w_t_1st Serve Points Won"], errors="coerce"
)
df_part_w_t["w_t_1st Serve Points Played"] = pd.to_numeric(
    df_part_w_t["w_t_1st Serve Points Played"], errors="coerce"
)

# Segundo servicio
df_part_w_t[
    [
        "w_t_2nd Serve Points Won Percentage",
        "w_t_2nd Serve Points Won",
        "w_t_2nd Serve Points Played",
    ]
] = (
    df_part_w_t["w_t_2nd Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_t["w_t_2nd Serve Points Won Percentage"] = pd.to_numeric(
    df_part_w_t["w_t_2nd Serve Points Won Percentage"], errors="coerce"
)
df_part_w_t["w_t_2nd Serve Points Won"] = pd.to_numeric(
    df_part_w_t["w_t_2nd Serve Points Won"], errors="coerce"
)
df_part_w_t["w_t_2nd Serve Points Played"] = pd.to_numeric(
    df_part_w_t["w_t_2nd Serve Points Played"], errors="coerce"
)

# Break points saved
df_part_w_t[
    [
        "w_t_Break Points Saved Percentage",
        "w_t_Break Points Saved",
        "w_t_Break Points Faced",
    ]
] = (
    df_part_w_t["w_t_Break Points Saved"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_t["w_t_Break Points Saved Percentage"] = pd.to_numeric(
    df_part_w_t["w_t_Break Points Saved Percentage"], errors="coerce"
)
df_part_w_t["w_t_Break Points Saved"] = pd.to_numeric(
    df_part_w_t["w_t_Break Points Saved"], errors="coerce"
)
df_part_w_t["w_t_Break Points Faced"] = pd.to_numeric(
    df_part_w_t["w_t_Break Points Faced"], errors="coerce"
)

# First Return Points Won
df_part_w_t[
    [
        "w_t_1st Return Points Won Percentage",
        "w_t_1st Return Points Won",
        "w_t_1st Return Points Played",
    ]
] = (
    df_part_w_t["w_t_1st Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_t["w_t_1st Return Points Won Percentage"] = pd.to_numeric(
    df_part_w_t["w_t_1st Return Points Won Percentage"], errors="coerce"
)
df_part_w_t["w_t_1st Return Points Won"] = pd.to_numeric(
    df_part_w_t["w_t_1st Return Points Won"], errors="coerce"
)
df_part_w_t["w_t_1st Return Points Played"] = pd.to_numeric(
    df_part_w_t["w_t_1st Return Points Played"], errors="coerce"
)


# Second Return Points Won
df_part_w_t[
    [
        "w_t_2nd Return Points Won Percentage",
        "w_t_2nd Return Points Won",
        "w_t_2nd Return Points Played",
    ]
] = (
    df_part_w_t["w_t_2nd Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_t["w_t_2nd Return Points Won Percentage"] = pd.to_numeric(
    df_part_w_t["w_t_2nd Return Points Won Percentage"], errors="coerce"
)
df_part_w_t["w_t_2nd Return Points Won"] = pd.to_numeric(
    df_part_w_t["w_t_2nd Return Points Won"], errors="coerce"
)
df_part_w_t["w_t_2nd Return Points Played"] = pd.to_numeric(
    df_part_w_t["w_t_2nd Return Points Played"], errors="coerce"
)


# Break points COnverted
df_part_w_t[
    [
        "w_t_Break Points Converted Percentage",
        "w_t_Break Points Converted",
        "w_t_Break Points chances",
    ]
] = (
    df_part_w_t["w_t_Break Points Converted"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_t["w_t_Break Points Converted Percentage"] = pd.to_numeric(
    df_part_w_t["w_t_Break Points Converted Percentage"], errors="coerce"
)
df_part_w_t["w_t_Break Points Converted"] = pd.to_numeric(
    df_part_w_t["w_t_Break Points Converted"], errors="coerce"
)
df_part_w_t["w_t_Break Points chances"] = pd.to_numeric(
    df_part_w_t["w_t_Break Points chances"], errors="coerce"
)

# Service Points Won
df_part_w_t[
    [
        "w_t_Service Points Won Percentage",
        "w_t_Service Points Won",
        "w_t_Service Points Played",
    ]
] = (
    df_part_w_t["w_t_Service Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_t["w_t_Service Points Won Percentage"] = pd.to_numeric(
    df_part_w_t["w_t_Service Points Won Percentage"], errors="coerce"
)
df_part_w_t["w_t_Service Points Won"] = pd.to_numeric(
    df_part_w_t["w_t_Service Points Won"], errors="coerce"
)
df_part_w_t["w_t_Service Points Played"] = pd.to_numeric(
    df_part_w_t["w_t_Service Points Played"], errors="coerce"
)

# Return Points Won
df_part_w_t[
    [
        "w_t_Return Points Won Percentage",
        "w_t_Return Points Won",
        "w_t_Return Points Played",
    ]
] = (
    df_part_w_t["w_t_Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_t["w_t_Return Points Won Percentage"] = pd.to_numeric(
    df_part_w_t["w_t_Return Points Won Percentage"], errors="coerce"
)
df_part_w_t["w_t_Return Points Won"] = pd.to_numeric(
    df_part_w_t["w_t_Return Points Won"], errors="coerce"
)
df_part_w_t["w_t_Return Points Played"] = pd.to_numeric(
    df_part_w_t["w_t_Return Points Played"], errors="coerce"
)

# Total Points Won
df_part_w_t[
    [
        "w_t_Total Points Won Percentage",
        "w_t_Total Points Won",
        "w_t_Total Points Played",
    ]
] = (
    df_part_w_t["w_t_Total Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_t["w_t_Total Points Won Percentage"] = pd.to_numeric(
    df_part_w_t["w_t_Total Points Won Percentage"], errors="coerce"
)
df_part_w_t["w_t_Total Points Won"] = pd.to_numeric(
    df_part_w_t["w_t_Total Points Won"], errors="coerce"
)
df_part_w_t["w_t_Total Points Played"] = pd.to_numeric(
    df_part_w_t["w_t_Total Points Played"], errors="coerce"
)

# Service games Won
df_part_w_t[
    [
        "w_t_Service Games Won Percentage",
        "w_t_Service Games Won",
        "w_t_Service Games Played",
    ]
] = (
    df_part_w_t["w_t_Service Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_t["w_t_Service Games Won Percentage"] = pd.to_numeric(
    df_part_w_t["w_t_Service Games Won Percentage"], errors="coerce"
)
df_part_w_t["w_t_Service Games Won"] = pd.to_numeric(
    df_part_w_t["w_t_Service Games Won"], errors="coerce"
)
df_part_w_t["w_t_Service Games Played"] = pd.to_numeric(
    df_part_w_t["w_t_Service Games Played"], errors="coerce"
)

# Return games Won
df_part_w_t[
    [
        "w_t_Return Games Won Percentage",
        "w_t_Return Games Won",
        "w_t_Return Games Played",
    ]
] = (
    df_part_w_t["w_t_Return Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_t["w_t_Return Games Won Percentage"] = pd.to_numeric(
    df_part_w_t["w_t_Return Games Won Percentage"], errors="coerce"
)
df_part_w_t["w_t_Return Games Won"] = pd.to_numeric(
    df_part_w_t["w_t_Return Games Won"], errors="coerce"
)
df_part_w_t["w_t_Return Games Played"] = pd.to_numeric(
    df_part_w_t["w_t_Return Games Played"], errors="coerce"
)

# Total games Won
df_part_w_t[
    ["w_t_Total Games Won Percentage", "w_t_Total Games Won", "w_t_Total Games Played"]
] = (
    df_part_w_t["w_t_Total Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_t["w_t_Total Games Won Percentage"] = pd.to_numeric(
    df_part_w_t["w_t_Total Games Won Percentage"], errors="coerce"
)
df_part_w_t["w_t_Total Games Won"] = pd.to_numeric(
    df_part_w_t["w_t_Total Games Won"], errors="coerce"
)
df_part_w_t["w_t_Total Games Played"] = pd.to_numeric(
    df_part_w_t["w_t_Total Games Played"], errors="coerce"
)

# Verifica si la columna 'w_t_Net Points Won' existe
if "w_t_Net Points Won" in df_part_w_t.columns:
    df_part_w_t["w_t_Net Points Won"] = df_part_w_t["w_t_Net Points Won"].astype(str)
    df_part_w_t[
        ["w_t_Net Points Won Percentage", "w_t_Net Points Won", "w_t_Net Points Played"]
    ] = df_part_w_t["w_t_Net Points Won"].str.extract(r"(\d+)% \((\d+)/(\d+)\)")

    df_part_w_t["w_t_Net Points Won Percentage"] = pd.to_numeric(
        df_part_w_t["w_t_Net Points Won Percentage"], errors="coerce"
    )
    df_part_w_t["w_t_Net Points Won"] = pd.to_numeric(
        df_part_w_t["w_t_Net Points Won"], errors="coerce"
    )
    df_part_w_t["w_t_Net Points Played"] = pd.to_numeric(
        df_part_w_t["w_t_Net Points Played"], errors="coerce"
    )
else:
    # Si no existe la columna, la agregamos con valores NaN
    df_part_w_t[
        ["w_t_Net Points Won Percentage", "w_t_Net Points Won", "w_t_Net Points Played"]
    ] = np.nan

if "w_t_Winners" not in df_part_w_t.columns:
    df_part_w_t["w_t_Winners"] = None

if "w_t_Unforced Errors" not in df_part_w_t.columns:
    df_part_w_t["w_t_Unforced Errors"] = None

if "w_t_Average 1st Serve Speed" not in df_part_w_t.columns:
    df_part_w_t["w_t_Average 1st Serve Speed"] = None
else:
    df_part_w_t["w_t_Average 1st Serve Speed"] = df_part_w_t[
        "w_t_Average 1st Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)

if "w_t_Average 2nd Serve Speed" not in df_part_w_t.columns:
    df_part_w_t["w_t_Average 2nd Serve Speed"] = None
else:
    df_part_w_t["w_t_Average 2nd Serve Speed"] = df_part_w_t[
        "w_t_Average 2nd Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)


# Primer servicio
df_part_w_1["w_1_1st Serve Percentage"] = df_part_w_1[
    "w_1_1st Serve Percentage"
].str.replace("%", "")
df_part_w_1["w_1_1st Serve Percentage"] = pd.to_numeric(
    df_part_w_1["w_1_1st Serve Percentage"], errors="coerce"
).astype("Int64")

df_part_w_1[
    [
        "w_1_1st Serve Points Won Percentage",
        "w_1_1st Serve Points Won",
        "w_1_1st Serve Points Played",
    ]
] = (
    df_part_w_1["w_1_1st Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_1["w_1_1st Serve Points Won Percentage"] = pd.to_numeric(
    df_part_w_1["w_1_1st Serve Points Won Percentage"], errors="coerce"
)
df_part_w_1["w_1_1st Serve Points Won"] = pd.to_numeric(
    df_part_w_1["w_1_1st Serve Points Won"], errors="coerce"
)
df_part_w_1["w_1_1st Serve Points Played"] = pd.to_numeric(
    df_part_w_1["w_1_1st Serve Points Played"], errors="coerce"
)

# Segundo servicio
df_part_w_1[
    [
        "w_1_2nd Serve Points Won Percentage",
        "w_1_2nd Serve Points Won",
        "w_1_2nd Serve Points Played",
    ]
] = (
    df_part_w_1["w_1_2nd Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_1["w_1_2nd Serve Points Won Percentage"] = pd.to_numeric(
    df_part_w_1["w_1_2nd Serve Points Won Percentage"], errors="coerce"
)
df_part_w_1["w_1_2nd Serve Points Won"] = pd.to_numeric(
    df_part_w_1["w_1_2nd Serve Points Won"], errors="coerce"
)
df_part_w_1["w_1_2nd Serve Points Played"] = pd.to_numeric(
    df_part_w_1["w_1_2nd Serve Points Played"], errors="coerce"
)

# Break points saved
df_part_w_1[
    [
        "w_1_Break Points Saved Percentage",
        "w_1_Break Points Saved",
        "w_1_Break Points Faced",
    ]
] = (
    df_part_w_1["w_1_Break Points Saved"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_1["w_1_Break Points Saved Percentage"] = pd.to_numeric(
    df_part_w_1["w_1_Break Points Saved Percentage"], errors="coerce"
)
df_part_w_1["w_1_Break Points Saved"] = pd.to_numeric(
    df_part_w_1["w_1_Break Points Saved"], errors="coerce"
)
df_part_w_1["w_1_Break Points Faced"] = pd.to_numeric(
    df_part_w_1["w_1_Break Points Faced"], errors="coerce"
)

# First Return Points Won
df_part_w_1[
    [
        "w_1_1st Return Points Won Percentage",
        "w_1_1st Return Points Won",
        "w_1_1st Return Points Played",
    ]
] = (
    df_part_w_1["w_1_1st Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_1["w_1_1st Return Points Won Percentage"] = pd.to_numeric(
    df_part_w_1["w_1_1st Return Points Won Percentage"], errors="coerce"
)
df_part_w_1["w_1_1st Return Points Won"] = pd.to_numeric(
    df_part_w_1["w_1_1st Return Points Won"], errors="coerce"
)
df_part_w_1["w_1_1st Return Points Played"] = pd.to_numeric(
    df_part_w_1["w_1_1st Return Points Played"], errors="coerce"
)


# Second Return Points Won
df_part_w_1[
    [
        "w_1_2nd Return Points Won Percentage",
        "w_1_2nd Return Points Won",
        "w_1_2nd Return Points Played",
    ]
] = (
    df_part_w_1["w_1_2nd Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_1["w_1_2nd Return Points Won Percentage"] = pd.to_numeric(
    df_part_w_1["w_1_2nd Return Points Won Percentage"], errors="coerce"
)
df_part_w_1["w_1_2nd Return Points Won"] = pd.to_numeric(
    df_part_w_1["w_1_2nd Return Points Won"], errors="coerce"
)
df_part_w_1["w_1_2nd Return Points Played"] = pd.to_numeric(
    df_part_w_1["w_1_2nd Return Points Played"], errors="coerce"
)


# Break points COnverted
df_part_w_1[
    [
        "w_1_Break Points Converted Percentage",
        "w_1_Break Points Converted",
        "w_1_Break Points chances",
    ]
] = (
    df_part_w_1["w_1_Break Points Converted"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_1["w_1_Break Points Converted Percentage"] = pd.to_numeric(
    df_part_w_1["w_1_Break Points Converted Percentage"], errors="coerce"
)
df_part_w_1["w_1_Break Points Converted"] = pd.to_numeric(
    df_part_w_1["w_1_Break Points Converted"], errors="coerce"
)
df_part_w_1["w_1_Break Points chances"] = pd.to_numeric(
    df_part_w_1["w_1_Break Points chances"], errors="coerce"
)

# Service Points Won
df_part_w_1[
    [
        "w_1_Service Points Won Percentage",
        "w_1_Service Points Won",
        "w_1_Service Points Played",
    ]
] = (
    df_part_w_1["w_1_Service Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_1["w_1_Service Points Won Percentage"] = pd.to_numeric(
    df_part_w_1["w_1_Service Points Won Percentage"], errors="coerce"
)
df_part_w_1["w_1_Service Points Won"] = pd.to_numeric(
    df_part_w_1["w_1_Service Points Won"], errors="coerce"
)
df_part_w_1["w_1_Service Points Played"] = pd.to_numeric(
    df_part_w_1["w_1_Service Points Played"], errors="coerce"
)

# Return Points Won
df_part_w_1[
    [
        "w_1_Return Points Won Percentage",
        "w_1_Return Points Won",
        "w_1_Return Points Played",
    ]
] = (
    df_part_w_1["w_1_Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_1["w_1_Return Points Won Percentage"] = pd.to_numeric(
    df_part_w_1["w_1_Return Points Won Percentage"], errors="coerce"
)
df_part_w_1["w_1_Return Points Won"] = pd.to_numeric(
    df_part_w_1["w_1_Return Points Won"], errors="coerce"
)
df_part_w_1["w_1_Return Points Played"] = pd.to_numeric(
    df_part_w_1["w_1_Return Points Played"], errors="coerce"
)

# Total Points Won
df_part_w_1[
    [
        "w_1_Total Points Won Percentage",
        "w_1_Total Points Won",
        "w_1_Total Points Played",
    ]
] = (
    df_part_w_1["w_1_Total Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_1["w_1_Total Points Won Percentage"] = pd.to_numeric(
    df_part_w_1["w_1_Total Points Won Percentage"], errors="coerce"
)
df_part_w_1["w_1_Total Points Won"] = pd.to_numeric(
    df_part_w_1["w_1_Total Points Won"], errors="coerce"
)
df_part_w_1["w_1_Total Points Played"] = pd.to_numeric(
    df_part_w_1["w_1_Total Points Played"], errors="coerce"
)

# Service games Won
df_part_w_1[
    [
        "w_1_Service Games Won Percentage",
        "w_1_Service Games Won",
        "w_1_Service Games Played",
    ]
] = (
    df_part_w_1["w_1_Service Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_1["w_1_Service Games Won Percentage"] = pd.to_numeric(
    df_part_w_1["w_1_Service Games Won Percentage"], errors="coerce"
)
df_part_w_1["w_1_Service Games Won"] = pd.to_numeric(
    df_part_w_1["w_1_Service Games Won"], errors="coerce"
)
df_part_w_1["w_1_Service Games Played"] = pd.to_numeric(
    df_part_w_1["w_1_Service Games Played"], errors="coerce"
)

# Return games Won
df_part_w_1[
    [
        "w_1_Return Games Won Percentage",
        "w_1_Return Games Won",
        "w_1_Return Games Played",
    ]
] = (
    df_part_w_1["w_1_Return Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_1["w_1_Return Games Won Percentage"] = pd.to_numeric(
    df_part_w_1["w_1_Return Games Won Percentage"], errors="coerce"
)
df_part_w_1["w_1_Return Games Won"] = pd.to_numeric(
    df_part_w_1["w_1_Return Games Won"], errors="coerce"
)
df_part_w_1["w_1_Return Games Played"] = pd.to_numeric(
    df_part_w_1["w_1_Return Games Played"], errors="coerce"
)

# Total games Won
df_part_w_1[
    ["w_1_Total Games Won Percentage", "w_1_Total Games Won", "w_1_Total Games Played"]
] = (
    df_part_w_1["w_1_Total Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_1["w_1_Total Games Won Percentage"] = pd.to_numeric(
    df_part_w_1["w_1_Total Games Won Percentage"], errors="coerce"
)
df_part_w_1["w_1_Total Games Won"] = pd.to_numeric(
    df_part_w_1["w_1_Total Games Won"], errors="coerce"
)
df_part_w_1["w_1_Total Games Played"] = pd.to_numeric(
    df_part_w_1["w_1_Total Games Played"], errors="coerce"
)

# Verifica si la columna 'w_1_Net Points Won' existe
if "w_1_Net Points Won" in df_part_w_1.columns:
    df_part_w_1["w_1_Net Points Won"] = df_part_w_1["w_1_Net Points Won"].astype(str)
    df_part_w_1[
        ["w_1_Net Points Won Percentage", "w_1_Net Points Won", "w_1_Net Points Played"]
    ] = df_part_w_1["w_1_Net Points Won"].str.extract(r"(\d+)% \((\d+)/(\d+)\)")

    df_part_w_1["w_1_Net Points Won Percentage"] = pd.to_numeric(
        df_part_w_1["w_1_Net Points Won Percentage"], errors="coerce"
    )
    df_part_w_1["w_1_Net Points Won"] = pd.to_numeric(
        df_part_w_1["w_1_Net Points Won"], errors="coerce"
    )
    df_part_w_1["w_1_Net Points Played"] = pd.to_numeric(
        df_part_w_1["w_1_Net Points Played"], errors="coerce"
    )
else:
    # Si no existe la columna, la agregamos con valores NaN
    df_part_w_1[
        ["w_1_Net Points Won Percentage", "w_1_Net Points Won", "w_1_Net Points Played"]
    ] = np.nan

if "w_1_Winners" not in df_part_w_1.columns:
    df_part_w_1["w_1_Winners"] = None

if "w_1_Unforced Errors" not in df_part_w_1.columns:
    df_part_w_1["w_1_Unforced Errors"] = None

if "w_1_Average 1st Serve Speed" not in df_part_w_1.columns:
    df_part_w_1["w_1_Average 1st Serve Speed"] = None
else:
    df_part_w_1["w_1_Average 1st Serve Speed"] = df_part_w_1[
        "w_1_Average 1st Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)

if "w_1_Average 2nd Serve Speed" not in df_part_w_1.columns:
    df_part_w_1["w_1_Average 2nd Serve Speed"] = None
else:
    df_part_w_1["w_1_Average 2nd Serve Speed"] = df_part_w_1[
        "w_1_Average 2nd Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)


# Primer servicio
df_part_w_2["w_2_1st Serve Percentage"] = df_part_w_2[
    "w_2_1st Serve Percentage"
].str.replace("%", "")
df_part_w_2["w_2_1st Serve Percentage"] = pd.to_numeric(
    df_part_w_2["w_2_1st Serve Percentage"], errors="coerce"
).astype("Int64")

df_part_w_2[
    [
        "w_2_1st Serve Points Won Percentage",
        "w_2_1st Serve Points Won",
        "w_2_1st Serve Points Played",
    ]
] = (
    df_part_w_2["w_2_1st Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_2["w_2_1st Serve Points Won Percentage"] = pd.to_numeric(
    df_part_w_2["w_2_1st Serve Points Won Percentage"], errors="coerce"
)
df_part_w_2["w_2_1st Serve Points Won"] = pd.to_numeric(
    df_part_w_2["w_2_1st Serve Points Won"], errors="coerce"
)
df_part_w_2["w_2_1st Serve Points Played"] = pd.to_numeric(
    df_part_w_2["w_2_1st Serve Points Played"], errors="coerce"
)

# Segundo servicio
df_part_w_2[
    [
        "w_2_2nd Serve Points Won Percentage",
        "w_2_2nd Serve Points Won",
        "w_2_2nd Serve Points Played",
    ]
] = (
    df_part_w_2["w_2_2nd Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_2["w_2_2nd Serve Points Won Percentage"] = pd.to_numeric(
    df_part_w_2["w_2_2nd Serve Points Won Percentage"], errors="coerce"
)
df_part_w_2["w_2_2nd Serve Points Won"] = pd.to_numeric(
    df_part_w_2["w_2_2nd Serve Points Won"], errors="coerce"
)
df_part_w_2["w_2_2nd Serve Points Played"] = pd.to_numeric(
    df_part_w_2["w_2_2nd Serve Points Played"], errors="coerce"
)

# Break points saved
df_part_w_2[
    [
        "w_2_Break Points Saved Percentage",
        "w_2_Break Points Saved",
        "w_2_Break Points Faced",
    ]
] = (
    df_part_w_2["w_2_Break Points Saved"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_2["w_2_Break Points Saved Percentage"] = pd.to_numeric(
    df_part_w_2["w_2_Break Points Saved Percentage"], errors="coerce"
)
df_part_w_2["w_2_Break Points Saved"] = pd.to_numeric(
    df_part_w_2["w_2_Break Points Saved"], errors="coerce"
)
df_part_w_2["w_2_Break Points Faced"] = pd.to_numeric(
    df_part_w_2["w_2_Break Points Faced"], errors="coerce"
)

# First Return Points Won
df_part_w_2[
    [
        "w_2_1st Return Points Won Percentage",
        "w_2_1st Return Points Won",
        "w_2_1st Return Points Played",
    ]
] = (
    df_part_w_2["w_2_1st Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_2["w_2_1st Return Points Won Percentage"] = pd.to_numeric(
    df_part_w_2["w_2_1st Return Points Won Percentage"], errors="coerce"
)
df_part_w_2["w_2_1st Return Points Won"] = pd.to_numeric(
    df_part_w_2["w_2_1st Return Points Won"], errors="coerce"
)
df_part_w_2["w_2_1st Return Points Played"] = pd.to_numeric(
    df_part_w_2["w_2_1st Return Points Played"], errors="coerce"
)


# Second Return Points Won
df_part_w_2[
    [
        "w_2_2nd Return Points Won Percentage",
        "w_2_2nd Return Points Won",
        "w_2_2nd Return Points Played",
    ]
] = (
    df_part_w_2["w_2_2nd Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_2["w_2_2nd Return Points Won Percentage"] = pd.to_numeric(
    df_part_w_2["w_2_2nd Return Points Won Percentage"], errors="coerce"
)
df_part_w_2["w_2_2nd Return Points Won"] = pd.to_numeric(
    df_part_w_2["w_2_2nd Return Points Won"], errors="coerce"
)
df_part_w_2["w_2_2nd Return Points Played"] = pd.to_numeric(
    df_part_w_2["w_2_2nd Return Points Played"], errors="coerce"
)


# Break points COnverted
df_part_w_2[
    [
        "w_2_Break Points Converted Percentage",
        "w_2_Break Points Converted",
        "w_2_Break Points chances",
    ]
] = (
    df_part_w_2["w_2_Break Points Converted"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_2["w_2_Break Points Converted Percentage"] = pd.to_numeric(
    df_part_w_2["w_2_Break Points Converted Percentage"], errors="coerce"
)
df_part_w_2["w_2_Break Points Converted"] = pd.to_numeric(
    df_part_w_2["w_2_Break Points Converted"], errors="coerce"
)
df_part_w_2["w_2_Break Points chances"] = pd.to_numeric(
    df_part_w_2["w_2_Break Points chances"], errors="coerce"
)

# Service Points Won
df_part_w_2[
    [
        "w_2_Service Points Won Percentage",
        "w_2_Service Points Won",
        "w_2_Service Points Played",
    ]
] = (
    df_part_w_2["w_2_Service Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_2["w_2_Service Points Won Percentage"] = pd.to_numeric(
    df_part_w_2["w_2_Service Points Won Percentage"], errors="coerce"
)
df_part_w_2["w_2_Service Points Won"] = pd.to_numeric(
    df_part_w_2["w_2_Service Points Won"], errors="coerce"
)
df_part_w_2["w_2_Service Points Played"] = pd.to_numeric(
    df_part_w_2["w_2_Service Points Played"], errors="coerce"
)

# Return Points Won
df_part_w_2[
    [
        "w_2_Return Points Won Percentage",
        "w_2_Return Points Won",
        "w_2_Return Points Played",
    ]
] = (
    df_part_w_2["w_2_Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_2["w_2_Return Points Won Percentage"] = pd.to_numeric(
    df_part_w_2["w_2_Return Points Won Percentage"], errors="coerce"
)
df_part_w_2["w_2_Return Points Won"] = pd.to_numeric(
    df_part_w_2["w_2_Return Points Won"], errors="coerce"
)
df_part_w_2["w_2_Return Points Played"] = pd.to_numeric(
    df_part_w_2["w_2_Return Points Played"], errors="coerce"
)

# Total Points Won
df_part_w_2[
    [
        "w_2_Total Points Won Percentage",
        "w_2_Total Points Won",
        "w_2_Total Points Played",
    ]
] = (
    df_part_w_2["w_2_Total Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_2["w_2_Total Points Won Percentage"] = pd.to_numeric(
    df_part_w_2["w_2_Total Points Won Percentage"], errors="coerce"
)
df_part_w_2["w_2_Total Points Won"] = pd.to_numeric(
    df_part_w_2["w_2_Total Points Won"], errors="coerce"
)
df_part_w_2["w_2_Total Points Played"] = pd.to_numeric(
    df_part_w_2["w_2_Total Points Played"], errors="coerce"
)

# Service games Won
df_part_w_2[
    [
        "w_2_Service Games Won Percentage",
        "w_2_Service Games Won",
        "w_2_Service Games Played",
    ]
] = (
    df_part_w_2["w_2_Service Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_2["w_2_Service Games Won Percentage"] = pd.to_numeric(
    df_part_w_2["w_2_Service Games Won Percentage"], errors="coerce"
)
df_part_w_2["w_2_Service Games Won"] = pd.to_numeric(
    df_part_w_2["w_2_Service Games Won"], errors="coerce"
)
df_part_w_2["w_2_Service Games Played"] = pd.to_numeric(
    df_part_w_2["w_2_Service Games Played"], errors="coerce"
)

# Return games Won
df_part_w_2[
    [
        "w_2_Return Games Won Percentage",
        "w_2_Return Games Won",
        "w_2_Return Games Played",
    ]
] = (
    df_part_w_2["w_2_Return Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_2["w_2_Return Games Won Percentage"] = pd.to_numeric(
    df_part_w_2["w_2_Return Games Won Percentage"], errors="coerce"
)
df_part_w_2["w_2_Return Games Won"] = pd.to_numeric(
    df_part_w_2["w_2_Return Games Won"], errors="coerce"
)
df_part_w_2["w_2_Return Games Played"] = pd.to_numeric(
    df_part_w_2["w_2_Return Games Played"], errors="coerce"
)

# Total games Won
df_part_w_2[
    ["w_2_Total Games Won Percentage", "w_2_Total Games Won", "w_2_Total Games Played"]
] = (
    df_part_w_2["w_2_Total Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_2["w_2_Total Games Won Percentage"] = pd.to_numeric(
    df_part_w_2["w_2_Total Games Won Percentage"], errors="coerce"
)
df_part_w_2["w_2_Total Games Won"] = pd.to_numeric(
    df_part_w_2["w_2_Total Games Won"], errors="coerce"
)
df_part_w_2["w_2_Total Games Played"] = pd.to_numeric(
    df_part_w_2["w_2_Total Games Played"], errors="coerce"
)

# Verifica si la columna 'w_2_Net Points Won' existe
if "w_2_Net Points Won" in df_part_w_2.columns:
    df_part_w_2["w_2_Net Points Won"] = df_part_w_2["w_2_Net Points Won"].astype(str)
    df_part_w_2[
        ["w_2_Net Points Won Percentage", "w_2_Net Points Won", "w_2_Net Points Played"]
    ] = df_part_w_2["w_2_Net Points Won"].str.extract(r"(\d+)% \((\d+)/(\d+)\)")

    df_part_w_2["w_2_Net Points Won Percentage"] = pd.to_numeric(
        df_part_w_2["w_2_Net Points Won Percentage"], errors="coerce"
    )
    df_part_w_2["w_2_Net Points Won"] = pd.to_numeric(
        df_part_w_2["w_2_Net Points Won"], errors="coerce"
    )
    df_part_w_2["w_2_Net Points Played"] = pd.to_numeric(
        df_part_w_2["w_2_Net Points Played"], errors="coerce"
    )
else:
    # Si no existe la columna, la agregamos con valores NaN
    df_part_w_2[
        ["w_2_Net Points Won Percentage", "w_2_Net Points Won", "w_2_Net Points Played"]
    ] = np.nan

if "w_2_Winners" not in df_part_w_2.columns:
    df_part_w_2["w_2_Winners"] = None

if "w_2_Unforced Errors" not in df_part_w_2.columns:
    df_part_w_2["w_2_Unforced Errors"] = None

if "w_2_Average 1st Serve Speed" not in df_part_w_2.columns:
    df_part_w_2["w_2_Average 1st Serve Speed"] = None
else:
    df_part_w_2["w_2_Average 1st Serve Speed"] = df_part_w_2[
        "w_2_Average 1st Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)

if "w_2_Average 2nd Serve Speed" not in df_part_w_2.columns:
    df_part_w_2["w_2_Average 2nd Serve Speed"] = None
else:
    df_part_w_2["w_2_Average 2nd Serve Speed"] = df_part_w_2[
        "w_2_Average 2nd Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)


# Primer servicio
df_part_w_3["w_3_1st Serve Percentage"] = df_part_w_3[
    "w_3_1st Serve Percentage"
].str.replace("%", "")
df_part_w_3["w_3_1st Serve Percentage"] = pd.to_numeric(
    df_part_w_3["w_3_1st Serve Percentage"], errors="coerce"
).astype("Int64")

df_part_w_3[
    [
        "w_3_1st Serve Points Won Percentage",
        "w_3_1st Serve Points Won",
        "w_3_1st Serve Points Played",
    ]
] = (
    df_part_w_3["w_3_1st Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_3["w_3_1st Serve Points Won Percentage"] = pd.to_numeric(
    df_part_w_3["w_3_1st Serve Points Won Percentage"], errors="coerce"
)
df_part_w_3["w_3_1st Serve Points Won"] = pd.to_numeric(
    df_part_w_3["w_3_1st Serve Points Won"], errors="coerce"
)
df_part_w_3["w_3_1st Serve Points Played"] = pd.to_numeric(
    df_part_w_3["w_3_1st Serve Points Played"], errors="coerce"
)

# Segundo servicio
df_part_w_3[
    [
        "w_3_2nd Serve Points Won Percentage",
        "w_3_2nd Serve Points Won",
        "w_3_2nd Serve Points Played",
    ]
] = (
    df_part_w_3["w_3_2nd Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_3["w_3_2nd Serve Points Won Percentage"] = pd.to_numeric(
    df_part_w_3["w_3_2nd Serve Points Won Percentage"], errors="coerce"
)
df_part_w_3["w_3_2nd Serve Points Won"] = pd.to_numeric(
    df_part_w_3["w_3_2nd Serve Points Won"], errors="coerce"
)
df_part_w_3["w_3_2nd Serve Points Played"] = pd.to_numeric(
    df_part_w_3["w_3_2nd Serve Points Played"], errors="coerce"
)

# Break points saved
df_part_w_3[
    [
        "w_3_Break Points Saved Percentage",
        "w_3_Break Points Saved",
        "w_3_Break Points Faced",
    ]
] = (
    df_part_w_3["w_3_Break Points Saved"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_3["w_3_Break Points Saved Percentage"] = pd.to_numeric(
    df_part_w_3["w_3_Break Points Saved Percentage"], errors="coerce"
)
df_part_w_3["w_3_Break Points Saved"] = pd.to_numeric(
    df_part_w_3["w_3_Break Points Saved"], errors="coerce"
)
df_part_w_3["w_3_Break Points Faced"] = pd.to_numeric(
    df_part_w_3["w_3_Break Points Faced"], errors="coerce"
)

# First Return Points Won
df_part_w_3[
    [
        "w_3_1st Return Points Won Percentage",
        "w_3_1st Return Points Won",
        "w_3_1st Return Points Played",
    ]
] = (
    df_part_w_3["w_3_1st Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_3["w_3_1st Return Points Won Percentage"] = pd.to_numeric(
    df_part_w_3["w_3_1st Return Points Won Percentage"], errors="coerce"
)
df_part_w_3["w_3_1st Return Points Won"] = pd.to_numeric(
    df_part_w_3["w_3_1st Return Points Won"], errors="coerce"
)
df_part_w_3["w_3_1st Return Points Played"] = pd.to_numeric(
    df_part_w_3["w_3_1st Return Points Played"], errors="coerce"
)


# Second Return Points Won
df_part_w_3[
    [
        "w_3_2nd Return Points Won Percentage",
        "w_3_2nd Return Points Won",
        "w_3_2nd Return Points Played",
    ]
] = (
    df_part_w_3["w_3_2nd Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_3["w_3_2nd Return Points Won Percentage"] = pd.to_numeric(
    df_part_w_3["w_3_2nd Return Points Won Percentage"], errors="coerce"
)
df_part_w_3["w_3_2nd Return Points Won"] = pd.to_numeric(
    df_part_w_3["w_3_2nd Return Points Won"], errors="coerce"
)
df_part_w_3["w_3_2nd Return Points Played"] = pd.to_numeric(
    df_part_w_3["w_3_2nd Return Points Played"], errors="coerce"
)


# Break points COnverted
df_part_w_3[
    [
        "w_3_Break Points Converted Percentage",
        "w_3_Break Points Converted",
        "w_3_Break Points chances",
    ]
] = (
    df_part_w_3["w_3_Break Points Converted"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_3["w_3_Break Points Converted Percentage"] = pd.to_numeric(
    df_part_w_3["w_3_Break Points Converted Percentage"], errors="coerce"
)
df_part_w_3["w_3_Break Points Converted"] = pd.to_numeric(
    df_part_w_3["w_3_Break Points Converted"], errors="coerce"
)
df_part_w_3["w_3_Break Points chances"] = pd.to_numeric(
    df_part_w_3["w_3_Break Points chances"], errors="coerce"
)

# Service Points Won
df_part_w_3[
    [
        "w_3_Service Points Won Percentage",
        "w_3_Service Points Won",
        "w_3_Service Points Played",
    ]
] = (
    df_part_w_3["w_3_Service Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_3["w_3_Service Points Won Percentage"] = pd.to_numeric(
    df_part_w_3["w_3_Service Points Won Percentage"], errors="coerce"
)
df_part_w_3["w_3_Service Points Won"] = pd.to_numeric(
    df_part_w_3["w_3_Service Points Won"], errors="coerce"
)
df_part_w_3["w_3_Service Points Played"] = pd.to_numeric(
    df_part_w_3["w_3_Service Points Played"], errors="coerce"
)

# Return Points Won
df_part_w_3[
    [
        "w_3_Return Points Won Percentage",
        "w_3_Return Points Won",
        "w_3_Return Points Played",
    ]
] = (
    df_part_w_3["w_3_Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_3["w_3_Return Points Won Percentage"] = pd.to_numeric(
    df_part_w_3["w_3_Return Points Won Percentage"], errors="coerce"
)
df_part_w_3["w_3_Return Points Won"] = pd.to_numeric(
    df_part_w_3["w_3_Return Points Won"], errors="coerce"
)
df_part_w_3["w_3_Return Points Played"] = pd.to_numeric(
    df_part_w_3["w_3_Return Points Played"], errors="coerce"
)

# Total Points Won
df_part_w_3[
    [
        "w_3_Total Points Won Percentage",
        "w_3_Total Points Won",
        "w_3_Total Points Played",
    ]
] = (
    df_part_w_3["w_3_Total Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_3["w_3_Total Points Won Percentage"] = pd.to_numeric(
    df_part_w_3["w_3_Total Points Won Percentage"], errors="coerce"
)
df_part_w_3["w_3_Total Points Won"] = pd.to_numeric(
    df_part_w_3["w_3_Total Points Won"], errors="coerce"
)
df_part_w_3["w_3_Total Points Played"] = pd.to_numeric(
    df_part_w_3["w_3_Total Points Played"], errors="coerce"
)

# Service games Won
df_part_w_3[
    [
        "w_3_Service Games Won Percentage",
        "w_3_Service Games Won",
        "w_3_Service Games Played",
    ]
] = (
    df_part_w_3["w_3_Service Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_3["w_3_Service Games Won Percentage"] = pd.to_numeric(
    df_part_w_3["w_3_Service Games Won Percentage"], errors="coerce"
)
df_part_w_3["w_3_Service Games Won"] = pd.to_numeric(
    df_part_w_3["w_3_Service Games Won"], errors="coerce"
)
df_part_w_3["w_3_Service Games Played"] = pd.to_numeric(
    df_part_w_3["w_3_Service Games Played"], errors="coerce"
)

# Return games Won
df_part_w_3[
    [
        "w_3_Return Games Won Percentage",
        "w_3_Return Games Won",
        "w_3_Return Games Played",
    ]
] = (
    df_part_w_3["w_3_Return Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_3["w_3_Return Games Won Percentage"] = pd.to_numeric(
    df_part_w_3["w_3_Return Games Won Percentage"], errors="coerce"
)
df_part_w_3["w_3_Return Games Won"] = pd.to_numeric(
    df_part_w_3["w_3_Return Games Won"], errors="coerce"
)
df_part_w_3["w_3_Return Games Played"] = pd.to_numeric(
    df_part_w_3["w_3_Return Games Played"], errors="coerce"
)

# Total games Won
df_part_w_3[
    ["w_3_Total Games Won Percentage", "w_3_Total Games Won", "w_3_Total Games Played"]
] = (
    df_part_w_3["w_3_Total Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_3["w_3_Total Games Won Percentage"] = pd.to_numeric(
    df_part_w_3["w_3_Total Games Won Percentage"], errors="coerce"
)
df_part_w_3["w_3_Total Games Won"] = pd.to_numeric(
    df_part_w_3["w_3_Total Games Won"], errors="coerce"
)
df_part_w_3["w_3_Total Games Played"] = pd.to_numeric(
    df_part_w_3["w_3_Total Games Played"], errors="coerce"
)

# Verifica si la columna 'w_3_Net Points Won' existe
if "w_3_Net Points Won" in df_part_w_3.columns:
    df_part_w_3["w_3_Net Points Won"] = df_part_w_3["w_3_Net Points Won"].astype(str)
    df_part_w_3[
        ["w_3_Net Points Won Percentage", "w_3_Net Points Won", "w_3_Net Points Played"]
    ] = df_part_w_3["w_3_Net Points Won"].str.extract(r"(\d+)% \((\d+)/(\d+)\)")

    df_part_w_3["w_3_Net Points Won Percentage"] = pd.to_numeric(
        df_part_w_3["w_3_Net Points Won Percentage"], errors="coerce"
    )
    df_part_w_3["w_3_Net Points Won"] = pd.to_numeric(
        df_part_w_3["w_3_Net Points Won"], errors="coerce"
    )
    df_part_w_3["w_3_Net Points Played"] = pd.to_numeric(
        df_part_w_3["w_3_Net Points Played"], errors="coerce"
    )
else:
    # Si no existe la columna, la agregamos con valores NaN
    df_part_w_3[
        ["w_3_Net Points Won Percentage", "w_3_Net Points Won", "w_3_Net Points Played"]
    ] = np.nan

if "w_3_Winners" not in df_part_w_3.columns:
    df_part_w_3["w_3_Winners"] = None

if "w_3_Unforced Errors" not in df_part_w_3.columns:
    df_part_w_3["w_3_Unforced Errors"] = None

if "w_3_Average 1st Serve Speed" not in df_part_w_3.columns:
    df_part_w_3["w_3_Average 1st Serve Speed"] = None
else:
    df_part_w_3["w_3_Average 1st Serve Speed"] = df_part_w_3[
        "w_3_Average 1st Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)

if "w_3_Average 2nd Serve Speed" not in df_part_w_3.columns:
    df_part_w_3["w_3_Average 2nd Serve Speed"] = None
else:
    df_part_w_3["w_3_Average 2nd Serve Speed"] = df_part_w_3[
        "w_3_Average 2nd Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)


# Primer servicio
df_part_w_4["w_4_1st Serve Percentage"] = df_part_w_4[
    "w_4_1st Serve Percentage"
].str.replace("%", "")
df_part_w_4["w_4_1st Serve Percentage"] = pd.to_numeric(
    df_part_w_4["w_4_1st Serve Percentage"], errors="coerce"
).astype("Int64")

df_part_w_4[
    [
        "w_4_1st Serve Points Won Percentage",
        "w_4_1st Serve Points Won",
        "w_4_1st Serve Points Played",
    ]
] = (
    df_part_w_4["w_4_1st Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_4["w_4_1st Serve Points Won Percentage"] = pd.to_numeric(
    df_part_w_4["w_4_1st Serve Points Won Percentage"], errors="coerce"
)
df_part_w_4["w_4_1st Serve Points Won"] = pd.to_numeric(
    df_part_w_4["w_4_1st Serve Points Won"], errors="coerce"
)
df_part_w_4["w_4_1st Serve Points Played"] = pd.to_numeric(
    df_part_w_4["w_4_1st Serve Points Played"], errors="coerce"
)

# Segundo servicio
df_part_w_4[
    [
        "w_4_2nd Serve Points Won Percentage",
        "w_4_2nd Serve Points Won",
        "w_4_2nd Serve Points Played",
    ]
] = (
    df_part_w_4["w_4_2nd Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_4["w_4_2nd Serve Points Won Percentage"] = pd.to_numeric(
    df_part_w_4["w_4_2nd Serve Points Won Percentage"], errors="coerce"
)
df_part_w_4["w_4_2nd Serve Points Won"] = pd.to_numeric(
    df_part_w_4["w_4_2nd Serve Points Won"], errors="coerce"
)
df_part_w_4["w_4_2nd Serve Points Played"] = pd.to_numeric(
    df_part_w_4["w_4_2nd Serve Points Played"], errors="coerce"
)

# Break points saved
df_part_w_4[
    [
        "w_4_Break Points Saved Percentage",
        "w_4_Break Points Saved",
        "w_4_Break Points Faced",
    ]
] = (
    df_part_w_4["w_4_Break Points Saved"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_4["w_4_Break Points Saved Percentage"] = pd.to_numeric(
    df_part_w_4["w_4_Break Points Saved Percentage"], errors="coerce"
)
df_part_w_4["w_4_Break Points Saved"] = pd.to_numeric(
    df_part_w_4["w_4_Break Points Saved"], errors="coerce"
)
df_part_w_4["w_4_Break Points Faced"] = pd.to_numeric(
    df_part_w_4["w_4_Break Points Faced"], errors="coerce"
)

# First Return Points Won
df_part_w_4[
    [
        "w_4_1st Return Points Won Percentage",
        "w_4_1st Return Points Won",
        "w_4_1st Return Points Played",
    ]
] = (
    df_part_w_4["w_4_1st Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_4["w_4_1st Return Points Won Percentage"] = pd.to_numeric(
    df_part_w_4["w_4_1st Return Points Won Percentage"], errors="coerce"
)
df_part_w_4["w_4_1st Return Points Won"] = pd.to_numeric(
    df_part_w_4["w_4_1st Return Points Won"], errors="coerce"
)
df_part_w_4["w_4_1st Return Points Played"] = pd.to_numeric(
    df_part_w_4["w_4_1st Return Points Played"], errors="coerce"
)


# Second Return Points Won
df_part_w_4[
    [
        "w_4_2nd Return Points Won Percentage",
        "w_4_2nd Return Points Won",
        "w_4_2nd Return Points Played",
    ]
] = (
    df_part_w_4["w_4_2nd Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_4["w_4_2nd Return Points Won Percentage"] = pd.to_numeric(
    df_part_w_4["w_4_2nd Return Points Won Percentage"], errors="coerce"
)
df_part_w_4["w_4_2nd Return Points Won"] = pd.to_numeric(
    df_part_w_4["w_4_2nd Return Points Won"], errors="coerce"
)
df_part_w_4["w_4_2nd Return Points Played"] = pd.to_numeric(
    df_part_w_4["w_4_2nd Return Points Played"], errors="coerce"
)


# Break points COnverted
df_part_w_4[
    [
        "w_4_Break Points Converted Percentage",
        "w_4_Break Points Converted",
        "w_4_Break Points chances",
    ]
] = (
    df_part_w_4["w_4_Break Points Converted"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_4["w_4_Break Points Converted Percentage"] = pd.to_numeric(
    df_part_w_4["w_4_Break Points Converted Percentage"], errors="coerce"
)
df_part_w_4["w_4_Break Points Converted"] = pd.to_numeric(
    df_part_w_4["w_4_Break Points Converted"], errors="coerce"
)
df_part_w_4["w_4_Break Points chances"] = pd.to_numeric(
    df_part_w_4["w_4_Break Points chances"], errors="coerce"
)

# Service Points Won
df_part_w_4[
    [
        "w_4_Service Points Won Percentage",
        "w_4_Service Points Won",
        "w_4_Service Points Played",
    ]
] = (
    df_part_w_4["w_4_Service Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_4["w_4_Service Points Won Percentage"] = pd.to_numeric(
    df_part_w_4["w_4_Service Points Won Percentage"], errors="coerce"
)
df_part_w_4["w_4_Service Points Won"] = pd.to_numeric(
    df_part_w_4["w_4_Service Points Won"], errors="coerce"
)
df_part_w_4["w_4_Service Points Played"] = pd.to_numeric(
    df_part_w_4["w_4_Service Points Played"], errors="coerce"
)

# Return Points Won
df_part_w_4[
    [
        "w_4_Return Points Won Percentage",
        "w_4_Return Points Won",
        "w_4_Return Points Played",
    ]
] = (
    df_part_w_4["w_4_Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_4["w_4_Return Points Won Percentage"] = pd.to_numeric(
    df_part_w_4["w_4_Return Points Won Percentage"], errors="coerce"
)
df_part_w_4["w_4_Return Points Won"] = pd.to_numeric(
    df_part_w_4["w_4_Return Points Won"], errors="coerce"
)
df_part_w_4["w_4_Return Points Played"] = pd.to_numeric(
    df_part_w_4["w_4_Return Points Played"], errors="coerce"
)

# Total Points Won
df_part_w_4[
    [
        "w_4_Total Points Won Percentage",
        "w_4_Total Points Won",
        "w_4_Total Points Played",
    ]
] = (
    df_part_w_4["w_4_Total Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_4["w_4_Total Points Won Percentage"] = pd.to_numeric(
    df_part_w_4["w_4_Total Points Won Percentage"], errors="coerce"
)
df_part_w_4["w_4_Total Points Won"] = pd.to_numeric(
    df_part_w_4["w_4_Total Points Won"], errors="coerce"
)
df_part_w_4["w_4_Total Points Played"] = pd.to_numeric(
    df_part_w_4["w_4_Total Points Played"], errors="coerce"
)

# Service games Won
df_part_w_4[
    [
        "w_4_Service Games Won Percentage",
        "w_4_Service Games Won",
        "w_4_Service Games Played",
    ]
] = (
    df_part_w_4["w_4_Service Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_4["w_4_Service Games Won Percentage"] = pd.to_numeric(
    df_part_w_4["w_4_Service Games Won Percentage"], errors="coerce"
)
df_part_w_4["w_4_Service Games Won"] = pd.to_numeric(
    df_part_w_4["w_4_Service Games Won"], errors="coerce"
)
df_part_w_4["w_4_Service Games Played"] = pd.to_numeric(
    df_part_w_4["w_4_Service Games Played"], errors="coerce"
)

# Return games Won
df_part_w_4[
    [
        "w_4_Return Games Won Percentage",
        "w_4_Return Games Won",
        "w_4_Return Games Played",
    ]
] = (
    df_part_w_4["w_4_Return Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_4["w_4_Return Games Won Percentage"] = pd.to_numeric(
    df_part_w_4["w_4_Return Games Won Percentage"], errors="coerce"
)
df_part_w_4["w_4_Return Games Won"] = pd.to_numeric(
    df_part_w_4["w_4_Return Games Won"], errors="coerce"
)
df_part_w_4["w_4_Return Games Played"] = pd.to_numeric(
    df_part_w_4["w_4_Return Games Played"], errors="coerce"
)

# Total games Won
df_part_w_4[
    ["w_4_Total Games Won Percentage", "w_4_Total Games Won", "w_4_Total Games Played"]
] = (
    df_part_w_4["w_4_Total Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_4["w_4_Total Games Won Percentage"] = pd.to_numeric(
    df_part_w_4["w_4_Total Games Won Percentage"], errors="coerce"
)
df_part_w_4["w_4_Total Games Won"] = pd.to_numeric(
    df_part_w_4["w_4_Total Games Won"], errors="coerce"
)
df_part_w_4["w_4_Total Games Played"] = pd.to_numeric(
    df_part_w_4["w_4_Total Games Played"], errors="coerce"
)

# Verifica si la columna 'w_4_Net Points Won' existe
if "w_4_Net Points Won" in df_part_w_4.columns:
    df_part_w_4["w_4_Net Points Won"] = df_part_w_4["w_4_Net Points Won"].astype(str)
    df_part_w_4[
        ["w_4_Net Points Won Percentage", "w_4_Net Points Won", "w_4_Net Points Played"]
    ] = df_part_w_4["w_4_Net Points Won"].str.extract(r"(\d+)% \((\d+)/(\d+)\)")

    df_part_w_4["w_4_Net Points Won Percentage"] = pd.to_numeric(
        df_part_w_4["w_4_Net Points Won Percentage"], errors="coerce"
    )
    df_part_w_4["w_4_Net Points Won"] = pd.to_numeric(
        df_part_w_4["w_4_Net Points Won"], errors="coerce"
    )
    df_part_w_4["w_4_Net Points Played"] = pd.to_numeric(
        df_part_w_4["w_4_Net Points Played"], errors="coerce"
    )
else:
    # Si no existe la columna, la agregamos con valores NaN
    df_part_w_4[
        ["w_4_Net Points Won Percentage", "w_4_Net Points Won", "w_4_Net Points Played"]
    ] = np.nan

if "w_4_Winners" not in df_part_w_4.columns:
    df_part_w_4["w_4_Winners"] = None

if "w_4_Unforced Errors" not in df_part_w_4.columns:
    df_part_w_4["w_4_Unforced Errors"] = None

if "w_4_Average 1st Serve Speed" not in df_part_w_4.columns:
    df_part_w_4["w_4_Average 1st Serve Speed"] = None
else:
    df_part_w_4["w_4_Average 1st Serve Speed"] = df_part_w_4[
        "w_4_Average 1st Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)

if "w_4_Average 2nd Serve Speed" not in df_part_w_4.columns:
    df_part_w_4["w_4_Average 2nd Serve Speed"] = None
else:
    df_part_w_4["w_4_Average 2nd Serve Speed"] = df_part_w_4[
        "w_4_Average 2nd Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)


# Primer servicio
df_part_w_5["w_5_1st Serve Percentage"] = df_part_w_5[
    "w_5_1st Serve Percentage"
].str.replace("%", "")
df_part_w_5["w_5_1st Serve Percentage"] = pd.to_numeric(
    df_part_w_5["w_5_1st Serve Percentage"], errors="coerce"
).astype("Int64")

df_part_w_5[
    [
        "w_5_1st Serve Points Won Percentage",
        "w_5_1st Serve Points Won",
        "w_5_1st Serve Points Played",
    ]
] = (
    df_part_w_5["w_5_1st Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_5["w_5_1st Serve Points Won Percentage"] = pd.to_numeric(
    df_part_w_5["w_5_1st Serve Points Won Percentage"], errors="coerce"
)
df_part_w_5["w_5_1st Serve Points Won"] = pd.to_numeric(
    df_part_w_5["w_5_1st Serve Points Won"], errors="coerce"
)
df_part_w_5["w_5_1st Serve Points Played"] = pd.to_numeric(
    df_part_w_5["w_5_1st Serve Points Played"], errors="coerce"
)

# Segundo servicio
df_part_w_5[
    [
        "w_5_2nd Serve Points Won Percentage",
        "w_5_2nd Serve Points Won",
        "w_5_2nd Serve Points Played",
    ]
] = (
    df_part_w_5["w_5_2nd Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_5["w_5_2nd Serve Points Won Percentage"] = pd.to_numeric(
    df_part_w_5["w_5_2nd Serve Points Won Percentage"], errors="coerce"
)
df_part_w_5["w_5_2nd Serve Points Won"] = pd.to_numeric(
    df_part_w_5["w_5_2nd Serve Points Won"], errors="coerce"
)
df_part_w_5["w_5_2nd Serve Points Played"] = pd.to_numeric(
    df_part_w_5["w_5_2nd Serve Points Played"], errors="coerce"
)

# Break points saved
df_part_w_5[
    [
        "w_5_Break Points Saved Percentage",
        "w_5_Break Points Saved",
        "w_5_Break Points Faced",
    ]
] = (
    df_part_w_5["w_5_Break Points Saved"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_5["w_5_Break Points Saved Percentage"] = pd.to_numeric(
    df_part_w_5["w_5_Break Points Saved Percentage"], errors="coerce"
)
df_part_w_5["w_5_Break Points Saved"] = pd.to_numeric(
    df_part_w_5["w_5_Break Points Saved"], errors="coerce"
)
df_part_w_5["w_5_Break Points Faced"] = pd.to_numeric(
    df_part_w_5["w_5_Break Points Faced"], errors="coerce"
)

# First Return Points Won
df_part_w_5[
    [
        "w_5_1st Return Points Won Percentage",
        "w_5_1st Return Points Won",
        "w_5_1st Return Points Played",
    ]
] = (
    df_part_w_5["w_5_1st Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_5["w_5_1st Return Points Won Percentage"] = pd.to_numeric(
    df_part_w_5["w_5_1st Return Points Won Percentage"], errors="coerce"
)
df_part_w_5["w_5_1st Return Points Won"] = pd.to_numeric(
    df_part_w_5["w_5_1st Return Points Won"], errors="coerce"
)
df_part_w_5["w_5_1st Return Points Played"] = pd.to_numeric(
    df_part_w_5["w_5_1st Return Points Played"], errors="coerce"
)


# Second Return Points Won
df_part_w_5[
    [
        "w_5_2nd Return Points Won Percentage",
        "w_5_2nd Return Points Won",
        "w_5_2nd Return Points Played",
    ]
] = (
    df_part_w_5["w_5_2nd Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_5["w_5_2nd Return Points Won Percentage"] = pd.to_numeric(
    df_part_w_5["w_5_2nd Return Points Won Percentage"], errors="coerce"
)
df_part_w_5["w_5_2nd Return Points Won"] = pd.to_numeric(
    df_part_w_5["w_5_2nd Return Points Won"], errors="coerce"
)
df_part_w_5["w_5_2nd Return Points Played"] = pd.to_numeric(
    df_part_w_5["w_5_2nd Return Points Played"], errors="coerce"
)


# Break points COnverted
df_part_w_5[
    [
        "w_5_Break Points Converted Percentage",
        "w_5_Break Points Converted",
        "w_5_Break Points chances",
    ]
] = (
    df_part_w_5["w_5_Break Points Converted"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_5["w_5_Break Points Converted Percentage"] = pd.to_numeric(
    df_part_w_5["w_5_Break Points Converted Percentage"], errors="coerce"
)
df_part_w_5["w_5_Break Points Converted"] = pd.to_numeric(
    df_part_w_5["w_5_Break Points Converted"], errors="coerce"
)
df_part_w_5["w_5_Break Points chances"] = pd.to_numeric(
    df_part_w_5["w_5_Break Points chances"], errors="coerce"
)

# Service Points Won
df_part_w_5[
    [
        "w_5_Service Points Won Percentage",
        "w_5_Service Points Won",
        "w_5_Service Points Played",
    ]
] = (
    df_part_w_5["w_5_Service Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_5["w_5_Service Points Won Percentage"] = pd.to_numeric(
    df_part_w_5["w_5_Service Points Won Percentage"], errors="coerce"
)
df_part_w_5["w_5_Service Points Won"] = pd.to_numeric(
    df_part_w_5["w_5_Service Points Won"], errors="coerce"
)
df_part_w_5["w_5_Service Points Played"] = pd.to_numeric(
    df_part_w_5["w_5_Service Points Played"], errors="coerce"
)

# Return Points Won
df_part_w_5[
    [
        "w_5_Return Points Won Percentage",
        "w_5_Return Points Won",
        "w_5_Return Points Played",
    ]
] = (
    df_part_w_5["w_5_Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_5["w_5_Return Points Won Percentage"] = pd.to_numeric(
    df_part_w_5["w_5_Return Points Won Percentage"], errors="coerce"
)
df_part_w_5["w_5_Return Points Won"] = pd.to_numeric(
    df_part_w_5["w_5_Return Points Won"], errors="coerce"
)
df_part_w_5["w_5_Return Points Played"] = pd.to_numeric(
    df_part_w_5["w_5_Return Points Played"], errors="coerce"
)

# Total Points Won
df_part_w_5[
    [
        "w_5_Total Points Won Percentage",
        "w_5_Total Points Won",
        "w_5_Total Points Played",
    ]
] = (
    df_part_w_5["w_5_Total Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_5["w_5_Total Points Won Percentage"] = pd.to_numeric(
    df_part_w_5["w_5_Total Points Won Percentage"], errors="coerce"
)
df_part_w_5["w_5_Total Points Won"] = pd.to_numeric(
    df_part_w_5["w_5_Total Points Won"], errors="coerce"
)
df_part_w_5["w_5_Total Points Played"] = pd.to_numeric(
    df_part_w_5["w_5_Total Points Played"], errors="coerce"
)

# Service games Won
df_part_w_5[
    [
        "w_5_Service Games Won Percentage",
        "w_5_Service Games Won",
        "w_5_Service Games Played",
    ]
] = (
    df_part_w_5["w_5_Service Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_5["w_5_Service Games Won Percentage"] = pd.to_numeric(
    df_part_w_5["w_5_Service Games Won Percentage"], errors="coerce"
)
df_part_w_5["w_5_Service Games Won"] = pd.to_numeric(
    df_part_w_5["w_5_Service Games Won"], errors="coerce"
)
df_part_w_5["w_5_Service Games Played"] = pd.to_numeric(
    df_part_w_5["w_5_Service Games Played"], errors="coerce"
)

# Return games Won
df_part_w_5[
    [
        "w_5_Return Games Won Percentage",
        "w_5_Return Games Won",
        "w_5_Return Games Played",
    ]
] = (
    df_part_w_5["w_5_Return Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_5["w_5_Return Games Won Percentage"] = pd.to_numeric(
    df_part_w_5["w_5_Return Games Won Percentage"], errors="coerce"
)
df_part_w_5["w_5_Return Games Won"] = pd.to_numeric(
    df_part_w_5["w_5_Return Games Won"], errors="coerce"
)
df_part_w_5["w_5_Return Games Played"] = pd.to_numeric(
    df_part_w_5["w_5_Return Games Played"], errors="coerce"
)

# Total games Won
df_part_w_5[
    ["w_5_Total Games Won Percentage", "w_5_Total Games Won", "w_5_Total Games Played"]
] = (
    df_part_w_5["w_5_Total Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_w_5["w_5_Total Games Won Percentage"] = pd.to_numeric(
    df_part_w_5["w_5_Total Games Won Percentage"], errors="coerce"
)
df_part_w_5["w_5_Total Games Won"] = pd.to_numeric(
    df_part_w_5["w_5_Total Games Won"], errors="coerce"
)
df_part_w_5["w_5_Total Games Played"] = pd.to_numeric(
    df_part_w_5["w_5_Total Games Played"], errors="coerce"
)

# Verifica si la columna 'w_5_Net Points Won' existe
if "w_5_Net Points Won" in df_part_w_5.columns:
    df_part_w_5["w_5_Net Points Won"] = df_part_w_5["w_5_Net Points Won"].astype(str)
    df_part_w_5[
        ["w_5_Net Points Won Percentage", "w_5_Net Points Won", "w_5_Net Points Played"]
    ] = df_part_w_5["w_5_Net Points Won"].str.extract(r"(\d+)% \((\d+)/(\d+)\)")

    df_part_w_5["w_5_Net Points Won Percentage"] = pd.to_numeric(
        df_part_w_5["w_5_Net Points Won Percentage"], errors="coerce"
    )
    df_part_w_5["w_5_Net Points Won"] = pd.to_numeric(
        df_part_w_5["w_5_Net Points Won"], errors="coerce"
    )
    df_part_w_5["w_5_Net Points Played"] = pd.to_numeric(
        df_part_w_5["w_5_Net Points Played"], errors="coerce"
    )
else:
    # Si no existe la columna, la agregamos con valores NaN
    df_part_w_5[
        ["w_5_Net Points Won Percentage", "w_5_Net Points Won", "w_5_Net Points Played"]
    ] = np.nan

if "w_5_Winners" not in df_part_w_5.columns:
    df_part_w_5["w_5_Winners"] = None

if "w_5_Unforced Errors" not in df_part_w_5.columns:
    df_part_w_5["w_5_Unforced Errors"] = None

if "w_5_Average 1st Serve Speed" not in df_part_w_5.columns:
    df_part_w_5["w_5_Average 1st Serve Speed"] = None
else:
    df_part_w_5["w_5_Average 1st Serve Speed"] = df_part_w_5[
        "w_5_Average 1st Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)

if "w_5_Average 2nd Serve Speed" not in df_part_w_5.columns:
    df_part_w_5["w_5_Average 2nd Serve Speed"] = None
else:
    df_part_w_5["w_5_Average 2nd Serve Speed"] = df_part_w_5[
        "w_5_Average 2nd Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)

### loses

# Primer servicio
df_part_l_t["l_t_1st Serve Percentage"] = df_part_l_t[
    "l_t_1st Serve Percentage"
].str.replace("%", "")
df_part_l_t["l_t_1st Serve Percentage"] = pd.to_numeric(
    df_part_l_t["l_t_1st Serve Percentage"], errors="coerce"
).astype("Int64")

df_part_l_t[
    [
        "l_t_1st Serve Points Won Percentage",
        "l_t_1st Serve Points Won",
        "l_t_1st Serve Points Played",
    ]
] = (
    df_part_l_t["l_t_1st Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_t["l_t_1st Serve Points Won Percentage"] = pd.to_numeric(
    df_part_l_t["l_t_1st Serve Points Won Percentage"], errors="coerce"
)
df_part_l_t["l_t_1st Serve Points Won"] = pd.to_numeric(
    df_part_l_t["l_t_1st Serve Points Won"], errors="coerce"
)
df_part_l_t["l_t_1st Serve Points Played"] = pd.to_numeric(
    df_part_l_t["l_t_1st Serve Points Played"], errors="coerce"
)

# Segundo servicio
df_part_l_t[
    [
        "l_t_2nd Serve Points Won Percentage",
        "l_t_2nd Serve Points Won",
        "l_t_2nd Serve Points Played",
    ]
] = (
    df_part_l_t["l_t_2nd Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_t["l_t_2nd Serve Points Won Percentage"] = pd.to_numeric(
    df_part_l_t["l_t_2nd Serve Points Won Percentage"], errors="coerce"
)
df_part_l_t["l_t_2nd Serve Points Won"] = pd.to_numeric(
    df_part_l_t["l_t_2nd Serve Points Won"], errors="coerce"
)
df_part_l_t["l_t_2nd Serve Points Played"] = pd.to_numeric(
    df_part_l_t["l_t_2nd Serve Points Played"], errors="coerce"
)

# Break points saved
df_part_l_t[
    [
        "l_t_Break Points Saved Percentage",
        "l_t_Break Points Saved",
        "l_t_Break Points Faced",
    ]
] = (
    df_part_l_t["l_t_Break Points Saved"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_t["l_t_Break Points Saved Percentage"] = pd.to_numeric(
    df_part_l_t["l_t_Break Points Saved Percentage"], errors="coerce"
)
df_part_l_t["l_t_Break Points Saved"] = pd.to_numeric(
    df_part_l_t["l_t_Break Points Saved"], errors="coerce"
)
df_part_l_t["l_t_Break Points Faced"] = pd.to_numeric(
    df_part_l_t["l_t_Break Points Faced"], errors="coerce"
)

# First Return Points Won
df_part_l_t[
    [
        "l_t_1st Return Points Won Percentage",
        "l_t_1st Return Points Won",
        "l_t_1st Return Points Played",
    ]
] = (
    df_part_l_t["l_t_1st Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_t["l_t_1st Return Points Won Percentage"] = pd.to_numeric(
    df_part_l_t["l_t_1st Return Points Won Percentage"], errors="coerce"
)
df_part_l_t["l_t_1st Return Points Won"] = pd.to_numeric(
    df_part_l_t["l_t_1st Return Points Won"], errors="coerce"
)
df_part_l_t["l_t_1st Return Points Played"] = pd.to_numeric(
    df_part_l_t["l_t_1st Return Points Played"], errors="coerce"
)


# Second Return Points Won
df_part_l_t[
    [
        "l_t_2nd Return Points Won Percentage",
        "l_t_2nd Return Points Won",
        "l_t_2nd Return Points Played",
    ]
] = (
    df_part_l_t["l_t_2nd Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_t["l_t_2nd Return Points Won Percentage"] = pd.to_numeric(
    df_part_l_t["l_t_2nd Return Points Won Percentage"], errors="coerce"
)
df_part_l_t["l_t_2nd Return Points Won"] = pd.to_numeric(
    df_part_l_t["l_t_2nd Return Points Won"], errors="coerce"
)
df_part_l_t["l_t_2nd Return Points Played"] = pd.to_numeric(
    df_part_l_t["l_t_2nd Return Points Played"], errors="coerce"
)


# Break points COnverted
df_part_l_t[
    [
        "l_t_Break Points Converted Percentage",
        "l_t_Break Points Converted",
        "l_t_Break Points chances",
    ]
] = (
    df_part_l_t["l_t_Break Points Converted"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_t["l_t_Break Points Converted Percentage"] = pd.to_numeric(
    df_part_l_t["l_t_Break Points Converted Percentage"], errors="coerce"
)
df_part_l_t["l_t_Break Points Converted"] = pd.to_numeric(
    df_part_l_t["l_t_Break Points Converted"], errors="coerce"
)
df_part_l_t["l_t_Break Points chances"] = pd.to_numeric(
    df_part_l_t["l_t_Break Points chances"], errors="coerce"
)

# Service Points Won
df_part_l_t[
    [
        "l_t_Service Points Won Percentage",
        "l_t_Service Points Won",
        "l_t_Service Points Played",
    ]
] = (
    df_part_l_t["l_t_Service Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_t["l_t_Service Points Won Percentage"] = pd.to_numeric(
    df_part_l_t["l_t_Service Points Won Percentage"], errors="coerce"
)
df_part_l_t["l_t_Service Points Won"] = pd.to_numeric(
    df_part_l_t["l_t_Service Points Won"], errors="coerce"
)
df_part_l_t["l_t_Service Points Played"] = pd.to_numeric(
    df_part_l_t["l_t_Service Points Played"], errors="coerce"
)

# Return Points Won
df_part_l_t[
    [
        "l_t_Return Points Won Percentage",
        "l_t_Return Points Won",
        "l_t_Return Points Played",
    ]
] = (
    df_part_l_t["l_t_Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_t["l_t_Return Points Won Percentage"] = pd.to_numeric(
    df_part_l_t["l_t_Return Points Won Percentage"], errors="coerce"
)
df_part_l_t["l_t_Return Points Won"] = pd.to_numeric(
    df_part_l_t["l_t_Return Points Won"], errors="coerce"
)
df_part_l_t["l_t_Return Points Played"] = pd.to_numeric(
    df_part_l_t["l_t_Return Points Played"], errors="coerce"
)

# Total Points Won
df_part_l_t[
    [
        "l_t_Total Points Won Percentage",
        "l_t_Total Points Won",
        "l_t_Total Points Played",
    ]
] = (
    df_part_l_t["l_t_Total Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_t["l_t_Total Points Won Percentage"] = pd.to_numeric(
    df_part_l_t["l_t_Total Points Won Percentage"], errors="coerce"
)
df_part_l_t["l_t_Total Points Won"] = pd.to_numeric(
    df_part_l_t["l_t_Total Points Won"], errors="coerce"
)
df_part_l_t["l_t_Total Points Played"] = pd.to_numeric(
    df_part_l_t["l_t_Total Points Played"], errors="coerce"
)

# Service games Won
df_part_l_t[
    [
        "l_t_Service Games Won Percentage",
        "l_t_Service Games Won",
        "l_t_Service Games Played",
    ]
] = (
    df_part_l_t["l_t_Service Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_t["l_t_Service Games Won Percentage"] = pd.to_numeric(
    df_part_l_t["l_t_Service Games Won Percentage"], errors="coerce"
)
df_part_l_t["l_t_Service Games Won"] = pd.to_numeric(
    df_part_l_t["l_t_Service Games Won"], errors="coerce"
)
df_part_l_t["l_t_Service Games Played"] = pd.to_numeric(
    df_part_l_t["l_t_Service Games Played"], errors="coerce"
)

# Return games Won
df_part_l_t[
    [
        "l_t_Return Games Won Percentage",
        "l_t_Return Games Won",
        "l_t_Return Games Played",
    ]
] = (
    df_part_l_t["l_t_Return Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_t["l_t_Return Games Won Percentage"] = pd.to_numeric(
    df_part_l_t["l_t_Return Games Won Percentage"], errors="coerce"
)
df_part_l_t["l_t_Return Games Won"] = pd.to_numeric(
    df_part_l_t["l_t_Return Games Won"], errors="coerce"
)
df_part_l_t["l_t_Return Games Played"] = pd.to_numeric(
    df_part_l_t["l_t_Return Games Played"], errors="coerce"
)

# Total games Won
df_part_l_t[
    ["l_t_Total Games Won Percentage", "l_t_Total Games Won", "l_t_Total Games Played"]
] = (
    df_part_l_t["l_t_Total Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_t["l_t_Total Games Won Percentage"] = pd.to_numeric(
    df_part_l_t["l_t_Total Games Won Percentage"], errors="coerce"
)
df_part_l_t["l_t_Total Games Won"] = pd.to_numeric(
    df_part_l_t["l_t_Total Games Won"], errors="coerce"
)
df_part_l_t["l_t_Total Games Played"] = pd.to_numeric(
    df_part_l_t["l_t_Total Games Played"], errors="coerce"
)

# Verifica si la columna 'l_t_Net Points Won' existe
if "l_t_Net Points Won" in df_part_l_t.columns:
    df_part_l_t["l_t_Net Points Won"] = df_part_l_t["l_t_Net Points Won"].astype(str)
    df_part_l_t[
        ["l_t_Net Points Won Percentage", "l_t_Net Points Won", "l_t_Net Points Played"]
    ] = df_part_l_t["l_t_Net Points Won"].str.extract(r"(\d+)% \((\d+)/(\d+)\)")

    df_part_l_t["l_t_Net Points Won Percentage"] = pd.to_numeric(
        df_part_l_t["l_t_Net Points Won Percentage"], errors="coerce"
    )
    df_part_l_t["l_t_Net Points Won"] = pd.to_numeric(
        df_part_l_t["l_t_Net Points Won"], errors="coerce"
    )
    df_part_l_t["l_t_Net Points Played"] = pd.to_numeric(
        df_part_l_t["l_t_Net Points Played"], errors="coerce"
    )
else:
    # Si no existe la columna, la agregamos con valores NaN
    df_part_l_t[
        ["l_t_Net Points Won Percentage", "l_t_Net Points Won", "l_t_Net Points Played"]
    ] = np.nan

if "l_t_Winners" not in df_part_l_t.columns:
    df_part_l_t["l_t_Winners"] = None

if "l_t_Unforced Errors" not in df_part_l_t.columns:
    df_part_l_t["l_t_Unforced Errors"] = None

if "l_t_Average 1st Serve Speed" not in df_part_l_t.columns:
    df_part_l_t["l_t_Average 1st Serve Speed"] = None
else:
    df_part_l_t["l_t_Average 1st Serve Speed"] = df_part_l_t[
        "l_t_Average 1st Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)

if "l_t_Average 2nd Serve Speed" not in df_part_l_t.columns:
    df_part_l_t["l_t_Average 2nd Serve Speed"] = None
else:
    df_part_l_t["l_t_Average 2nd Serve Speed"] = df_part_l_t[
        "l_t_Average 2nd Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)


# Primer servicio
df_part_l_1["l_1_1st Serve Percentage"] = df_part_l_1[
    "l_1_1st Serve Percentage"
].str.replace("%", "")
df_part_l_1["l_1_1st Serve Percentage"] = pd.to_numeric(
    df_part_l_1["l_1_1st Serve Percentage"], errors="coerce"
).astype("Int64")

df_part_l_1[
    [
        "l_1_1st Serve Points Won Percentage",
        "l_1_1st Serve Points Won",
        "l_1_1st Serve Points Played",
    ]
] = (
    df_part_l_1["l_1_1st Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_1["l_1_1st Serve Points Won Percentage"] = pd.to_numeric(
    df_part_l_1["l_1_1st Serve Points Won Percentage"], errors="coerce"
)
df_part_l_1["l_1_1st Serve Points Won"] = pd.to_numeric(
    df_part_l_1["l_1_1st Serve Points Won"], errors="coerce"
)
df_part_l_1["l_1_1st Serve Points Played"] = pd.to_numeric(
    df_part_l_1["l_1_1st Serve Points Played"], errors="coerce"
)

# Segundo servicio
df_part_l_1[
    [
        "l_1_2nd Serve Points Won Percentage",
        "l_1_2nd Serve Points Won",
        "l_1_2nd Serve Points Played",
    ]
] = (
    df_part_l_1["l_1_2nd Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_1["l_1_2nd Serve Points Won Percentage"] = pd.to_numeric(
    df_part_l_1["l_1_2nd Serve Points Won Percentage"], errors="coerce"
)
df_part_l_1["l_1_2nd Serve Points Won"] = pd.to_numeric(
    df_part_l_1["l_1_2nd Serve Points Won"], errors="coerce"
)
df_part_l_1["l_1_2nd Serve Points Played"] = pd.to_numeric(
    df_part_l_1["l_1_2nd Serve Points Played"], errors="coerce"
)

# Break points saved
df_part_l_1[
    [
        "l_1_Break Points Saved Percentage",
        "l_1_Break Points Saved",
        "l_1_Break Points Faced",
    ]
] = (
    df_part_l_1["l_1_Break Points Saved"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_1["l_1_Break Points Saved Percentage"] = pd.to_numeric(
    df_part_l_1["l_1_Break Points Saved Percentage"], errors="coerce"
)
df_part_l_1["l_1_Break Points Saved"] = pd.to_numeric(
    df_part_l_1["l_1_Break Points Saved"], errors="coerce"
)
df_part_l_1["l_1_Break Points Faced"] = pd.to_numeric(
    df_part_l_1["l_1_Break Points Faced"], errors="coerce"
)

# First Return Points Won
df_part_l_1[
    [
        "l_1_1st Return Points Won Percentage",
        "l_1_1st Return Points Won",
        "l_1_1st Return Points Played",
    ]
] = (
    df_part_l_1["l_1_1st Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_1["l_1_1st Return Points Won Percentage"] = pd.to_numeric(
    df_part_l_1["l_1_1st Return Points Won Percentage"], errors="coerce"
)
df_part_l_1["l_1_1st Return Points Won"] = pd.to_numeric(
    df_part_l_1["l_1_1st Return Points Won"], errors="coerce"
)
df_part_l_1["l_1_1st Return Points Played"] = pd.to_numeric(
    df_part_l_1["l_1_1st Return Points Played"], errors="coerce"
)


# Second Return Points Won
df_part_l_1[
    [
        "l_1_2nd Return Points Won Percentage",
        "l_1_2nd Return Points Won",
        "l_1_2nd Return Points Played",
    ]
] = (
    df_part_l_1["l_1_2nd Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_1["l_1_2nd Return Points Won Percentage"] = pd.to_numeric(
    df_part_l_1["l_1_2nd Return Points Won Percentage"], errors="coerce"
)
df_part_l_1["l_1_2nd Return Points Won"] = pd.to_numeric(
    df_part_l_1["l_1_2nd Return Points Won"], errors="coerce"
)
df_part_l_1["l_1_2nd Return Points Played"] = pd.to_numeric(
    df_part_l_1["l_1_2nd Return Points Played"], errors="coerce"
)


# Break points COnverted
df_part_l_1[
    [
        "l_1_Break Points Converted Percentage",
        "l_1_Break Points Converted",
        "l_1_Break Points chances",
    ]
] = (
    df_part_l_1["l_1_Break Points Converted"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_1["l_1_Break Points Converted Percentage"] = pd.to_numeric(
    df_part_l_1["l_1_Break Points Converted Percentage"], errors="coerce"
)
df_part_l_1["l_1_Break Points Converted"] = pd.to_numeric(
    df_part_l_1["l_1_Break Points Converted"], errors="coerce"
)
df_part_l_1["l_1_Break Points chances"] = pd.to_numeric(
    df_part_l_1["l_1_Break Points chances"], errors="coerce"
)

# Service Points Won
df_part_l_1[
    [
        "l_1_Service Points Won Percentage",
        "l_1_Service Points Won",
        "l_1_Service Points Played",
    ]
] = (
    df_part_l_1["l_1_Service Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_1["l_1_Service Points Won Percentage"] = pd.to_numeric(
    df_part_l_1["l_1_Service Points Won Percentage"], errors="coerce"
)
df_part_l_1["l_1_Service Points Won"] = pd.to_numeric(
    df_part_l_1["l_1_Service Points Won"], errors="coerce"
)
df_part_l_1["l_1_Service Points Played"] = pd.to_numeric(
    df_part_l_1["l_1_Service Points Played"], errors="coerce"
)

# Return Points Won
df_part_l_1[
    [
        "l_1_Return Points Won Percentage",
        "l_1_Return Points Won",
        "l_1_Return Points Played",
    ]
] = (
    df_part_l_1["l_1_Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_1["l_1_Return Points Won Percentage"] = pd.to_numeric(
    df_part_l_1["l_1_Return Points Won Percentage"], errors="coerce"
)
df_part_l_1["l_1_Return Points Won"] = pd.to_numeric(
    df_part_l_1["l_1_Return Points Won"], errors="coerce"
)
df_part_l_1["l_1_Return Points Played"] = pd.to_numeric(
    df_part_l_1["l_1_Return Points Played"], errors="coerce"
)

# Total Points Won
df_part_l_1[
    [
        "l_1_Total Points Won Percentage",
        "l_1_Total Points Won",
        "l_1_Total Points Played",
    ]
] = (
    df_part_l_1["l_1_Total Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_1["l_1_Total Points Won Percentage"] = pd.to_numeric(
    df_part_l_1["l_1_Total Points Won Percentage"], errors="coerce"
)
df_part_l_1["l_1_Total Points Won"] = pd.to_numeric(
    df_part_l_1["l_1_Total Points Won"], errors="coerce"
)
df_part_l_1["l_1_Total Points Played"] = pd.to_numeric(
    df_part_l_1["l_1_Total Points Played"], errors="coerce"
)

# Service games Won
df_part_l_1[
    [
        "l_1_Service Games Won Percentage",
        "l_1_Service Games Won",
        "l_1_Service Games Played",
    ]
] = (
    df_part_l_1["l_1_Service Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_1["l_1_Service Games Won Percentage"] = pd.to_numeric(
    df_part_l_1["l_1_Service Games Won Percentage"], errors="coerce"
)
df_part_l_1["l_1_Service Games Won"] = pd.to_numeric(
    df_part_l_1["l_1_Service Games Won"], errors="coerce"
)
df_part_l_1["l_1_Service Games Played"] = pd.to_numeric(
    df_part_l_1["l_1_Service Games Played"], errors="coerce"
)

# Return games Won
df_part_l_1[
    [
        "l_1_Return Games Won Percentage",
        "l_1_Return Games Won",
        "l_1_Return Games Played",
    ]
] = (
    df_part_l_1["l_1_Return Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_1["l_1_Return Games Won Percentage"] = pd.to_numeric(
    df_part_l_1["l_1_Return Games Won Percentage"], errors="coerce"
)
df_part_l_1["l_1_Return Games Won"] = pd.to_numeric(
    df_part_l_1["l_1_Return Games Won"], errors="coerce"
)
df_part_l_1["l_1_Return Games Played"] = pd.to_numeric(
    df_part_l_1["l_1_Return Games Played"], errors="coerce"
)

# Total games Won
df_part_l_1[
    ["l_1_Total Games Won Percentage", "l_1_Total Games Won", "l_1_Total Games Played"]
] = (
    df_part_l_1["l_1_Total Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_1["l_1_Total Games Won Percentage"] = pd.to_numeric(
    df_part_l_1["l_1_Total Games Won Percentage"], errors="coerce"
)
df_part_l_1["l_1_Total Games Won"] = pd.to_numeric(
    df_part_l_1["l_1_Total Games Won"], errors="coerce"
)
df_part_l_1["l_1_Total Games Played"] = pd.to_numeric(
    df_part_l_1["l_1_Total Games Played"], errors="coerce"
)

# Verifica si la columna 'l_1_Net Points Won' existe
if "l_1_Net Points Won" in df_part_l_1.columns:
    df_part_l_1["l_1_Net Points Won"] = df_part_l_1["l_1_Net Points Won"].astype(str)
    df_part_l_1[
        ["l_1_Net Points Won Percentage", "l_1_Net Points Won", "l_1_Net Points Played"]
    ] = df_part_l_1["l_1_Net Points Won"].str.extract(r"(\d+)% \((\d+)/(\d+)\)")

    df_part_l_1["l_1_Net Points Won Percentage"] = pd.to_numeric(
        df_part_l_1["l_1_Net Points Won Percentage"], errors="coerce"
    )
    df_part_l_1["l_1_Net Points Won"] = pd.to_numeric(
        df_part_l_1["l_1_Net Points Won"], errors="coerce"
    )
    df_part_l_1["l_1_Net Points Played"] = pd.to_numeric(
        df_part_l_1["l_1_Net Points Played"], errors="coerce"
    )
else:
    # Si no existe la columna, la agregamos con valores NaN
    df_part_l_1[
        ["l_1_Net Points Won Percentage", "l_1_Net Points Won", "l_1_Net Points Played"]
    ] = np.nan

if "l_1_Winners" not in df_part_l_1.columns:
    df_part_l_1["l_1_Winners"] = None

if "l_1_Unforced Errors" not in df_part_l_1.columns:
    df_part_l_1["l_1_Unforced Errors"] = None

if "l_1_Average 1st Serve Speed" not in df_part_l_1.columns:
    df_part_l_1["l_1_Average 1st Serve Speed"] = None
else:
    df_part_l_1["l_1_Average 1st Serve Speed"] = df_part_l_1[
        "l_1_Average 1st Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)

if "l_1_Average 2nd Serve Speed" not in df_part_l_1.columns:
    df_part_l_1["l_1_Average 2nd Serve Speed"] = None
else:
    df_part_l_1["l_1_Average 2nd Serve Speed"] = df_part_l_1[
        "l_1_Average 2nd Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)


# Primer servicio
df_part_l_2["l_2_1st Serve Percentage"] = df_part_l_2[
    "l_2_1st Serve Percentage"
].str.replace("%", "")
df_part_l_2["l_2_1st Serve Percentage"] = pd.to_numeric(
    df_part_l_2["l_2_1st Serve Percentage"], errors="coerce"
).astype("Int64")

df_part_l_2[
    [
        "l_2_1st Serve Points Won Percentage",
        "l_2_1st Serve Points Won",
        "l_2_1st Serve Points Played",
    ]
] = (
    df_part_l_2["l_2_1st Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_2["l_2_1st Serve Points Won Percentage"] = pd.to_numeric(
    df_part_l_2["l_2_1st Serve Points Won Percentage"], errors="coerce"
)
df_part_l_2["l_2_1st Serve Points Won"] = pd.to_numeric(
    df_part_l_2["l_2_1st Serve Points Won"], errors="coerce"
)
df_part_l_2["l_2_1st Serve Points Played"] = pd.to_numeric(
    df_part_l_2["l_2_1st Serve Points Played"], errors="coerce"
)

# Segundo servicio
df_part_l_2[
    [
        "l_2_2nd Serve Points Won Percentage",
        "l_2_2nd Serve Points Won",
        "l_2_2nd Serve Points Played",
    ]
] = (
    df_part_l_2["l_2_2nd Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_2["l_2_2nd Serve Points Won Percentage"] = pd.to_numeric(
    df_part_l_2["l_2_2nd Serve Points Won Percentage"], errors="coerce"
)
df_part_l_2["l_2_2nd Serve Points Won"] = pd.to_numeric(
    df_part_l_2["l_2_2nd Serve Points Won"], errors="coerce"
)
df_part_l_2["l_2_2nd Serve Points Played"] = pd.to_numeric(
    df_part_l_2["l_2_2nd Serve Points Played"], errors="coerce"
)

# Break points saved
df_part_l_2[
    [
        "l_2_Break Points Saved Percentage",
        "l_2_Break Points Saved",
        "l_2_Break Points Faced",
    ]
] = (
    df_part_l_2["l_2_Break Points Saved"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_2["l_2_Break Points Saved Percentage"] = pd.to_numeric(
    df_part_l_2["l_2_Break Points Saved Percentage"], errors="coerce"
)
df_part_l_2["l_2_Break Points Saved"] = pd.to_numeric(
    df_part_l_2["l_2_Break Points Saved"], errors="coerce"
)
df_part_l_2["l_2_Break Points Faced"] = pd.to_numeric(
    df_part_l_2["l_2_Break Points Faced"], errors="coerce"
)

# First Return Points Won
df_part_l_2[
    [
        "l_2_1st Return Points Won Percentage",
        "l_2_1st Return Points Won",
        "l_2_1st Return Points Played",
    ]
] = (
    df_part_l_2["l_2_1st Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_2["l_2_1st Return Points Won Percentage"] = pd.to_numeric(
    df_part_l_2["l_2_1st Return Points Won Percentage"], errors="coerce"
)
df_part_l_2["l_2_1st Return Points Won"] = pd.to_numeric(
    df_part_l_2["l_2_1st Return Points Won"], errors="coerce"
)
df_part_l_2["l_2_1st Return Points Played"] = pd.to_numeric(
    df_part_l_2["l_2_1st Return Points Played"], errors="coerce"
)


# Second Return Points Won
df_part_l_2[
    [
        "l_2_2nd Return Points Won Percentage",
        "l_2_2nd Return Points Won",
        "l_2_2nd Return Points Played",
    ]
] = (
    df_part_l_2["l_2_2nd Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_2["l_2_2nd Return Points Won Percentage"] = pd.to_numeric(
    df_part_l_2["l_2_2nd Return Points Won Percentage"], errors="coerce"
)
df_part_l_2["l_2_2nd Return Points Won"] = pd.to_numeric(
    df_part_l_2["l_2_2nd Return Points Won"], errors="coerce"
)
df_part_l_2["l_2_2nd Return Points Played"] = pd.to_numeric(
    df_part_l_2["l_2_2nd Return Points Played"], errors="coerce"
)


# Break points COnverted
df_part_l_2[
    [
        "l_2_Break Points Converted Percentage",
        "l_2_Break Points Converted",
        "l_2_Break Points chances",
    ]
] = (
    df_part_l_2["l_2_Break Points Converted"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_2["l_2_Break Points Converted Percentage"] = pd.to_numeric(
    df_part_l_2["l_2_Break Points Converted Percentage"], errors="coerce"
)
df_part_l_2["l_2_Break Points Converted"] = pd.to_numeric(
    df_part_l_2["l_2_Break Points Converted"], errors="coerce"
)
df_part_l_2["l_2_Break Points chances"] = pd.to_numeric(
    df_part_l_2["l_2_Break Points chances"], errors="coerce"
)

# Service Points Won
df_part_l_2[
    [
        "l_2_Service Points Won Percentage",
        "l_2_Service Points Won",
        "l_2_Service Points Played",
    ]
] = (
    df_part_l_2["l_2_Service Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_2["l_2_Service Points Won Percentage"] = pd.to_numeric(
    df_part_l_2["l_2_Service Points Won Percentage"], errors="coerce"
)
df_part_l_2["l_2_Service Points Won"] = pd.to_numeric(
    df_part_l_2["l_2_Service Points Won"], errors="coerce"
)
df_part_l_2["l_2_Service Points Played"] = pd.to_numeric(
    df_part_l_2["l_2_Service Points Played"], errors="coerce"
)

# Return Points Won
df_part_l_2[
    [
        "l_2_Return Points Won Percentage",
        "l_2_Return Points Won",
        "l_2_Return Points Played",
    ]
] = (
    df_part_l_2["l_2_Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_2["l_2_Return Points Won Percentage"] = pd.to_numeric(
    df_part_l_2["l_2_Return Points Won Percentage"], errors="coerce"
)
df_part_l_2["l_2_Return Points Won"] = pd.to_numeric(
    df_part_l_2["l_2_Return Points Won"], errors="coerce"
)
df_part_l_2["l_2_Return Points Played"] = pd.to_numeric(
    df_part_l_2["l_2_Return Points Played"], errors="coerce"
)

# Total Points Won
df_part_l_2[
    [
        "l_2_Total Points Won Percentage",
        "l_2_Total Points Won",
        "l_2_Total Points Played",
    ]
] = (
    df_part_l_2["l_2_Total Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_2["l_2_Total Points Won Percentage"] = pd.to_numeric(
    df_part_l_2["l_2_Total Points Won Percentage"], errors="coerce"
)
df_part_l_2["l_2_Total Points Won"] = pd.to_numeric(
    df_part_l_2["l_2_Total Points Won"], errors="coerce"
)
df_part_l_2["l_2_Total Points Played"] = pd.to_numeric(
    df_part_l_2["l_2_Total Points Played"], errors="coerce"
)

# Service games Won
df_part_l_2[
    [
        "l_2_Service Games Won Percentage",
        "l_2_Service Games Won",
        "l_2_Service Games Played",
    ]
] = (
    df_part_l_2["l_2_Service Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_2["l_2_Service Games Won Percentage"] = pd.to_numeric(
    df_part_l_2["l_2_Service Games Won Percentage"], errors="coerce"
)
df_part_l_2["l_2_Service Games Won"] = pd.to_numeric(
    df_part_l_2["l_2_Service Games Won"], errors="coerce"
)
df_part_l_2["l_2_Service Games Played"] = pd.to_numeric(
    df_part_l_2["l_2_Service Games Played"], errors="coerce"
)

# Return games Won
df_part_l_2[
    [
        "l_2_Return Games Won Percentage",
        "l_2_Return Games Won",
        "l_2_Return Games Played",
    ]
] = (
    df_part_l_2["l_2_Return Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_2["l_2_Return Games Won Percentage"] = pd.to_numeric(
    df_part_l_2["l_2_Return Games Won Percentage"], errors="coerce"
)
df_part_l_2["l_2_Return Games Won"] = pd.to_numeric(
    df_part_l_2["l_2_Return Games Won"], errors="coerce"
)
df_part_l_2["l_2_Return Games Played"] = pd.to_numeric(
    df_part_l_2["l_2_Return Games Played"], errors="coerce"
)

# Total games Won
df_part_l_2[
    ["l_2_Total Games Won Percentage", "l_2_Total Games Won", "l_2_Total Games Played"]
] = (
    df_part_l_2["l_2_Total Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_2["l_2_Total Games Won Percentage"] = pd.to_numeric(
    df_part_l_2["l_2_Total Games Won Percentage"], errors="coerce"
)
df_part_l_2["l_2_Total Games Won"] = pd.to_numeric(
    df_part_l_2["l_2_Total Games Won"], errors="coerce"
)
df_part_l_2["l_2_Total Games Played"] = pd.to_numeric(
    df_part_l_2["l_2_Total Games Played"], errors="coerce"
)

# Verifica si la columna 'l_2_Net Points Won' existe
if "l_2_Net Points Won" in df_part_l_2.columns:
    df_part_l_2["l_2_Net Points Won"] = df_part_l_2["l_2_Net Points Won"].astype(str)
    df_part_l_2[
        ["l_2_Net Points Won Percentage", "l_2_Net Points Won", "l_2_Net Points Played"]
    ] = df_part_l_2["l_2_Net Points Won"].str.extract(r"(\d+)% \((\d+)/(\d+)\)")

    df_part_l_2["l_2_Net Points Won Percentage"] = pd.to_numeric(
        df_part_l_2["l_2_Net Points Won Percentage"], errors="coerce"
    )
    df_part_l_2["l_2_Net Points Won"] = pd.to_numeric(
        df_part_l_2["l_2_Net Points Won"], errors="coerce"
    )
    df_part_l_2["l_2_Net Points Played"] = pd.to_numeric(
        df_part_l_2["l_2_Net Points Played"], errors="coerce"
    )
else:
    # Si no existe la columna, la agregamos con valores NaN
    df_part_l_2[
        ["l_2_Net Points Won Percentage", "l_2_Net Points Won", "l_2_Net Points Played"]
    ] = np.nan

if "l_2_Winners" not in df_part_l_2.columns:
    df_part_l_2["l_2_Winners"] = None

if "l_2_Unforced Errors" not in df_part_l_2.columns:
    df_part_l_2["l_2_Unforced Errors"] = None

if "l_2_Average 1st Serve Speed" not in df_part_l_2.columns:
    df_part_l_2["l_2_Average 1st Serve Speed"] = None
else:
    df_part_l_2["l_2_Average 1st Serve Speed"] = df_part_l_2[
        "l_2_Average 1st Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)

if "l_2_Average 2nd Serve Speed" not in df_part_l_2.columns:
    df_part_l_2["l_2_Average 2nd Serve Speed"] = None
else:
    df_part_l_2["l_2_Average 2nd Serve Speed"] = df_part_l_2[
        "l_2_Average 2nd Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)

# Primer servicio
df_part_l_3["l_3_1st Serve Percentage"] = df_part_l_3[
    "l_3_1st Serve Percentage"
].str.replace("%", "")
df_part_l_3["l_3_1st Serve Percentage"] = pd.to_numeric(
    df_part_l_3["l_3_1st Serve Percentage"], errors="coerce"
).astype("Int64")

df_part_l_3[
    [
        "l_3_1st Serve Points Won Percentage",
        "l_3_1st Serve Points Won",
        "l_3_1st Serve Points Played",
    ]
] = (
    df_part_l_3["l_3_1st Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_3["l_3_1st Serve Points Won Percentage"] = pd.to_numeric(
    df_part_l_3["l_3_1st Serve Points Won Percentage"], errors="coerce"
)
df_part_l_3["l_3_1st Serve Points Won"] = pd.to_numeric(
    df_part_l_3["l_3_1st Serve Points Won"], errors="coerce"
)
df_part_l_3["l_3_1st Serve Points Played"] = pd.to_numeric(
    df_part_l_3["l_3_1st Serve Points Played"], errors="coerce"
)

# Segundo servicio
df_part_l_3[
    [
        "l_3_2nd Serve Points Won Percentage",
        "l_3_2nd Serve Points Won",
        "l_3_2nd Serve Points Played",
    ]
] = (
    df_part_l_3["l_3_2nd Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_3["l_3_2nd Serve Points Won Percentage"] = pd.to_numeric(
    df_part_l_3["l_3_2nd Serve Points Won Percentage"], errors="coerce"
)
df_part_l_3["l_3_2nd Serve Points Won"] = pd.to_numeric(
    df_part_l_3["l_3_2nd Serve Points Won"], errors="coerce"
)
df_part_l_3["l_3_2nd Serve Points Played"] = pd.to_numeric(
    df_part_l_3["l_3_2nd Serve Points Played"], errors="coerce"
)

# Break points saved
df_part_l_3[
    [
        "l_3_Break Points Saved Percentage",
        "l_3_Break Points Saved",
        "l_3_Break Points Faced",
    ]
] = (
    df_part_l_3["l_3_Break Points Saved"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_3["l_3_Break Points Saved Percentage"] = pd.to_numeric(
    df_part_l_3["l_3_Break Points Saved Percentage"], errors="coerce"
)
df_part_l_3["l_3_Break Points Saved"] = pd.to_numeric(
    df_part_l_3["l_3_Break Points Saved"], errors="coerce"
)
df_part_l_3["l_3_Break Points Faced"] = pd.to_numeric(
    df_part_l_3["l_3_Break Points Faced"], errors="coerce"
)

# First Return Points Won
df_part_l_3[
    [
        "l_3_1st Return Points Won Percentage",
        "l_3_1st Return Points Won",
        "l_3_1st Return Points Played",
    ]
] = (
    df_part_l_3["l_3_1st Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_3["l_3_1st Return Points Won Percentage"] = pd.to_numeric(
    df_part_l_3["l_3_1st Return Points Won Percentage"], errors="coerce"
)
df_part_l_3["l_3_1st Return Points Won"] = pd.to_numeric(
    df_part_l_3["l_3_1st Return Points Won"], errors="coerce"
)
df_part_l_3["l_3_1st Return Points Played"] = pd.to_numeric(
    df_part_l_3["l_3_1st Return Points Played"], errors="coerce"
)


# Second Return Points Won
df_part_l_3[
    [
        "l_3_2nd Return Points Won Percentage",
        "l_3_2nd Return Points Won",
        "l_3_2nd Return Points Played",
    ]
] = (
    df_part_l_3["l_3_2nd Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_3["l_3_2nd Return Points Won Percentage"] = pd.to_numeric(
    df_part_l_3["l_3_2nd Return Points Won Percentage"], errors="coerce"
)
df_part_l_3["l_3_2nd Return Points Won"] = pd.to_numeric(
    df_part_l_3["l_3_2nd Return Points Won"], errors="coerce"
)
df_part_l_3["l_3_2nd Return Points Played"] = pd.to_numeric(
    df_part_l_3["l_3_2nd Return Points Played"], errors="coerce"
)


# Break points COnverted
df_part_l_3[
    [
        "l_3_Break Points Converted Percentage",
        "l_3_Break Points Converted",
        "l_3_Break Points chances",
    ]
] = (
    df_part_l_3["l_3_Break Points Converted"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_3["l_3_Break Points Converted Percentage"] = pd.to_numeric(
    df_part_l_3["l_3_Break Points Converted Percentage"], errors="coerce"
)
df_part_l_3["l_3_Break Points Converted"] = pd.to_numeric(
    df_part_l_3["l_3_Break Points Converted"], errors="coerce"
)
df_part_l_3["l_3_Break Points chances"] = pd.to_numeric(
    df_part_l_3["l_3_Break Points chances"], errors="coerce"
)

# Service Points Won
df_part_l_3[
    [
        "l_3_Service Points Won Percentage",
        "l_3_Service Points Won",
        "l_3_Service Points Played",
    ]
] = (
    df_part_l_3["l_3_Service Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_3["l_3_Service Points Won Percentage"] = pd.to_numeric(
    df_part_l_3["l_3_Service Points Won Percentage"], errors="coerce"
)
df_part_l_3["l_3_Service Points Won"] = pd.to_numeric(
    df_part_l_3["l_3_Service Points Won"], errors="coerce"
)
df_part_l_3["l_3_Service Points Played"] = pd.to_numeric(
    df_part_l_3["l_3_Service Points Played"], errors="coerce"
)

# Return Points Won
df_part_l_3[
    [
        "l_3_Return Points Won Percentage",
        "l_3_Return Points Won",
        "l_3_Return Points Played",
    ]
] = (
    df_part_l_3["l_3_Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_3["l_3_Return Points Won Percentage"] = pd.to_numeric(
    df_part_l_3["l_3_Return Points Won Percentage"], errors="coerce"
)
df_part_l_3["l_3_Return Points Won"] = pd.to_numeric(
    df_part_l_3["l_3_Return Points Won"], errors="coerce"
)
df_part_l_3["l_3_Return Points Played"] = pd.to_numeric(
    df_part_l_3["l_3_Return Points Played"], errors="coerce"
)

# Total Points Won
df_part_l_3[
    [
        "l_3_Total Points Won Percentage",
        "l_3_Total Points Won",
        "l_3_Total Points Played",
    ]
] = (
    df_part_l_3["l_3_Total Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_3["l_3_Total Points Won Percentage"] = pd.to_numeric(
    df_part_l_3["l_3_Total Points Won Percentage"], errors="coerce"
)
df_part_l_3["l_3_Total Points Won"] = pd.to_numeric(
    df_part_l_3["l_3_Total Points Won"], errors="coerce"
)
df_part_l_3["l_3_Total Points Played"] = pd.to_numeric(
    df_part_l_3["l_3_Total Points Played"], errors="coerce"
)

# Service games Won
df_part_l_3[
    [
        "l_3_Service Games Won Percentage",
        "l_3_Service Games Won",
        "l_3_Service Games Played",
    ]
] = (
    df_part_l_3["l_3_Service Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_3["l_3_Service Games Won Percentage"] = pd.to_numeric(
    df_part_l_3["l_3_Service Games Won Percentage"], errors="coerce"
)
df_part_l_3["l_3_Service Games Won"] = pd.to_numeric(
    df_part_l_3["l_3_Service Games Won"], errors="coerce"
)
df_part_l_3["l_3_Service Games Played"] = pd.to_numeric(
    df_part_l_3["l_3_Service Games Played"], errors="coerce"
)

# Return games Won
df_part_l_3[
    [
        "l_3_Return Games Won Percentage",
        "l_3_Return Games Won",
        "l_3_Return Games Played",
    ]
] = (
    df_part_l_3["l_3_Return Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_3["l_3_Return Games Won Percentage"] = pd.to_numeric(
    df_part_l_3["l_3_Return Games Won Percentage"], errors="coerce"
)
df_part_l_3["l_3_Return Games Won"] = pd.to_numeric(
    df_part_l_3["l_3_Return Games Won"], errors="coerce"
)
df_part_l_3["l_3_Return Games Played"] = pd.to_numeric(
    df_part_l_3["l_3_Return Games Played"], errors="coerce"
)

# Total games Won
df_part_l_3[
    ["l_3_Total Games Won Percentage", "l_3_Total Games Won", "l_3_Total Games Played"]
] = (
    df_part_l_3["l_3_Total Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_3["l_3_Total Games Won Percentage"] = pd.to_numeric(
    df_part_l_3["l_3_Total Games Won Percentage"], errors="coerce"
)
df_part_l_3["l_3_Total Games Won"] = pd.to_numeric(
    df_part_l_3["l_3_Total Games Won"], errors="coerce"
)
df_part_l_3["l_3_Total Games Played"] = pd.to_numeric(
    df_part_l_3["l_3_Total Games Played"], errors="coerce"
)

# Verifica si la columna 'l_3_Net Points Won' existe
if "l_3_Net Points Won" in df_part_l_3.columns:
    df_part_l_3["l_3_Net Points Won"] = df_part_l_3["l_3_Net Points Won"].astype(str)
    df_part_l_3[
        ["l_3_Net Points Won Percentage", "l_3_Net Points Won", "l_3_Net Points Played"]
    ] = df_part_l_3["l_3_Net Points Won"].str.extract(r"(\d+)% \((\d+)/(\d+)\)")

    df_part_l_3["l_3_Net Points Won Percentage"] = pd.to_numeric(
        df_part_l_3["l_3_Net Points Won Percentage"], errors="coerce"
    )
    df_part_l_3["l_3_Net Points Won"] = pd.to_numeric(
        df_part_l_3["l_3_Net Points Won"], errors="coerce"
    )
    df_part_l_3["l_3_Net Points Played"] = pd.to_numeric(
        df_part_l_3["l_3_Net Points Played"], errors="coerce"
    )
else:
    # Si no existe la columna, la agregamos con valores NaN
    df_part_l_3[
        ["l_3_Net Points Won Percentage", "l_3_Net Points Won", "l_3_Net Points Played"]
    ] = np.nan


if "l_3_Winners" not in df_part_l_3.columns:
    df_part_l_3["l_3_Winners"] = None

if "l_3_Unforced Errors" not in df_part_l_3.columns:
    df_part_l_3["l_3_Unforced Errors"] = None

if "l_3_Average 1st Serve Speed" not in df_part_l_3.columns:
    df_part_l_3["l_3_Average 1st Serve Speed"] = None
else:
    df_part_l_3["l_3_Average 1st Serve Speed"] = df_part_l_3[
        "l_3_Average 1st Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)

if "l_3_Average 2nd Serve Speed" not in df_part_l_3.columns:
    df_part_l_3["l_3_Average 2nd Serve Speed"] = None
else:
    df_part_l_3["l_3_Average 2nd Serve Speed"] = df_part_l_3[
        "l_3_Average 2nd Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)

# Primer servicio
df_part_l_4["l_4_1st Serve Percentage"] = df_part_l_4[
    "l_4_1st Serve Percentage"
].str.replace("%", "")
df_part_l_4["l_4_1st Serve Percentage"] = pd.to_numeric(
    df_part_l_4["l_4_1st Serve Percentage"], errors="coerce"
).astype("Int64")

df_part_l_4[
    [
        "l_4_1st Serve Points Won Percentage",
        "l_4_1st Serve Points Won",
        "l_4_1st Serve Points Played",
    ]
] = (
    df_part_l_4["l_4_1st Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_4["l_4_1st Serve Points Won Percentage"] = pd.to_numeric(
    df_part_l_4["l_4_1st Serve Points Won Percentage"], errors="coerce"
)
df_part_l_4["l_4_1st Serve Points Won"] = pd.to_numeric(
    df_part_l_4["l_4_1st Serve Points Won"], errors="coerce"
)
df_part_l_4["l_4_1st Serve Points Played"] = pd.to_numeric(
    df_part_l_4["l_4_1st Serve Points Played"], errors="coerce"
)

# Segundo servicio
df_part_l_4[
    [
        "l_4_2nd Serve Points Won Percentage",
        "l_4_2nd Serve Points Won",
        "l_4_2nd Serve Points Played",
    ]
] = (
    df_part_l_4["l_4_2nd Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_4["l_4_2nd Serve Points Won Percentage"] = pd.to_numeric(
    df_part_l_4["l_4_2nd Serve Points Won Percentage"], errors="coerce"
)
df_part_l_4["l_4_2nd Serve Points Won"] = pd.to_numeric(
    df_part_l_4["l_4_2nd Serve Points Won"], errors="coerce"
)
df_part_l_4["l_4_2nd Serve Points Played"] = pd.to_numeric(
    df_part_l_4["l_4_2nd Serve Points Played"], errors="coerce"
)

# Break points saved
df_part_l_4[
    [
        "l_4_Break Points Saved Percentage",
        "l_4_Break Points Saved",
        "l_4_Break Points Faced",
    ]
] = (
    df_part_l_4["l_4_Break Points Saved"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_4["l_4_Break Points Saved Percentage"] = pd.to_numeric(
    df_part_l_4["l_4_Break Points Saved Percentage"], errors="coerce"
)
df_part_l_4["l_4_Break Points Saved"] = pd.to_numeric(
    df_part_l_4["l_4_Break Points Saved"], errors="coerce"
)
df_part_l_4["l_4_Break Points Faced"] = pd.to_numeric(
    df_part_l_4["l_4_Break Points Faced"], errors="coerce"
)

# First Return Points Won
df_part_l_4[
    [
        "l_4_1st Return Points Won Percentage",
        "l_4_1st Return Points Won",
        "l_4_1st Return Points Played",
    ]
] = (
    df_part_l_4["l_4_1st Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_4["l_4_1st Return Points Won Percentage"] = pd.to_numeric(
    df_part_l_4["l_4_1st Return Points Won Percentage"], errors="coerce"
)
df_part_l_4["l_4_1st Return Points Won"] = pd.to_numeric(
    df_part_l_4["l_4_1st Return Points Won"], errors="coerce"
)
df_part_l_4["l_4_1st Return Points Played"] = pd.to_numeric(
    df_part_l_4["l_4_1st Return Points Played"], errors="coerce"
)


# Second Return Points Won
df_part_l_4[
    [
        "l_4_2nd Return Points Won Percentage",
        "l_4_2nd Return Points Won",
        "l_4_2nd Return Points Played",
    ]
] = (
    df_part_l_4["l_4_2nd Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_4["l_4_2nd Return Points Won Percentage"] = pd.to_numeric(
    df_part_l_4["l_4_2nd Return Points Won Percentage"], errors="coerce"
)
df_part_l_4["l_4_2nd Return Points Won"] = pd.to_numeric(
    df_part_l_4["l_4_2nd Return Points Won"], errors="coerce"
)
df_part_l_4["l_4_2nd Return Points Played"] = pd.to_numeric(
    df_part_l_4["l_4_2nd Return Points Played"], errors="coerce"
)


# Break points COnverted
df_part_l_4[
    [
        "l_4_Break Points Converted Percentage",
        "l_4_Break Points Converted",
        "l_4_Break Points chances",
    ]
] = (
    df_part_l_4["l_4_Break Points Converted"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_4["l_4_Break Points Converted Percentage"] = pd.to_numeric(
    df_part_l_4["l_4_Break Points Converted Percentage"], errors="coerce"
)
df_part_l_4["l_4_Break Points Converted"] = pd.to_numeric(
    df_part_l_4["l_4_Break Points Converted"], errors="coerce"
)
df_part_l_4["l_4_Break Points chances"] = pd.to_numeric(
    df_part_l_4["l_4_Break Points chances"], errors="coerce"
)

# Service Points Won
df_part_l_4[
    [
        "l_4_Service Points Won Percentage",
        "l_4_Service Points Won",
        "l_4_Service Points Played",
    ]
] = (
    df_part_l_4["l_4_Service Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_4["l_4_Service Points Won Percentage"] = pd.to_numeric(
    df_part_l_4["l_4_Service Points Won Percentage"], errors="coerce"
)
df_part_l_4["l_4_Service Points Won"] = pd.to_numeric(
    df_part_l_4["l_4_Service Points Won"], errors="coerce"
)
df_part_l_4["l_4_Service Points Played"] = pd.to_numeric(
    df_part_l_4["l_4_Service Points Played"], errors="coerce"
)

# Return Points Won
df_part_l_4[
    [
        "l_4_Return Points Won Percentage",
        "l_4_Return Points Won",
        "l_4_Return Points Played",
    ]
] = (
    df_part_l_4["l_4_Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_4["l_4_Return Points Won Percentage"] = pd.to_numeric(
    df_part_l_4["l_4_Return Points Won Percentage"], errors="coerce"
)
df_part_l_4["l_4_Return Points Won"] = pd.to_numeric(
    df_part_l_4["l_4_Return Points Won"], errors="coerce"
)
df_part_l_4["l_4_Return Points Played"] = pd.to_numeric(
    df_part_l_4["l_4_Return Points Played"], errors="coerce"
)

# Total Points Won
df_part_l_4[
    [
        "l_4_Total Points Won Percentage",
        "l_4_Total Points Won",
        "l_4_Total Points Played",
    ]
] = (
    df_part_l_4["l_4_Total Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_4["l_4_Total Points Won Percentage"] = pd.to_numeric(
    df_part_l_4["l_4_Total Points Won Percentage"], errors="coerce"
)
df_part_l_4["l_4_Total Points Won"] = pd.to_numeric(
    df_part_l_4["l_4_Total Points Won"], errors="coerce"
)
df_part_l_4["l_4_Total Points Played"] = pd.to_numeric(
    df_part_l_4["l_4_Total Points Played"], errors="coerce"
)

# Service games Won
df_part_l_4[
    [
        "l_4_Service Games Won Percentage",
        "l_4_Service Games Won",
        "l_4_Service Games Played",
    ]
] = (
    df_part_l_4["l_4_Service Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_4["l_4_Service Games Won Percentage"] = pd.to_numeric(
    df_part_l_4["l_4_Service Games Won Percentage"], errors="coerce"
)
df_part_l_4["l_4_Service Games Won"] = pd.to_numeric(
    df_part_l_4["l_4_Service Games Won"], errors="coerce"
)
df_part_l_4["l_4_Service Games Played"] = pd.to_numeric(
    df_part_l_4["l_4_Service Games Played"], errors="coerce"
)

# Return games Won
df_part_l_4[
    [
        "l_4_Return Games Won Percentage",
        "l_4_Return Games Won",
        "l_4_Return Games Played",
    ]
] = (
    df_part_l_4["l_4_Return Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_4["l_4_Return Games Won Percentage"] = pd.to_numeric(
    df_part_l_4["l_4_Return Games Won Percentage"], errors="coerce"
)
df_part_l_4["l_4_Return Games Won"] = pd.to_numeric(
    df_part_l_4["l_4_Return Games Won"], errors="coerce"
)
df_part_l_4["l_4_Return Games Played"] = pd.to_numeric(
    df_part_l_4["l_4_Return Games Played"], errors="coerce"
)

# Total games Won
df_part_l_4[
    ["l_4_Total Games Won Percentage", "l_4_Total Games Won", "l_4_Total Games Played"]
] = (
    df_part_l_4["l_4_Total Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_4["l_4_Total Games Won Percentage"] = pd.to_numeric(
    df_part_l_4["l_4_Total Games Won Percentage"], errors="coerce"
)
df_part_l_4["l_4_Total Games Won"] = pd.to_numeric(
    df_part_l_4["l_4_Total Games Won"], errors="coerce"
)
df_part_l_4["l_4_Total Games Played"] = pd.to_numeric(
    df_part_l_4["l_4_Total Games Played"], errors="coerce"
)

# Verifica si la columna 'l_4_Net Points Won' existe
if "l_4_Net Points Won" in df_part_l_4.columns:
    df_part_l_4["l_4_Net Points Won"] = df_part_l_4["l_4_Net Points Won"].astype(str)
    df_part_l_4[
        ["l_4_Net Points Won Percentage", "l_4_Net Points Won", "l_4_Net Points Played"]
    ] = df_part_l_4["l_4_Net Points Won"].str.extract(r"(\d+)% \((\d+)/(\d+)\)")

    df_part_l_4["l_4_Net Points Won Percentage"] = pd.to_numeric(
        df_part_l_4["l_4_Net Points Won Percentage"], errors="coerce"
    )
    df_part_l_4["l_4_Net Points Won"] = pd.to_numeric(
        df_part_l_4["l_4_Net Points Won"], errors="coerce"
    )
    df_part_l_4["l_4_Net Points Played"] = pd.to_numeric(
        df_part_l_4["l_4_Net Points Played"], errors="coerce"
    )
else:
    # Si no existe la columna, la agregamos con valores NaN
    df_part_l_4[
        ["l_4_Net Points Won Percentage", "l_4_Net Points Won", "l_4_Net Points Played"]
    ] = np.nan

if "l_4_Winners" not in df_part_l_4.columns:
    df_part_l_4["l_4_Winners"] = None

if "l_4_Unforced Errors" not in df_part_l_4.columns:
    df_part_l_4["l_4_Unforced Errors"] = None

if "l_4_Average 1st Serve Speed" not in df_part_l_4.columns:
    df_part_l_4["l_4_Average 1st Serve Speed"] = None
else:
    df_part_l_4["l_4_Average 1st Serve Speed"] = df_part_l_4[
        "l_4_Average 1st Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)

if "l_4_Average 2nd Serve Speed" not in df_part_l_4.columns:
    df_part_l_4["l_4_Average 2nd Serve Speed"] = None
else:
    df_part_l_4["l_4_Average 2nd Serve Speed"] = df_part_l_4[
        "l_4_Average 2nd Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)

# Primer servicio
df_part_l_5["l_5_1st Serve Percentage"] = df_part_l_5[
    "l_5_1st Serve Percentage"
].str.replace("%", "")
df_part_l_5["l_5_1st Serve Percentage"] = pd.to_numeric(
    df_part_l_5["l_5_1st Serve Percentage"], errors="coerce"
).astype("Int64")

df_part_l_5[
    [
        "l_5_1st Serve Points Won Percentage",
        "l_5_1st Serve Points Won",
        "l_5_1st Serve Points Played",
    ]
] = (
    df_part_l_5["l_5_1st Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_5["l_5_1st Serve Points Won Percentage"] = pd.to_numeric(
    df_part_l_5["l_5_1st Serve Points Won Percentage"], errors="coerce"
)
df_part_l_5["l_5_1st Serve Points Won"] = pd.to_numeric(
    df_part_l_5["l_5_1st Serve Points Won"], errors="coerce"
)
df_part_l_5["l_5_1st Serve Points Played"] = pd.to_numeric(
    df_part_l_5["l_5_1st Serve Points Played"], errors="coerce"
)

# Segundo servicio
df_part_l_5[
    [
        "l_5_2nd Serve Points Won Percentage",
        "l_5_2nd Serve Points Won",
        "l_5_2nd Serve Points Played",
    ]
] = (
    df_part_l_5["l_5_2nd Serve Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_5["l_5_2nd Serve Points Won Percentage"] = pd.to_numeric(
    df_part_l_5["l_5_2nd Serve Points Won Percentage"], errors="coerce"
)
df_part_l_5["l_5_2nd Serve Points Won"] = pd.to_numeric(
    df_part_l_5["l_5_2nd Serve Points Won"], errors="coerce"
)
df_part_l_5["l_5_2nd Serve Points Played"] = pd.to_numeric(
    df_part_l_5["l_5_2nd Serve Points Played"], errors="coerce"
)

# Break points saved
df_part_l_5[
    [
        "l_5_Break Points Saved Percentage",
        "l_5_Break Points Saved",
        "l_5_Break Points Faced",
    ]
] = (
    df_part_l_5["l_5_Break Points Saved"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_5["l_5_Break Points Saved Percentage"] = pd.to_numeric(
    df_part_l_5["l_5_Break Points Saved Percentage"], errors="coerce"
)
df_part_l_5["l_5_Break Points Saved"] = pd.to_numeric(
    df_part_l_5["l_5_Break Points Saved"], errors="coerce"
)
df_part_l_5["l_5_Break Points Faced"] = pd.to_numeric(
    df_part_l_5["l_5_Break Points Faced"], errors="coerce"
)

# First Return Points Won
df_part_l_5[
    [
        "l_5_1st Return Points Won Percentage",
        "l_5_1st Return Points Won",
        "l_5_1st Return Points Played",
    ]
] = (
    df_part_l_5["l_5_1st Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_5["l_5_1st Return Points Won Percentage"] = pd.to_numeric(
    df_part_l_5["l_5_1st Return Points Won Percentage"], errors="coerce"
)
df_part_l_5["l_5_1st Return Points Won"] = pd.to_numeric(
    df_part_l_5["l_5_1st Return Points Won"], errors="coerce"
)
df_part_l_5["l_5_1st Return Points Played"] = pd.to_numeric(
    df_part_l_5["l_5_1st Return Points Played"], errors="coerce"
)


# Second Return Points Won
df_part_l_5[
    [
        "l_5_2nd Return Points Won Percentage",
        "l_5_2nd Return Points Won",
        "l_5_2nd Return Points Played",
    ]
] = (
    df_part_l_5["l_5_2nd Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_5["l_5_2nd Return Points Won Percentage"] = pd.to_numeric(
    df_part_l_5["l_5_2nd Return Points Won Percentage"], errors="coerce"
)
df_part_l_5["l_5_2nd Return Points Won"] = pd.to_numeric(
    df_part_l_5["l_5_2nd Return Points Won"], errors="coerce"
)
df_part_l_5["l_5_2nd Return Points Played"] = pd.to_numeric(
    df_part_l_5["l_5_2nd Return Points Played"], errors="coerce"
)


# Break points COnverted
df_part_l_5[
    [
        "l_5_Break Points Converted Percentage",
        "l_5_Break Points Converted",
        "l_5_Break Points chances",
    ]
] = (
    df_part_l_5["l_5_Break Points Converted"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_5["l_5_Break Points Converted Percentage"] = pd.to_numeric(
    df_part_l_5["l_5_Break Points Converted Percentage"], errors="coerce"
)
df_part_l_5["l_5_Break Points Converted"] = pd.to_numeric(
    df_part_l_5["l_5_Break Points Converted"], errors="coerce"
)
df_part_l_5["l_5_Break Points chances"] = pd.to_numeric(
    df_part_l_5["l_5_Break Points chances"], errors="coerce"
)

# Service Points Won
df_part_l_5[
    [
        "l_5_Service Points Won Percentage",
        "l_5_Service Points Won",
        "l_5_Service Points Played",
    ]
] = (
    df_part_l_5["l_5_Service Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_5["l_5_Service Points Won Percentage"] = pd.to_numeric(
    df_part_l_5["l_5_Service Points Won Percentage"], errors="coerce"
)
df_part_l_5["l_5_Service Points Won"] = pd.to_numeric(
    df_part_l_5["l_5_Service Points Won"], errors="coerce"
)
df_part_l_5["l_5_Service Points Played"] = pd.to_numeric(
    df_part_l_5["l_5_Service Points Played"], errors="coerce"
)

# Return Points Won
df_part_l_5[
    [
        "l_5_Return Points Won Percentage",
        "l_5_Return Points Won",
        "l_5_Return Points Played",
    ]
] = (
    df_part_l_5["l_5_Return Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_5["l_5_Return Points Won Percentage"] = pd.to_numeric(
    df_part_l_5["l_5_Return Points Won Percentage"], errors="coerce"
)
df_part_l_5["l_5_Return Points Won"] = pd.to_numeric(
    df_part_l_5["l_5_Return Points Won"], errors="coerce"
)
df_part_l_5["l_5_Return Points Played"] = pd.to_numeric(
    df_part_l_5["l_5_Return Points Played"], errors="coerce"
)

# Total Points Won
df_part_l_5[
    [
        "l_5_Total Points Won Percentage",
        "l_5_Total Points Won",
        "l_5_Total Points Played",
    ]
] = (
    df_part_l_5["l_5_Total Points Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_5["l_5_Total Points Won Percentage"] = pd.to_numeric(
    df_part_l_5["l_5_Total Points Won Percentage"], errors="coerce"
)
df_part_l_5["l_5_Total Points Won"] = pd.to_numeric(
    df_part_l_5["l_5_Total Points Won"], errors="coerce"
)
df_part_l_5["l_5_Total Points Played"] = pd.to_numeric(
    df_part_l_5["l_5_Total Points Played"], errors="coerce"
)

# Service games Won
df_part_l_5[
    [
        "l_5_Service Games Won Percentage",
        "l_5_Service Games Won",
        "l_5_Service Games Played",
    ]
] = (
    df_part_l_5["l_5_Service Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_5["l_5_Service Games Won Percentage"] = pd.to_numeric(
    df_part_l_5["l_5_Service Games Won Percentage"], errors="coerce"
)
df_part_l_5["l_5_Service Games Won"] = pd.to_numeric(
    df_part_l_5["l_5_Service Games Won"], errors="coerce"
)
df_part_l_5["l_5_Service Games Played"] = pd.to_numeric(
    df_part_l_5["l_5_Service Games Played"], errors="coerce"
)

# Return games Won
df_part_l_5[
    [
        "l_5_Return Games Won Percentage",
        "l_5_Return Games Won",
        "l_5_Return Games Played",
    ]
] = (
    df_part_l_5["l_5_Return Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_5["l_5_Return Games Won Percentage"] = pd.to_numeric(
    df_part_l_5["l_5_Return Games Won Percentage"], errors="coerce"
)
df_part_l_5["l_5_Return Games Won"] = pd.to_numeric(
    df_part_l_5["l_5_Return Games Won"], errors="coerce"
)
df_part_l_5["l_5_Return Games Played"] = pd.to_numeric(
    df_part_l_5["l_5_Return Games Played"], errors="coerce"
)

# Total games Won
df_part_l_5[
    ["l_5_Total Games Won Percentage", "l_5_Total Games Won", "l_5_Total Games Played"]
] = (
    df_part_l_5["l_5_Total Games Won"]
    .astype(str)  # Convertir a string si es necesario
    .str.extract(r"(\d+)% \((\d+)/(\d+)\)")
)

df_part_l_5["l_5_Total Games Won Percentage"] = pd.to_numeric(
    df_part_l_5["l_5_Total Games Won Percentage"], errors="coerce"
)
df_part_l_5["l_5_Total Games Won"] = pd.to_numeric(
    df_part_l_5["l_5_Total Games Won"], errors="coerce"
)
df_part_l_5["l_5_Total Games Played"] = pd.to_numeric(
    df_part_l_5["l_5_Total Games Played"], errors="coerce"
)

# Verifica si la columna 'l_5_Net Points Won' existe
if "l_5_Net Points Won" in df_part_l_5.columns:
    df_part_l_5["l_5_Net Points Won"] = df_part_l_5["l_5_Net Points Won"].astype(str)
    df_part_l_5[
        ["l_5_Net Points Won Percentage", "l_5_Net Points Won", "l_5_Net Points Played"]
    ] = df_part_l_5["l_5_Net Points Won"].str.extract(r"(\d+)% \((\d+)/(\d+)\)")

    df_part_l_5["l_5_Net Points Won Percentage"] = pd.to_numeric(
        df_part_l_5["l_5_Net Points Won Percentage"], errors="coerce"
    )
    df_part_l_5["l_5_Net Points Won"] = pd.to_numeric(
        df_part_l_5["l_5_Net Points Won"], errors="coerce"
    )
    df_part_l_5["l_5_Net Points Played"] = pd.to_numeric(
        df_part_l_5["l_5_Net Points Played"], errors="coerce"
    )
else:
    # Si no existe la columna, la agregamos con valores NaN
    df_part_l_5[
        ["l_5_Net Points Won Percentage", "l_5_Net Points Won", "l_5_Net Points Played"]
    ] = np.nan

if "l_5_Winners" not in df_part_l_5.columns:
    df_part_l_5["l_5_Winners"] = None

if "l_5_Unforced Errors" not in df_part_l_5.columns:
    df_part_l_5["l_5_Unforced Errors"] = None

if "l_5_Average 1st Serve Speed" not in df_part_l_5.columns:
    df_part_l_5["l_5_Average 1st Serve Speed"] = None
else:
    df_part_l_5["l_5_Average 1st Serve Speed"] = df_part_l_5[
        "l_5_Average 1st Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)

if "l_5_Average 2nd Serve Speed" not in df_part_l_5.columns:
    df_part_l_5["l_5_Average 2nd Serve Speed"] = None
else:
    df_part_l_5["l_5_Average 2nd Serve Speed"] = df_part_l_5[
        "l_5_Average 2nd Serve Speed"
    ].apply(lambda x: str(x).split(" ")[0] if pd.notna(x) else x)

# %%
# Reemplazar todos los NaN con None (equivalente a null)

df_part_w_t = df_part_w_t.where(pd.notnull(df_part_w_t), None)
df_part_w_t = df_part_w_t.replace(to_replace=r"^WO$", value=None, regex=True)

df_part_w_1 = df_part_w_1.where(pd.notnull(df_part_w_1), None)
df_part_w_1 = df_part_w_1.replace(to_replace=r"^WO$", value=None, regex=True)

df_part_w_2 = df_part_w_2.where(pd.notnull(df_part_w_2), None)
df_part_w_2 = df_part_w_2.replace(to_replace=r"^WO$", value=None, regex=True)

df_part_w_3 = df_part_w_3.where(pd.notnull(df_part_w_3), None)
df_part_w_3 = df_part_w_3.replace(to_replace=r"^WO$", value=None, regex=True)

df_part_w_4 = df_part_w_4.where(pd.notnull(df_part_w_4), None)
df_part_w_4 = df_part_w_4.replace(to_replace=r"^WO$", value=None, regex=True)

df_part_w_5 = df_part_w_5.where(pd.notnull(df_part_w_5), None)
df_part_w_5 = df_part_w_5.replace(to_replace=r"^WO$", value=None, regex=True)


df_part_l_t = df_part_l_t.where(pd.notnull(df_part_l_t), None)
df_part_l_t = df_part_l_t.replace(to_replace=r"^WO$", value=None, regex=True)

df_part_l_1 = df_part_l_1.where(pd.notnull(df_part_l_1), None)
df_part_l_1 = df_part_l_1.replace(to_replace=r"^WO$", value=None, regex=True)

df_part_l_2 = df_part_l_2.where(pd.notnull(df_part_l_2), None)
df_part_l_2 = df_part_l_2.replace(to_replace=r"^WO$", value=None, regex=True)

df_part_l_3 = df_part_l_3.where(pd.notnull(df_part_l_3), None)
df_part_l_3 = df_part_l_3.replace(to_replace=r"^WO$", value=None, regex=True)

df_part_l_4 = df_part_l_4.where(pd.notnull(df_part_l_4), None)
df_part_l_4 = df_part_l_4.replace(to_replace=r"^WO$", value=None, regex=True)

df_part_l_5 = df_part_l_5.where(pd.notnull(df_part_l_5), None)
df_part_l_5 = df_part_l_5.replace(to_replace=r"^WO$", value=None, regex=True)


df_part_w_t.replace([np.nan, pd.NA], None, inplace=True)
df_part_w_1.replace([np.nan, pd.NA], None, inplace=True)
df_part_w_2.replace([np.nan, pd.NA], None, inplace=True)
df_part_w_3.replace([np.nan, pd.NA], None, inplace=True)
df_part_w_4.replace([np.nan, pd.NA], None, inplace=True)
df_part_w_5.replace([np.nan, pd.NA], None, inplace=True)

df_part_l_t.replace([np.nan, pd.NA], None, inplace=True)
df_part_l_1.replace([np.nan, pd.NA], None, inplace=True)
df_part_l_2.replace([np.nan, pd.NA], None, inplace=True)
df_part_l_3.replace([np.nan, pd.NA], None, inplace=True)
df_part_l_4.replace([np.nan, pd.NA], None, inplace=True)
df_part_l_5.replace([np.nan, pd.NA], None, inplace=True)


# Corregir NACIONALIDADES

# Reemplaza "World" por NaN en las columnas W_NAC y L_NAC
df_simple["W_NAC"] = df_simple["W_NAC"].replace("World", np.nan)
df_simple["L_NAC"] = df_simple["L_NAC"].replace("World", np.nan)

players_without_nac_w = df_simple.loc[df_simple["W_NAC"].isna(), "W_PLAYER"]
players_without_nac_L = df_simple.loc[df_simple["L_NAC"].isna(), "L_PLAYER"]

# Diccionario con jugadores y nacionalidades
nacionalidades = {
    "Andrey Rublev": "Russia",
    "Daniil Medvedev": "Russia",
    "Karen Khachanov": "Russia",
    "Roman Safiullin": "Russia",
    "Pavel Kotov": "Russia",
    "Aslan Karatsev": "Russia",
    "Ivan Gakhov": "Russia",
    "Ilya Ivashka": "Belarus",
    "Alexey Vatutin": "Russia",
    "Alexey Zakharov": "Russia",
    "Alibek Kachmazov": "Russia",
    "Chun Hsin Tseng": "Taipei",
    "Dalibor Svrcina": "Czech Republic",
    "Egor Gerasimov": "Belarus",
    "Ergi Kirkin": "Turkey",
    "Hugo Dellien": "Bolivia",
    "Marat Sharipov": "Russia",
    "Ray Ho": "Taipei",
    "Woobin Shin": "South Korea",
    "Zdenek Kolar": "Czech Republic",
    "Jakub Mensik": "Czech Republic",
    "Jiri Lehecka": "Czech Republic",
    "Martin Landaluce": "Spain",
    "Sebastian Korda": "United States",
    "Tomas Machac": "Czech Republic",
    "Vit Kopriva": "Czech Republic",
    "Yu Hsiou Hsu": "Taipei",
    "Cem Ilkel": "Turkey",
    "Evgeny Karlovskiy": "Russia",
    "Gerard Campana Lee": "South Korea",
    "Goncalo Oliveira": "Venezuela",
    "Hazem Naw": "Syria",
    "Jonas Forejtek": "Czech Republic",
    "Marek Gengel": "Czech Republic",
    "Michael Vrbensky": "Czech Republic",
    "Murkel Alejandro Dellien Velasco": "Bolivia",
    "Radu Albot": "Romania",
    "Sanhui Shin": "South Korea",
    "Thanasi Kokkinakis": "Australia",
    "Tung-Lin Wu": "Taipei",
    "Yosuke Watanuki": "Japan",
    "Murphy Cassone": "United States",
    "Juan Carlos Prado Angelo": "Bolivia",
    "NiColombiaas Mejia": "Colombia",
    "Florian Broska": "Germany",
    "Jakub Nicod": "Czech Republic",
    "Tyler Zink": "United States",
    "Egor Agafonov": "Russia",
    "Hynek Barton": "Czech Republic",
    "Maxim Zhukov": "Russia",
    "Max Hans Rehberg": "Germany",
    "Vilius Gaubas": "Lithuania",
    "Tsung-Hao Huang": "Taipei",
    "Evgenii Tiurnev": "Russia",
    "Dominik Palan": "Czech Republic",
    "Jerome Kym": "Switzerland",
    "Eliakim Coulibaly": "Costa Rica",
    "Nikolay Vylegzhanin": "Russia",
    "Ivan Liutarevich": "Belgica",
    "Giulio Zeppieri": "Italy",
    "Pedro Martinez": "Spain",
    "Miomir Kecmanovic": "Serbia",
    "Lorenzo Sonego": "Italy",
    "Luca van Assche": "France",
    "Yoshihito Nishioka": "Japan",
    "Lorenzo Musetti": "Italy",
    "Antoine Escoffier": "France",
    "Jiri Vesely": "Czech Republic",
    "Petr Bar Biryukov": "Russia",
    "Ilia Simakin": "Russia",
    "Pablo Carreno-Busta": "Spain",
    "Richard Gasquet": "France",
    "Matthew Dellavedova": "Australia",
    "Paterne Mamata": "Congo",
    "Ivan Denisov": "Russia",
    "Cheik Pandzou Ekoume": "Congo",
    "Dominik Kellovsky": "Czech Republic",
    "Hamad Medjedovic": "Serbia",
    "Felix Auger-Aliassime": "France",
    "Hiroki Moriya": "Japan",
    "Arthur Fery": "Great Britain",
    "Tommy Paul": "United States",
    "Casper Ruud": "Norway",
    "Rodrigo Pacheco Mendez": "Mexico",
    "Marcos Giron": "United States",
    "Aleksandr Lobanov": "Russia",
    "Kirill Kivattsev": "Russia",
    "Erik Arutiunian": "Belarus",
    "Semen Pankin": "Russia",
    "Zsombor Piros": "Hungary",
    "Yasutaka Uchiyama": "Japan",
    "Yanki Erel": "Turkey",
    "Yan Bai": "China",
    "Stefano Travaglia": "Italy",
    "Ben Shelton": "United States",
    "Federico Arnaboldi": "Italy",
    "Hugo Gaston": "France",
    "Michael Mmoh": "United States",
    "Brandon Nakashima": "United States",
    "Lukas Klein": "Czech Republic",
    "Ricardas Berankis": "Lithuania",
    "Timofey Skatov": "Russia",
    "Jesper De Jong": "Netherlands",
    "Nicolas Mejia": "Colombia",
    "Denis Yevseyev": "Kazakhstan",
    "Vitaliy Sachko": "Ukraine",
    "Arthur Bouquier": "France",
    "Martin Damm": "Czech Republic",
    "Matteo Gigante": "Italy",
    "Gabriele Pennaforti": "Italy",
    "Elmer Moller": "Denmark",
    "Hugo Grenier": "France",
    "Kaichi Uchida": "Japan",
    "Jasza Szajrych": "Poland",
    "James McCabe": "Australia",
    "Gael Monfils": "France",
    "Guido Andreozzi": "Argentina",
    "Mikhail Kukushkin": "Kazakhstan",
    "Brandon Holt": "United States",
    "Laslo Djere": "Serbia",
    "Harold Mayot": "France",
    "Adrian Andreev": "Bulgaria",
    "Andrea Pellegrino": "Italy",
    "Kimmer Coppejans": "Belgium",
    "George Loffhagen": "Great Britain",
    "Alexander Blockx": "Belgium",
    "Jordan Thompson": "Australia",
    "Lilian Marmousez": "France",
    "Sandro Kopp": "Austria",
    "Orlando Luz": "Brazil",
    "Enrico Dalla Valle": "Italy",
    "Arthur Fils": "France",
    "Robert Strombachs": "Germany",
    "Patrick Kypson": "United States",
    "Lukas Neumayer": "Austria",
    "Yi Zhou": "China",
    "Mark Lajal": "Estonia",
    "Nuno Borges": "Portugal",
    "Otto Virtanen": "Finland",
    "Hubert Hurkacz": "Poland",
    "Svyatoslav Gulin": "Russia",
    "Norbert Gombos": "Slovakia",
    "Yuta Shimizu": "Japan",
    "Alastair Gray": "Great Britain",
    "Toby Kodat": "United States",
    "Lui Maxted": "Great Britain",
    "Nicolas Alvarez Varona": "Spain",
    "Aziz Dougaz": "Tunisia",
    "Erasyl Bakhtiyar": "Kazakhstan",
    "Martin Borisiouk": "Belarus",
    "Bekkhan Atlangeriev": "Russia",
    "Evgeny Philippov": "Russia",
    "Saveliy Ivanov": "Russia",
    "Ruslan Tiukaev": "Russia",
    "Alex De Minaur": "Australia",
    "Christopher O'Connell": "Australia",
    "Pedro Boscardin Dias": "Brazil",
    "Marton Fucsovics": "Hungary",
    "Gabriel Diallo": "Canada",
    "Bernard Tomic": "Australia",
    "Fausto Tabacco": "Italy",
    "Mikael Ymer": "Sweden",
    "Nishesh Basavareddy": "United States",
    "Facundo Bagnis": "Argentina",
    "Andrea Picchione": "Italy",
    "Eric Vanshelboim": "Ucraine",
    "Zizou Bergs": "Belgium",
    "Ivan Nedelko": "Russia",
    "Kaito Uesugi": "Japan",
    "David Poljak": "Czech Republic",
    "Jack Draper": "Great Britain",
    "Alvaro Guillen Meza": "Ecuador",
    "Jake Delaney": "Australia",
    "Gabi Adrian Boitan": "Romania",
    "Lukas Pokorny": "Slovakia",
    "Andrea Collarini": "Argentina",
    "Stan Wawrinka": "Switzerland",
    "Matthew Donald": "Czech Republic",
    "Dan Added": "France",
    "Justin Engel": "Germany",
    "Alejandro Moro Canas": "Spain",
    "Joao Lucas Reis Da Silva": "Brazil",
    "Dimitar Kuzmanov": "Bulgaria",
    "Nikolay Sysoev": "Russia",
    "Mikalai Haliak": "Belarus",
    "Aoran Wang": "China",
    "Alexander Zverev": "Germany",
    "Tallon Griekspoor": "Netherlands",
    "Daniil Glinka": "Estonia",
    "Joao Fonseca": "Brazil",
    "Aleksandar Vukic": "Australia",
    "Grigor Dimitrov": "Bulgaria",
    "Reilly Opelka": "United States",
    "Yaroslav Demin": "Russia",
    "Johannes Ingildsen": "Denmark",
    "Jacob Bradshaw": "New Zealand",
    "Gonzalo Villanueva": "Argentina",
    "Scott Jones": "Australia",
    "Tai Sach": "Australia",
    "Blake Ellis": "Australia",
    "Daniil Ostapenkov": "Belarus",
    "Nikolai Barsukov": "Germany",
    "Pavel Petrov": "Russia",
    "Daniil Golubev": "Russia",
    "Sergey Betov": "Belarus",
    "Mark Kaufman": "Russia",
    "Artur Kukasian": "Russia",
    "Marc Andrea Huesler": "Switzerland",
    "Alafia Ayeni": "United States",
    "Timofei Derepasko": "Russia",
    "Leo Vithoontien": "Japan",
    "Brandon Walkin": "Australia",
    "Ivan Gretskiy": "Belarus",
    "Alexey Aleshchev": "Russia",
}


# Asignar nacionalidad a ganadores y perdedores
df_simple["W_NAC"] = (
    df_simple["W_PLAYER"].map(nacionalidades).fillna(df_simple["W_NAC"])
)
df_simple["L_NAC"] = (
    df_simple["L_PLAYER"].map(nacionalidades).fillna(df_simple["L_NAC"])
)

masters_1000 = [
    "Indian Wells",
    "Canada",
    "Cincinnati",
    "Madrid",
    "Miami",
    "Rome",
    "Paris",
    "Shanghai",
    "Monte Carlo",
]

df_simple.loc[
    df_simple["TOURNEY_NAME"].isin(masters_1000) & (df_simple["TOURNEY_LEVEL"] != "CH"),
    "TOURNEY_LEVEL",
] = "M1000"


df_simple["W_PLAYER"] = df_simple["W_PLAYER"].str.replace("-", " ", regex=False)
df_simple["L_PLAYER"] = df_simple["L_PLAYER"].str.replace("-", " ", regex=False)

df_simple["MATCH_STATUS"] = df_simple["MATCH_STATUS"].str.replace(
    r"Finished / retired - .*", "Finished / retired", regex=True
)
df_simple[["W_NAC", "L_NAC", "COUNTRY"]] = df_simple[
    ["W_NAC", "L_NAC", "COUNTRY"]
].replace("USA", "United States")


###################### Para cargar a SQL ##############################

# Lista de sufijos y prefijos de los DataFrames
suffixes = ["t", "1", "2", "3", "4", "5"]
prefixes = ["w", "l"]

# Diccionario para almacenar los DataFrames originales
dataframes = {
    f"df_part_{prefix}_{suffix}": globals()[f"df_part_{prefix}_{suffix}"]
    for prefix in prefixes
    for suffix in suffixes
}

# Diccionario base para los mapeos (mantiene el mismo contenido de base_mapping)
base_mapping = {
    "MATCH_ID": "MATCH_ID",
    "ACES": "Aces",
    "DOUBLE_FAULTS": "Double Faults",
    "WINNERS": "Winners",
    "UNFORCED_ERRORS": "Unforced Errors",
    "AVERAGE_1ST_SERVE_SPEED": "Average 1st Serve Speed",
    "AVERAGE_2ND_SERVE_SPEED": "Average 2nd Serve Speed",
    "1ST_SERVE_PERCENTAGE": "1st Serve Percentage",
    "1ST_SERVE_POINTS_WON_PERCENTAGE": "1st Serve Points Won Percentage",
    "1ST_SERVE_POINTS_WON": "1st Serve Points Won",
    "1ST_SERVE_POINTS_PLAYED": "1st Serve Points Played",
    "2ND_SERVE_POINTS_WON_PERCENTAGE": "2nd Serve Points Won Percentage",
    "2ND_SERVE_POINTS_WON": "2nd Serve Points Won",
    "2ND_SERVE_POINTS_PLAYED": "2nd Serve Points Played",
    "BREAK_POINTS_SAVED_PERCENTAGE": "Break Points Saved Percentage",
    "BREAK_POINTS_SAVED": "Break Points Saved",
    "BREAK_POINTS_FACED": "Break Points Faced",
    "1ST_RETURN_POINTS_WON_PERCENTAGE": "1st Return Points Won Percentage",
    "1ST_RETURN_POINTS_WON": "1st Return Points Won",
    "1ST_RETURN_POINTS_PLAYED": "1st Return Points Played",
    "2ND_RETURN_POINTS_WON_PERCENTAGE": "2nd Return Points Won Percentage",
    "2ND_RETURN_POINTS_WON": "2nd Return Points Won",
    "2ND_RETURN_POINTS_PLAYED": "2nd Return Points Played",
    "BREAK_POINTS_CONVERTED_Percentage": "Break Points Converted Percentage",
    "BREAK_POINTS_CONVERTED": "Break Points Converted",
    "BREAK_POINTS_CHANCES": "Break Points Chances",
    "SERVICE_POINTS_WON_PERCENTAGE": "Service Points Won Percentage",
    "SERVICE_POINTS_WON": "Service Points Won",
    "SERVICE_POINTS_PLAYED": "Service Points Played",
    "RETURN_POINTS_WON_PERCENTAGE": "Return Points Won Percentage",
    "RETURN_POINTS_WON": "Return Points Won",
    "RETURN_POINTS_PLAYED": "Return Points Played",
    "TOTAL_POINTS_WON_PERCENTAGE": "Total Points Won Percentage",
    "TOTAL_POINTS_WON": "Total Points Won",
    "TOTAL_POINTS_PLAYED": "Total Points Played",
    "LAST_10_BALLS": "Last 10 Balls",
    "MATCH_POINTS_SAVED": "Match Points Saved",
    "SERVICE_GAMES_WON_PERCENTAGE": "Service Games Won Percentage",
    "SERVICE_GAMES_WON": "Service Games Won",
    "SERVICE_GAMES_PLAYED": "Service Games Played",
    "RETURN_GAMES_WON_PERCENTAGE": "Return Games Won Percentage",
    "RETURN_GAMES_WON": "Return Games Won",
    "RETURN_GAMES_PLAYED": "Return Games Played",
    "TOTAL_GAMES_WON_PERCENTAGE": "Total Games Won Percentage",
    "TOTAL_GAMES_WON": "Total Games Won",
    "TOTAL_GAMES_PLAYED": "Total Games Played",
    "NET_POINTS_WON_PERCENTAGE": "Net Points Won Percentage",
    "NET_POINTS_WON": "Net Points Won",
    "NET_POINTS_WON_PLAYED": "Net Points Played",
    "DISTANCE_COVERED_METERS": "Distance Covered (metres)",
}

# Diccionario para almacenar los resultados procesados
stats_dict = {}


# Función para procesar columnas
def process_columns(df_stat, prefix, suffix, base_mapping):
    # Crear el mapping específico para el sufijo
    column_mapping = {
        f"{prefix}_{suffix}_{key}": f"{prefix}_{suffix}_{value}"
        for key, value in base_mapping.items()
    }

    # Asegurarse de que las columnas faltantes estén en el DataFrame
    for col in column_mapping.values():
        if col not in df_stat.columns:
            df_stat[col] = np.nan  # Añadir columna faltante con valores NaN

    # Crear el DataFrame renombrado
    df_renamed = df_stat[list(column_mapping.values())].rename(
        columns={v: k for k, v in column_mapping.items()}
    )

    # Convertir los nombres de las columnas a mayúsculas
    df_renamed.columns = [col.upper() for col in df_renamed.columns]

    return df_renamed


# Iterar sobre los DataFrames y procesarlos
for df_name, df in dataframes.items():
    for prefix in prefixes:
        for suffix in suffixes:
            if f"df_part_{prefix}_{suffix}" == df_name:
                stats_dict[f"stats_{prefix}_{suffix}"] = process_columns(
                    df, prefix, suffix, base_mapping
                )


# Supongamos que tu diccionario se llama 'dfs_dict', con las claves siendo nombres y los valores siendo DataFrames.
for key, df in stats_dict.items():
    # Reemplaza todas las columnas cuyo nombre contiene 'MATCH_ID' por 'MATCH_ID'
    df.columns = [col if "MATCH_ID" not in col else "MATCH_ID" for col in df.columns]

print("fin")
##### cargar a SQL


from sqlalchemy import create_engine

# Reemplaza con tus credenciales de base de datos
user = "root"
password = "tennis46"
host = "127.0.0.1"  # O la IP del servidor
database = "tennis_db"

# Crea el engine de conexión
engine = create_engine(f"mysql+pymysql://{user}:{password}@{host}/{database}")

simple_name = categoria + "_simple"
df_simple.to_sql(simple_name, con=engine, if_exists="append", index=False)

simple_pbyp = categoria + "_pbyp"
df_pbyp.to_sql(simple_pbyp, con=engine, if_exists="append", index=False)


# Listas de sufijos para construir las claves del diccionario y nombres de tablas
stats_prefixes = ["stats_w", "stats_l"]
suffixes = ["t", "1", "2", "3", "4", "5"]

# Iterar para generar y guardar dinámicamente
for prefix in stats_prefixes:
    for suffix in suffixes:
        key = f"{prefix}_{suffix}"  # Clave en el diccionario
        table_name = f"{categoria}_{prefix}_{suffix}"  # Nombre de la tabla
        stats_dict[key].to_sql(table_name, con=engine, if_exists="append", index=False)

# %%
