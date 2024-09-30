'''
Busca los links de los nombres de los torneos
de la página Flashscore.
'''

from selenium import webdriver
from selenium.webdriver.common.by import By
from bs4 import BeautifulSoup
import time
import pandas as pd
from datetime import datetime

# start scrap
start_time = time.time()
print('Start reading')

# Especificar el modo incógnito para el navegador (opcional)
option = webdriver.ChromeOptions()
option.add_argument("--incognito")
option.add_argument("--start-maximized")

# Crear el driver especificando el origen de Chrome
driver = webdriver.Chrome(options=option)

url = 'https://www.flashscore.com/tennis/'

driver.get(url)
time.sleep(3)

# Hacer clic en el botón "Show more"
show_more_button = driver.find_element(By.CLASS_NAME, "lmc__itemMore")
driver.execute_script("arguments[0].scrollIntoView();", show_more_button)  # Hacer scroll hasta el botón si es necesario
show_more_button.click()

# Espera un poco para ver los resultados
time.sleep(2)

categorys = ["lmenu_5724", "lmenu_5725", "lmenu_5726",
              "lmenu_5727", "lmenu_5728", "lmenu_5729",
              "lmenu_5730", "lmenu_5731", "lmenu_5732",
              "lmenu_5733", "lmenu_5734", "lmenu_5735",
              "lmenu_5736", "lmenu_5737", "lmenu_5738",
              "lmenu_5739", "lmenu_5740", "lmenu_10883",
              "lmenu_8430", "lmenu_7897", "lmenu_7899",
              "lmenu_7898", "lmenu_7900", "lmenu_5741",
              "lmenu_6393", "lmenu_5743"]


for category in categorys:

    # Encuentra el botón o enlace por su ID y haz clic
    button = driver.find_element(By.ID, category)
    driver.execute_script("arguments[0].scrollIntoView();", button)
    button.click()

    # Espera un poco para que la página cargue completamente
    time.sleep(3)

    # Obtener el HTML de la página actual después del clic
    html = driver.page_source

    # Crear el objeto BeautifulSoup para analizar el HTML
    soup = BeautifulSoup(html, 'html.parser')

    # Encontrar todos los enlaces de torneos
    tournaments = soup.find_all('a', class_='lmc__templateHref')

    # Extraer los nombres y los enlaces, y almacenarlos en listas
    tourney_names = []
    links = []

    for tournament in tournaments:
        tourney_names.append(tournament.text)
        links.append(tournament['href'][1:])
    
    if 'doubles' not in links[0].split('/')[1]:
        # Crear un DataFrame con los datos extraídos
        df = pd.DataFrame({
            'tourney_name': tourney_names,
            'link': links
        })

        df['link'] = df['link'].apply(lambda x: f'https://www.flashscore.com/{x}archive/')

        fecha_hoy = datetime.now().strftime('%Y%m%d')
        category_name = df['link'][0].split('/')[4].replace('-','_')
        # Guardar el DataFrame en un archivo CSV (opcional)
        df.to_csv('C:/Users/Paula/Documents/Projects/TennisData/FS_tourneys/' + category_name + '_tournaments_'+ fecha_hoy  + '.csv', index=False)

    button.click()


# Cierra la ventana de Chrome
driver.quit()
