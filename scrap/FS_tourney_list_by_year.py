'''
Este archivo es para leer archivos csv con nombres de torneo,
abre cada rotneo, va hacia archivo y busca los links de cada torneo
para cada año.
'''

from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import os
import pandas as pd
from datetime import datetime

path = 'C:/Users/Paula/Documents/Projects/TennisData/FS_tourneys/'
output_path = 'C:/Users/Paula/Documents/Projects/TennisData/FS_tourneys_by_year/'
# Recorrer todos los archivos en el directorio
for archivo in os.listdir(path):
    if archivo.endswith('.csv'):
        # Crear la ruta completa al archivo
        path_file = os.path.join(path, archivo)
        
        df = pd.read_csv(path_file)
        tourney_by_year = []
        for index, row in df.iterrows():
            name = row['tourney_name']
            link = row['link']

            # Especificar el modo incógnito para el navegador (opcional)
            option = webdriver.ChromeOptions()
            option.add_argument("--incognito")
            option.add_argument("--start-maximized")

            # Crear el driver especificando el origen de Chrome
            driver = webdriver.Chrome(options=option)

            driver.get(link)
            time.sleep(3)

            tourneys = driver.find_elements(By.CSS_SELECTOR, 'div.archive__season a.archive__text.archive__text--clickable')
            names = driver.find_elements(By.CLASS_NAME, "archive__text--clickable")
            i = 0
            for tourney in tourneys:
                tourny_name = tourney.text
                print('Arranca ' + tourny_name)
                tourny_year= tourny_name.split(' ')[-1] 
                tourny_name = tourny_name[:-5].replace(' ','_')
                tourney_link = tourney.get_attribute('href')
                if '-' not in tourney_link.split('/')[-2]:
                    tourney_link = tourney_link[:-1] + '-' + str(datetime.now().year) + '/'
        
                # Agregar los datos al DataFrame
                tourney_by_year.append({'tourny_year': tourny_year, 'tourny_name': tourny_name, 'tourney_link': tourney_link})
                '''
                if ('ATP_Cup' in tourny_name or 'Davis_Cup' in tourny_name 
                    or 'Dusseldorf' in tourny_name or 'Hopman' in tourny_name or 'Laver_Cup' in tourny_name
                    or 'United_Cup' in tourny_name):
                    i = i + 1
                else:
                    i = i + 2
                '''
            # Cerrar el navegador
            driver.quit()

        # Crear un DataFrame a partir de la lista de diccionarios
        tourney_df = pd.DataFrame(tourney_by_year)

        # Guardar el DataFrame en un CSV con el mismo nombre que el archivo original
        output_file = os.path.join(output_path, archivo.replace('.csv', '_tourneys_by_year.csv'))
        tourney_df.to_csv(output_file, index=False)
        print(f'CSV guardado: {output_file}')
