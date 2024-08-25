import os
import pandas as pd

directorio = 'C:/Users/Paula/Documents/Projects/TennisData/ATP_ranking/rank_weeks/'
archivos_por_anio = {}

for archivo in os.listdir(directorio):
    if archivo.startswith("ranking_") and archivo.endswith(".csv"):
        # Extraer el año del nombre del archivo, asumiendo que está en formato 'ranking_aaaa....csv'
        anio = archivo.split('_')[1][:4]
        if anio not in archivos_por_anio:
            archivos_por_anio[anio] = []
        archivos_por_anio[anio].append(os.path.join(directorio, archivo))

# Procesar archivos por año y crear archivos concatenados
for anio, archivos in archivos_por_anio.items():
    df_list = []
    for archivo in archivos:
        df_temp = pd.read_csv(archivo)
        df_list.append(df_temp)
        print(f"Procesando archivo {archivo} para el año {anio}")
    df_anual = pd.concat(df_list, ignore_index=True)
    archivo_salida = os.path.join('C:/Users/Paula/Documents/Projects/TennisData/ATP_ranking/rank_years/', f'{anio}.csv')
    df_anual.to_csv(archivo_salida, index=False)
    print(f"Archivo anual guardado: {archivo_salida}")
