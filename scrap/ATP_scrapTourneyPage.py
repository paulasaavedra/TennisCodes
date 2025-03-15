# -*- coding: utf-8 -*-
"""
Created on Wed Sep 27 21:36:53 2023

@author: Paula
"""

# Scrap tournament, matches, stats in that order

from selenium import webdriver
from bs4 import BeautifulSoup
import time
import pandas as pd

# start scrap

start_time = time.time()
print('Start reading')
# Por algun motivo 1993 no esta
for year in range(1915,1993):
    # Specifying incognito mode as you launch your browser[OPTIONAL]
    option = webdriver.ChromeOptions()
    option.add_argument("--incognito")
    year = 2024
    #we create the driver specifying the origin of chrome browser
    driver = webdriver.Chrome(options=option)
    url = 'https://www.atptour.com/en/scores/results-archive?year=' + str(year)
    
    driver.get(url)
    time.sleep(2)
    
    #we get the internal html code of the body
    body = driver.execute_script("return document.body")
    source = body.get_attribute('innerHTML')
    
    soup = BeautifulSoup(source, "html.parser")
    tournaments = soup.find_all('td', class_= 'title-content')
    all_data = soup.find_all('td', class_='tourney-details')
    
    list_data = []
    links = soup.find_all('a', class_= 'tourney-title')
    hrefs = [elemento.get('href') for elemento in links]
    names = [codigo.split('/')[-3] for codigo in hrefs]
    hrefs = [codigo.split('/')[-2] for codigo in hrefs]
    
    imgs = soup.find_all('td', class_= 'tourney-badge-wrapper')
    
    for i in range(len(tournaments)):
        
        finish_part_time = time.time()
        
        # Tournament type
        try:
            img_element = imgs[i].find('img')
            src_value = img_element.get('src')
        except:
            src_value = ''
            
        if len(src_value) > 0:
            if src_value == '/assets/atpwt/images/tournament/badges/categorystamps_grandslam.png': tourney_type = 'Grand Slam'
            elif src_value == '/assets/atpwt/images/tournament/badges/categorystamps_finals.svg': tourney_type = "ATP Finals"
            elif src_value == '/assets/atpwt/images/tournament/badges/categorystamps_1000.png': tourney_type = "Masters 1000"
            elif src_value == '/assets/atpwt/images/tournament/badges/categorystamps_500.png': tourney_type = "ATP 500"
            elif src_value == '/assets/atpwt/images/tournament/badges/categorystamps_250.png': tourney_type = "ATP 250"
            elif src_value == '/assets/atpwt/images/tournament/badges/categorystamps_lvr.png': tourney_type = "Laver Cup"
            elif src_value == '/assets/atpwt/images/tournament/badges/categorystamps_nextgen.svg': tourney_type = "Next Gen Finals"
            elif src_value == '/assets/atpwt/images/tournament/badges/categorystamps_atpcup.svg': tourney_type = "ATP Cup"
        else:
            tourney_type = 'undefined'
                
        info = tournaments[i].text
        info = info.lstrip()
        tourney_name = info.split('\n')[0]
        
        info = info[len(tourney_name):]
        info = info.lstrip()
        place = info.split('\n')[0]
        
        if (place.replace('.','')).isdigit():
            city = ''
            country = ''
            date = place.replace('.','')
            
        else:
            if len(place.split(','))==2:
                city, country = place.split(',')
            elif len(place.split(','))==1:
                city = str(place)
                country = ''
            else:
                city, state, country = place.split(',')
            info = info[len(place):].lstrip()
            
            date = info.rstrip()
            date = int(date.replace('.',''))
        

        sgl = all_data[i*5].text
        sgl = sgl.lstrip()
        sgl = sgl[3:]
        sgl = int(sgl.lstrip().split('\n')[0])

        info = all_data[i*5+1].text
        info = info.lstrip()
        court_type = info.split('\n')[0]
        
        surface = info[len(court_type):].lstrip().split('\n')[0]
        
        info = all_data[i*5+2].text
        info = info.lstrip().rstrip()
        if info == '':
            currency = 'No data'
            info = '0,'
        elif info[0] == '$': currency = 'USD'
        elif info[0] == '£': currency = 'GBP'
        elif info[0] == '€': currency = 'EUR'
        elif info[0] == 'A': currency = 'AUD'
        else: currency = 'PROBLEM'
        
        prize_money = info.replace(',','')
        prize_money = prize_money.replace('$','')
        prize_money = prize_money.replace('£','')
        prize_money = prize_money.replace('€','')
        prize_money = prize_money.replace('A','')
        prize_money = int(prize_money)
        

        identificacion = hrefs[i]
        nombre_link = names[i]
        elements = {'tourney_id': [identificacion], 'year': [year], 'tourney_type': [tourney_type], 
                    'tourney_name' : [tourney_name] , 'city' : [city],
                    'country' : [country], 'date': [date], 'sgl': [sgl],
                    'court_type': [court_type], 'surface': [surface],
                    'currency': [currency], 'prize_money': [prize_money], 'link_name': [nombre_link]
                    }
        renglon = pd.DataFrame(elements)
        
        list_data.append(renglon)
        
        finish_part_time = time.time() - finish_part_time
        print('finish reading tourney',elements['tourney_name'])
        print(finish_part_time)
        
    df = pd.concat(list_data, ignore_index = True)
    driver.close()
    df.to_csv('C:/Users/Paula/Documents/GitHub/TennisData/SQL/Tabla_torneos/Torneos/' + str(year) + '.csv', index=False)
finish_time = time.time() - start_time
print(f'Stop reading: {int(finish_time)}.')

