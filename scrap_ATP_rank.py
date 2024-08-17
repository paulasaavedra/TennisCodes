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
dates = [option['value'] for option in options]
date_week = []
i=0
while len(dates)>i:
    date = dates[i].text
    date_week.append(date.replace('.','-'))
    i = i + 1
driver.close()
time.sleep(5)
date_week.remove('1985-03-03')
date_week.remove('1978-01-02')
date_week.remove('1976-03-01')

for actual_week in date_week:
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
    df = pd.DataFrame()
    head = ['date','rank', 'rank_change', 'country', 'player', 'age', 'points']
    
    elements = soup.find_all('tr','lower-row')  
    df = pd.DataFrame(columns=['date', 'rank', 'rank_change', 'country', 'player_id', 'player_name', 'points'])
    
    # acá armo una lista por semana con los datos anteriores para luego armar un dataframe      
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
        country_element = element.find('img', class_= 'flag')['src'].split('/')[-1][:-4]

        # player
        link_player = element.find('li', class_= 'name').find('a')['href']
        player_id_element = link_player.split('/')[-2]
        player_name_element = link_player.split('/')[-3].replace('-',' ').title()
        
        # age
        # age_element = int(element.find('td', class_= 'age small-cell').text)
        # la edad me interesa mucho pero no puedo extaerla
        
        # points cuando hay un error
        
        
        try:
            points_element = int(element.find('td', class_= 'points center bold extrabold small-cell').find('a').text.replace('\n','').rstrip().lstrip().replace(',',''))
        except:
            points_element = 0    
        
        ''' 
        # points cuando todo esta ok
        points_element = int(element.find('td', class_= 'points center bold extrabold small-cell').find('a').text.replace('\n','').rstrip().lstrip().replace(',',''))
        '''
        # points_change
        # no se puede obtener de una manera relativamente sencilla y no se si lo vale

        # tourneyPlayed
        # tourneyPlayed_element = int(element.find('td', class_= 'tourns center small-cell').text)

        # dropping
        #dropping_element = element.find('td', class_= 'drop center small-cell').text.replace(',','')
        #if dropping_element == '-':
        #    dropping_element = 0
        #else:
        #    dropping_element = int(dropping_element)

        # nextBest
        #nextBest_element = element.find('td', class_= 'best center small-cell').text
        #if nextBest_element == '-':
        #    nextBest_element = 0 # cuando tienen - reemplazo con 0
        #else:
        #    nextBest_element = int(nextBest_element)

        
        fila = [actual_week, rank_element, rank_change_element, country_element, player_id_element,
                        player_name_element, points_element]
        fila_df = pd.DataFrame([fila],columns=['date', 'rank', 'rank_change', 'country', 'player_id', 'player_name', 'points'])
        df = pd.concat([df, fila_df], ignore_index=True)
        
    finish_part_time = time.time() - finish_part_time
    print('finish reading week',actual_week)
    print(finish_part_time)
    driver.close()

    # Probar si funciona eliminar duplicados con la siguiente linea
    # df.drop_duplicates()
    df.to_csv('weeks_rank/ranking_' + actual_week + '.csv', header=False, index=False)

finish_time = time.time() - start_time
print(f'Stop reading: {int(finish_time)}.')

