# %% #### cargar rankings
import os
import pandas as pd
from sqlalchemy import create_engine
# Ruta donde están los archivos CSV


# Reemplaza con tus credenciales de base de datos
user = "root"
password = "tennis46"
host = "127.0.0.1"  # O la IP del servidor
database = "tennis_db"

# Crea el engine de conexión
engine = create_engine(f"mysql+pymysql://{user}:{password}@{host}/{database}")

ruta_rankings = "/Users/paula/Documents/TennisData/TennisData/ATP_ranking/rank_years/"

# Obtener la lista de archivos CSV en la carpeta
archivos = [
    archivo for archivo in os.listdir(ruta_rankings) if archivo.endswith(".csv")
]

# Crear una lista para almacenar los DataFrames cargados
list_df = []

for archivo in archivos:
    archivo_path = os.path.join(ruta_rankings, archivo)

    # Leer el archivo CSV
    df = pd.read_csv(archivo_path, low_memory=False)

    # Agregar la columna PK_COLUMN
    df["PK_COLUMN"] = df["date"].astype(str) + "_" + df["player_id"].astype(str)

    # Renombrar las columnas
    df.rename(
        columns={
            "PK_COLUMN": "PK_COLUMN",
            "date": "DATE_RANK",
            "rank": "RANK_POSITION",
            "rank_change": "RANK_CHANGE",
            "country": "COUNTRY",
            "player_id": "PLAYER_ID",
            "player": "PLAYER",
            "age": "AGE",
            "points": "POINTS",
            "points_change": "POINTS_CHANGE",
            "tourneyPlayed": "TOURNEY_PLAYED",
            "dropping": "DROPPING",
            "nextBest": "NEXT_BEST",
        },
        inplace=True,
    )

    # Reemplazar valores negativos en AGE por None
    df.loc[df["AGE"] < 0, "AGE"] = None
    df["POINTS"] = (
        df["POINTS"].astype(str).str.replace(",", "").astype(float).astype("Int64")
    )

    print(archivo_path)
    # Insertar los datos en la base de datos
    df.to_sql("atp_rankings", con=engine, if_exists="append", index=False)
