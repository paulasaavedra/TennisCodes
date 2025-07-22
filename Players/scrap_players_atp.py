# -*- coding: utf-8 -*-
"""
Created on Thu Jul 20 11:59:28 2023

@author: Paula
"""

"""
Este script recibe un string con un nombre y apellido. Busca en la página de la
ATP ese jugador y devuelve una lista con sus datos:
    first_name,
    last_name,
    country,
    dob,
    birth_place,
    turned_pro,
    hand,
    backjand,
    weight,
    height,
    coach
    
"""
from selenium import webdriver
import time
from bs4 import BeautifulSoup

def scrap_players_atp(first_name, last_name):
    
    full_name = first_name + ' ' + last_name
    
    OPTIONS = webdriver.ChromeOptions()
    OPTIONS.add_argument('user-agent=Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, '
                         'like Gecko) Chrome/114.0.5735.199 Mobile Safari/537.36')
    OPTIONS.add_argument('--disable-blink-features=AutomationControlled')
    TZ_PARAMS = {'timezoneId': 'America/Rosario'}
    #OPTIONS.add_argument('--headless')
    
    driver = webdriver.Chrome(options=OPTIONS)
    driver.execute_cdp_cmd('Emulation.setTimezoneOverride', TZ_PARAMS)
    
    full_name_page = full_name.replace(' ','%20')
    url = 'https://www.atptour.com/en/search-results/players?searchTerm=' + full_name_page
    
    #driver.maximize_window()
    driver.get(url)
    time.sleep(2)
    
    # Busco el enlace a la pagina del jugador por su apellido en minusculas
    key_word = (last_name.split(' ')[-1]).lower()
    xpath= "//a[contains(@href, " + "'" + key_word + "'" + ")]"
    try:
        link = driver.find_element_by_xpath(xpath)
    except:
        driver.close()
        return 'Not found'

    
    # Obtener el valor del atributo href del enlace
    player_page = link.get_attribute('href')
    time.sleep(2)
    driver.close()
    if player_page.split('/')[-1] != 'overview':
        return 'Not found'
    # abro la pagina del jugador
    driver = webdriver.Chrome(options=OPTIONS)
    driver.get(player_page)
    
    player_id = player_page.split('/')[-2]
    
    #we get the internal html code of the body
    body = driver.execute_script("return document.body")
    source = body.get_attribute('innerHTML')
    
    soup = BeautifulSoup(source, "html.parser")
    
    # country
    try:
        country = soup.find_all('div','player-flag-code')
        country = country[0].text
    except:
        country = ''
    # dob en formato yyyymmdd
    dob = soup.find_all('div','table-big-value-birthday')
    if len(dob) == 0:
        driver.quit()
        return 'Not found'
    dob = (dob[0].text)[1:-1].replace('.','')
    
    # Turned pro en formato yyyy
    turned_pro = soup.find_all('div','table-big-value')
    turned_pro = (turned_pro[0].text)
    if len(turned_pro) > 4:
        turned_pro=''
    
    # Weight en Kg
    weight = soup.find_all('div','table-big-value-kg')
    weight = (weight[0].text)
    weight = weight.split(' kg')[0].lstrip()[1:]
    
    # Height en cm
    height = soup.find_all('div','table-big-value-cm')
    height = height[0].text
    height = height.split(' cm')[0].lstrip()[1:]
    
    # Birth place
    information = soup.find_all('div','table-value')
    birth_place = information[0].text
    if len(birth_place.rstrip().lstrip().split(', ')) == 1:
        birth_city = birth_place.rstrip().lstrip().split(', ')[0]
        birth_country = ''
    elif len(birth_place.rstrip().lstrip().split(', ')) == 2:
        birth_city, birth_country = birth_place.rstrip().lstrip().split(', ')
    else:
        birth_city, district ,birth_country = birth_place.rstrip().lstrip().split(', ')
    
    # hand es la mano con que juega backhand es el reves
    hands = information[1].text
    if len(hands)<3:
        driver.quit()
        return 'Not found'
    hand, backhand = hands.rstrip().lstrip().split(', ')
    hand = hand.lower()
    backhand = backhand.lower()
    
    if len(hand) < 1:
        hand = 'unknown'
    if len(backhand) < 1:
        backhand = 'unknown backhand'
    
    # coach name
    coach = information[2].text
    coach = coach.rstrip().lstrip()
    driver.quit()
    
    player_dict = {'player_id': player_id,
            'first_name': first_name,
            'last_name':last_name,
            'country': country,
            'dob': dob,
            'turned_pro': turned_pro,
            'weight': weight,
            'height': height,
            'birth_city': birth_city,
            'birth_country': birth_country,
            'hand': hand,
            'backhand': backhand,
            'coach': coach}
    return player_dict
