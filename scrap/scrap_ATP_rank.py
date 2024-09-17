"""
This is a scrip to scrap all the info about rankings in the ATP page.
The idea was scrap all years, but some years doesn't have information.
"""

from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import pandas as pd
from bs4 import BeautifulSoup

# start scrap

start_time = time.time()
print('Start reading')

# Specifying incognito mode as you launch your browser[OPTIONAL]
option = webdriver.ChromeOptions()
option.add_argument("--incognito")
option.add_argument("--start-maximized")

#we create the driver specifying the origin of chrome browser
driver = webdriver.Chrome(options=option)

date = '1984-05-21'
url = 'https://www.atptour.com/en/rankings/singles?rankRange=1-5000&rankDate=' + date

driver.get(url)
time.sleep(5)

#we get the internal html code of the body
body = driver.execute_script("return document.body")
source = body.get_attribute('innerHTML')

soup = BeautifulSoup(source, "html.parser")

# all ranking weeks
select_element = soup.find_all('div', 'atp_filters-dropdown')[2].find('select')
options = select_element.find_all('option')
dates = [option_tag.get_text(strip=True) for option_tag in options]
dates = [fecha.replace('.', '-') for fecha in dates]
driver.close()
time.sleep(5)

dates.remove('1985-03-03')
dates.remove('1978-01-02')
dates.remove('1976-03-01')


for actual_week in dates[1678:]:
    finish_part_time = time.time()
    print('start scraping week', actual_week)
    
    option = webdriver.ChromeOptions()
    option.add_argument("--incognito")
    option.add_argument("--start-maximized")

    #we create the driver specifying the origin of chrome browser
    driver = webdriver.Chrome(options=option)
    
    url = 'https://www.atptour.com/en/rankings/singles?RankRange=1-5000&Region=all&DateWeek=' + actual_week
    
    driver.get(url)
    time.sleep(5)
    
    #we get the internal html code of the body
    body = driver.execute_script("return document.body")
    source = body.get_attribute('innerHTML')
    soup = BeautifulSoup(source, "html.parser")

    table = soup.find('table', class_='mega-table desktop-table non-live')
    table_data = []
    if table:
        rows = table.find_all('tr')
        for row in rows:
            # Extrae todas las celdas de la fila (pueden ser <td> o <th>)
            cells = row.find_all(['td', 'th'])
            # Verifica si hay celdas en la fila y si la fila tiene más de un elemento para evitar propag
            if cells and len(cells) > 1:
                row_data = [cell.get_text(strip=True) for cell in cells]
                table_data.append(row_data)
    df = pd.DataFrame(table_data)
    df = df.drop(df.index[0])
    df.columns = ['rank','player','age','points','points change','tourn played','dropping','next best','']
    
    # Ahora tengo que buscar las nacionalidades
    elements = soup.find_all('tr','lower-row')    
    elements = elements[:(df.shape[0]-1)]   
    i = 0
    df_all_data = pd.DataFrame()
    for element in elements:
        # rank
        rank_element = element.find('td', class_= 'rank bold heavy tiny-cell').text.rstrip().lstrip()
        if "T" in rank_element:
            rank_element = int(rank_element[:-1])

        # rank_change
        rank_change_element = element.find('li', class_= 'rank').text.replace('\n','')
        if len(rank_change_element) < 1 :
            rank_change_element = 0
        else:
            rank_change_element = int (rank_change_element)
        
        # country
        try: 
            country_element = element.find('svg', class_= 'flag').find('use')['href'][-3:].upper()
        except:
            country_element = 'no hay pais'
        # player
        link_player = element.find('li', class_= 'name').find('a')['href']
        player_id_element = link_player.split('/')[-2]
        player_name_element = link_player.split('/')[-3].replace('-',' ').title()
        
        fila = [actual_week, rank_element, rank_change_element, country_element, player_id_element,
                        player_name_element, df.iloc[i]['age'], df.iloc[i]['points'], df.iloc[i]['points change'], df.iloc[i]['tourn played'],
                        df.iloc[i]['dropping'], df.iloc[i]['next best']]
        
        fila_df = pd.DataFrame([fila],columns=['date', 'rank', 'rank_change', 'country', 'player_id', 'player_name', 'age',
                                               'points', 'points change', 'tourn played', 'dropping', 'next best'])
        df_all_data = pd.concat([df_all_data, fila_df], ignore_index=True)
        i = i + 1
            
    finish_part_time = time.time() - finish_part_time
    print('finish reading week',actual_week)
    print(finish_part_time)
    driver.close()

    # Probar si funciona eliminar duplicados con la siguiente linea
    # df.drop_duplicates()
    file_path = 'C:/Users/Paula/Documents/Projects/TennisData/ATP_ranking/rank_weeks/'
    actual_week = actual_week.replace('-','')
    df_all_data.to_csv(file_path + 'ranking_' + actual_week + '.csv', header=False, index=False)

finish_time = time.time() - start_time
print(f'Stop reading: {int(finish_time)}.')
