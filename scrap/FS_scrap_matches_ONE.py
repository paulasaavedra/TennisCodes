# -*- coding: utf-8 -*-
"""
Created on Sun May 21 17:06:28 2023

@author: Paula
"""

import pandas as pd
import time
import glob
import os
import re
from selenium import webdriver
from bs4 import BeautifulSoup
from selenium.webdriver.common.by import By
from collections import OrderedDict
from datetime import datetime


# Checks if the page is fully loaded.
def test_download(driver):
    time.sleep(3)
    page1 = driver.page_source
    time.sleep(5)
    page2 = driver.page_source
    index = 0
    while page1 != page2:
        if index == 5:
            print("Very slow internet speed!")
            page1 = None
            break

        print("Page loading...")
        time.sleep(5)
        page1 = page2
        page2 = driver.page_source
        index += 1
    return page1


def scrap_match(URL, id, year_scrap):
    # Service al final creo que no se usa
    global d_simple_check
    global d_stat_check
    global d_pbyp_check
    OPTIONS = webdriver.ChromeOptions()
    OPTIONS.add_argument(
        "user-agent=Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, "
        "like Gecko) Chrome/103.0.0.0 Mobile Safari/537.36"
    )
    OPTIONS.add_argument("--disable-blink-features=AutomationControlled")
    TZ_PARAMS = {"timezoneId": "America/Rosario"}
    OPTIONS.add_argument("--headless=new")

    driver = webdriver.Chrome(options=OPTIONS)
    driver.execute_cdp_cmd("Emulation.setTimezoneOverride", TZ_PARAMS)
    driver.get(url=URL)
    time.sleep(5)

    body = driver.execute_script("return document.body")
    source = body.get_attribute("innerHTML")

    soup = BeautifulSoup(source, "html.parser")

    status = soup.find(class_="detailScore__status").text  # Status

    if status == "Walkover" or status == "WO" or status == "W/O":
        page_title = driver.title
        anotations = ""
        # 2ª parte del título
        players_part = page_title.split(" | ")[1]

        # Quitamos todo lo que sigue a la fecha (dd/mm/yyyy)
        players_only = re.split(r"\d{2}/\d{2}/\d{4}", players_part)[0].strip()

        # Ahora dividimos los jugadores
        h_player, a_player = players_only.split(" v ")

        # Extraer texto del ganador y limpiar basura
        raw_text = soup.find(class_="duelParticipant--winner").get_text(strip=True)
        clean_text = raw_text.replace("Advancing to next round", "").strip()
        clean_text = clean_text.split("ATP")[0]

        # Dividir en palabras
        parts = clean_text.split()

        if len(parts) > 1 and parts[1].endswith("."):
            # Caso con inicial, ej: "M. Donald"
            winner_initial = parts[1][0]  # "M"
            winner_lastName = parts[0]  # "Donald"
        else:
            # Caso nombre completo, ej: "Novak Djokovic"
            winner_initial = parts[0][0]  # "N"
            winner_lastName = parts[-1]  # "Djokovic"

        # Comparar contra jugadores
        if winner_lastName in h_player and winner_initial == h_player.split(" ")[0][0]:
            winner = "home"
        else:
            winner = "away"

        breadcrumbs = soup.find_all("li", class_="wcl-breadcrumbItem_8btmf")

        tourney_level = breadcrumbs[1].find("span").text.split(" - ")[0]
        tourney_name = breadcrumbs[2].find("span").text.split(", ")[0]

        if "Qualification" in tourney_name:
            tourney_name = tourney_name.split(" - ")[0]

        if tourney_name == "French Open":
            tourney_name = "Roland Garros"

        country = breadcrumbs[2].find("img")["title"]
        surface = (
            breadcrumbs[2].find("span").text.split(", ")[1].split(" - ")[0].capitalize()
        )
        round_match = breadcrumbs[2].find("span").text.split(" - ")[1]

        time_date = soup.find("div", class_="duelParticipant__startTime").text
        date_match = time_date.split(" ")[0]
        date_match = date_match.split(".")
        date_match = int(date_match[2] + date_match[1] + date_match[0])  # Dato
        timestart = time_date.split(" ")[1]  # Dato

        h_nac = a_nac = ""
        h_seed = a_seed = ""
        h_list = a_list = ""
        h_1list = a_1list = ""
        h_2list = a_2list = ""
        h_3list = a_3list = ""
        h_4list = a_4list = ""
        h_5list = a_5list = ""
        score = best = time_total = ""
        time_1s = time_2s = time_3s = time_4s = time_5s = ""
        t_list = t_1list = t_2list = t_3list = t_4list = t_5list = ""
        pointbypoint = ""

        if winner == "home":
            elements = [
                tourney_level,
                tourney_name,
                country,
                surface,
                round_match,
                date_match,
                h_player,
                h_nac,
                h_seed,
                a_player,
                a_nac,
                a_seed,
                h_list,
                h_1list,
                h_2list,
                h_3list,
                h_4list,
                h_5list,
                a_list,
                a_1list,
                a_2list,
                a_3list,
                a_4list,
                a_5list,
                timestart,
                score,
                status,
                best,
                time_total,
                time_1s,
                time_2s,
                time_3s,
                time_4s,
                time_5s,
                t_list,
                t_1list,
                t_2list,
                t_3list,
                t_4list,
                t_5list,
                pointbypoint,
                anotations,
                winner,
            ]
        else:
            elements = [
                tourney_level,
                tourney_name,
                country,
                surface,
                round_match,
                date_match,
                a_player,
                a_nac,
                a_seed,
                h_player,
                h_nac,
                h_seed,
                a_list,
                a_1list,
                a_2list,
                a_3list,
                a_4list,
                a_5list,
                h_list,
                h_1list,
                h_2list,
                h_3list,
                h_4list,
                h_5list,
                timestart,
                score,
                status,
                best,
                time_total,
                time_1s,
                time_2s,
                time_3s,
                time_4s,
                time_5s,
                t_list,
                t_1list,
                t_2list,
                t_3list,
                t_4list,
                t_5list,
                pointbypoint,
                anotations,
                winner,
            ]
    else:
        page_title = driver.title

        # 2ª parte del título
        players_part = page_title.split(" | ")[1]

        # Quitamos todo lo que sigue a la fecha (dd/mm/yyyy)
        players_only = re.split(r"\d{2}/\d{2}/\d{4}", players_part)[0].strip()

        # Ahora dividimos los jugadores
        h_player, a_player = players_only.split(" v ")

        # Extraer texto del ganador y limpiar basura
        raw_text = soup.find(class_="duelParticipant--winner").get_text(strip=True)
        clean_text = raw_text.replace("Advancing to next round", "").strip()
        clean_text = clean_text.split("ATP")[0]

        # Dividir en palabras
        parts = clean_text.split()

        if len(parts) > 1 and parts[1].endswith("."):
            # Caso con inicial, ej: "M. Donald"
            winner_initial = parts[1][0]  # "M"
            winner_lastName = parts[0]  # "Donald"
        else:
            # Caso nombre completo, ej: "Novak Djokovic"
            winner_initial = parts[0][0]  # "N"
            winner_lastName = parts[-1]  # "Djokovic"

        # Comparar contra jugadores
        if winner_lastName in h_player and winner_initial == h_player.split(" ")[0][0]:
            winner = "home"
        else:
            winner = "away"

        breadcrumbs = soup.find_all("li", class_="wcl-breadcrumbItem_8btmf")

        tourney_level = breadcrumbs[1].find("span").text.split(" - ")[0]
        tourney_name = breadcrumbs[2].find("span").text.split(", ")[0]
        if "Qualification" in tourney_name:
            tourney_name = tourney_name.split(" - ")[0]
        if tourney_name == "French Open":
            tourney_name = "Roland Garros"
            tourney_level = "GS"

        country = breadcrumbs[2].find("img")["title"]
        try:
            surface = (
                breadcrumbs[2]
                .find("span")
                .text.split(", ")[1]
                .split(" - ")[0]
                .capitalize()
            )
        except Exception:
            surface = ""
        try:
            round_match = breadcrumbs[2].find("span").text.split(" - ")[1]
        except Exception:
            round_match = ""
        """ 
        title = soup.find(class_='tournamentHeader__country').text  
        
        if len(title.split(' - ')) < 4:
            tourney_level = title.split(' ')[0] #Dato
            tourney_name = title.split(':')[1][1:]
            if tourney_name.split(' ')[0] != 'Davis' and tourney_name.split(' ')[1] != 'Cup':
                tourney_name = tourney_name.split('(')[0][:-1] #Dato
            country = title.split('(')[1]
            country = country.split(')')[0] #Dato
            try:
                surface = title.split(',')[1]
                surface = surface.split(' ')[1] #Dato
            except:
                surface = 'Completar'
            round_match = title.split(' ')[-1] #Dato
        else:
            tourney_level = title.split(' ')[0] + ' - ' + title.split(',')[0].split(' ')[-1] #Dato
            tourney_name = title.split(':')[1][1:]
            if tourney_name.split(' ')[0] != 'Davis' and tourney_name.split(' ')[1] != 'Cup':
                tourney_name = tourney_name.split('(')[0][:-1] #Dato
            country = title.split('(')[1]
            country = country.split(')')[0] #Dato
            try:
                surface = title.split(',')[1]
                surface = surface.split(' ')[1] #Dato
            except:
                surface = 'Completar'
            round_match = title.split(' ')[-1] #Dato
        """

        try:
            anotations = soup.find(class_="infoBox__wrapper infoBoxModule").text
        except Exception:
            anotations = ""

        time_date = soup.find("div", class_="duelParticipant__startTime").text
        date_match = time_date.split(" ")[0]
        date_match = date_match.split(".")
        date_match = int(date_match[2] + date_match[1] + date_match[0])  # Dato
        timestart = time_date.split(" ")[1]  # Dato

        sets = soup.find(class_="detailScore__wrapper").text
        h_sets = int(sets.split("-")[0])
        a_sets = int(sets.split("-")[1])

        if status == "Finished":
            if h_sets > 2 or a_sets > 2:
                best = 5
            else:
                best = 3
        elif "Finished / retired" in status or "Awarded" in status:
            best = 0

        h_nac = soup.find(class_="smh__participantName smh__home").find("span")[
            "title"
        ]  # Dato
        a_nac = soup.find(class_="smh__participantName smh__away").find("span")[
            "title"
        ]  # Dato

        h_seed = soup.find(class_="smh__participantName smh__home").text.split("(")[-1][
            :-1
        ]
        a_seed = soup.find(class_="smh__participantName smh__away").text.split("(")[-1][
            :-1
        ]

        # Information about sets
        sets_values = soup.find_all("div", class_="smh__template tennis")
        h_1set = sets_values[0].find_all(class_="smh__part--1")[0].text
        if len(h_1set) > 1:
            h_1set = h_1set[0] + "(" + h_1set[1:] + ")"

        h_2set = sets_values[0].find_all(class_="smh__part--2")[0].text
        if len(h_2set) > 1:
            h_2set = h_2set[0] + "(" + h_2set[1:] + ")"

        h_3set = sets_values[0].find_all(class_="smh__part--3")[0].text
        if len(h_3set) > 1:
            h_3set = h_3set[0] + "(" + h_3set[1:] + ")"

        h_4set = sets_values[0].find_all(class_="smh__part--4")[0].text
        if len(h_4set) > 1:
            h_4set = h_4set[0] + "(" + h_4set[1:] + ")"

        h_5set = sets_values[0].find_all(class_="smh__part--5")[0].text
        if len(h_5set) > 1:
            h_5set = h_5set[0] + "(" + h_5set[1:] + ")"

        a_1set = sets_values[0].find_all(class_="smh__part--1")[1].text
        if len(a_1set) > 1:
            a_1set = a_1set[0] + "(" + a_1set[1:] + ")"

        a_2set = sets_values[0].find_all(class_="smh__part--2")[1].text
        if len(a_2set) > 1:
            a_2set = a_2set[0] + "(" + a_2set[1:] + ")"

        a_3set = sets_values[0].find_all(class_="smh__part--3")[1].text
        if len(a_3set) > 1:
            a_3set = a_3set[0] + "(" + a_3set[1:] + ")"

        a_4set = sets_values[0].find_all(class_="smh__part--4")[1].text
        if len(a_4set) > 1:
            a_4set = a_4set[0] + "(" + a_4set[1:] + ")"

        a_5set = sets_values[0].find_all(class_="smh__part--5")[1].text
        if len(a_5set) > 1:
            a_5set = a_5set[0] + "(" + a_5set[1:] + ")"

        if winner == "home":
            if h_5set != "" and a_5set != "":
                score = (
                    h_1set
                    + "-"
                    + a_1set
                    + " "
                    + h_2set
                    + "-"
                    + a_2set
                    + " "
                    + h_3set
                    + "-"
                    + a_3set
                    + " "
                    + h_4set
                    + "-"
                    + a_4set
                    + " "
                    + h_5set
                    + "-"
                    + a_5set
                )
            elif h_4set != "" and a_4set != "":
                score = (
                    h_1set
                    + "-"
                    + a_1set
                    + " "
                    + h_2set
                    + "-"
                    + a_2set
                    + " "
                    + h_3set
                    + "-"
                    + a_3set
                    + " "
                    + h_4set
                    + "-"
                    + a_4set
                )
            elif h_3set != "" and a_3set != "":
                score = (
                    h_1set
                    + "-"
                    + a_1set
                    + " "
                    + h_2set
                    + "-"
                    + a_2set
                    + " "
                    + h_3set
                    + "-"
                    + a_3set
                )
            elif h_2set != "" and a_2set != "":
                score = h_1set + "-" + a_1set + " " + h_2set + "-" + a_2set
            elif h_1set != "" and a_1set != "":
                score = h_1set + "-" + a_1set
        else:
            if h_5set != "" and a_5set != "":
                score = (
                    a_1set
                    + "-"
                    + h_1set
                    + " "
                    + a_2set
                    + "-"
                    + h_2set
                    + " "
                    + a_3set
                    + "-"
                    + h_3set
                    + " "
                    + a_4set
                    + "-"
                    + h_4set
                    + " "
                    + a_5set
                    + "-"
                    + h_5set
                )
            elif h_4set != "" and a_4set != "":
                score = (
                    a_1set
                    + "-"
                    + h_1set
                    + " "
                    + a_2set
                    + "-"
                    + h_2set
                    + " "
                    + a_3set
                    + "-"
                    + h_3set
                    + " "
                    + a_4set
                    + "-"
                    + h_4set
                )
            elif h_3set != "" and a_3set != "":
                score = (
                    a_1set
                    + "-"
                    + h_1set
                    + " "
                    + a_2set
                    + "-"
                    + h_2set
                    + " "
                    + a_3set
                    + "-"
                    + h_3set
                )
            elif h_2set != "" and a_2set != "":
                score = a_1set + "-" + h_1set + " " + a_2set + "-" + h_2set
            elif h_1set != "" and a_1set != "":
                score = a_1set + "-" + h_1set

        time_total = soup.find("div", class_="smh__time smh__time--overall").text
        time_total = int(time_total.split(":")[0]) * 60 + int(
            time_total.split(":")[1]
        )  # Dato

        time_1s = soup.find("div", class_="smh__time smh__time--0")
        if h_1set != "" and a_1set != "" and time_1s != None:
            time_1s = int(time_1s.text.split(":")[0]) * 60 + int(
                time_1s.text.split(":")[1]
            )  # Dato
        else:
            time_1s = 0

        time_2s = soup.find("div", class_="smh__time smh__time--1")
        if h_2set != "" and a_2set != "" and time_2s != None:
            time_2s = int(time_2s.text.split(":")[0]) * 60 + int(
                time_2s.text.split(":")[1]
            )  # Dato
        else:
            time_2s = 0

        time_3s = soup.find("div", class_="smh__time smh__time--2")
        if h_3set != "" and a_3set != "" and time_3s != None:
            time_3s = int(time_3s.text.split(":")[0]) * 60 + int(
                time_3s.text.split(":")[1]
            )  # Dato
        else:
            time_3s = 0

        time_4s = soup.find("div", class_="smh__time smh__time--3")
        if h_4set != "" and a_4set != "" and time_4s != None:
            time_4s = int(time_4s.text.split(":")[0]) * 60 + int(
                time_4s.text.split(":")[1]
            )  # Dato
        else:
            time_4s = 0

        time_5s = soup.find("div", class_="smh__time smh__time--4")
        if h_5set != "" and a_5set != "" and time_5s != None:
            time_5s = int(time_5s.text.split(":")[0]) * 60 + int(
                time_5s.text.split(":")[1]
            )  # Dato
        else:
            time_5s = 0

        # Defino algunas variables
        h_list = []
        a_list = []
        t_list = []
        h_1list = []
        a_1list = []
        t_1list = []
        h_2list = []
        a_2list = []
        t_2list = []
        h_3list = []
        a_3list = []
        t_3list = []
        h_4list = []
        a_4list = []
        t_4list = []
        h_5list = []
        a_5list = []
        t_5list = []

        # Open point by point
        pointbypoint = {}
        # order of service
        service_h = [
            "s-r",
            "r-s",
            "s-r",
            "r-s",
            "s-r",
            "r-s",
            "s-r",
            "r-s",
            "s-r",
            "r-s",
            "s-r",
            "r-s",
        ]
        service_a = [
            "r-s",
            "s-r",
            "r-s",
            "s-r",
            "r-s",
            "s-r",
            "r-s",
            "s-r",
            "r-s",
            "s-r",
            "r-s",
            "s-r",
        ]
        # Order of service - tiebreak
        service_h_tb = [
            "s-r",
            "r-s",
            "r-s",
            "s-r",
            "s-r",
            "r-s",
            "r-s",
            "s-r",
            "s-r",
            "r-s",
            "r-s",
            "s-r",
            "s-r",
            "r-s",
            "r-s",
            "s-r",
            "s-r",
            "r-s",
            "r-s",
            "s-r",
            "s-r",
            "r-s",
            "r-s",
            "s-r",
            "s-r",
            "r-s",
            "r-s",
            "s-r",
            "s-r",
            "r-s",
            "r-s",
            "s-r",
            "s-r",
            "r-s",
            "r-s",
            "s-r",
        ]
        service_a_tb = [
            "r-s",
            "s-r",
            "s-r",
            "r-s",
            "r-s",
            "s-r",
            "s-r",
            "r-s",
            "r-s",
            "s-r",
            "s-r",
            "r-s",
            "r-s",
            "s-r",
            "s-r",
            "r-s",
            "r-s",
            "s-r",
            "s-r",
            "r-s",
            "r-s",
            "s-r",
            "s-r",
            "r-s",
            "r-s",
            "s-r",
            "s-r",
            "r-s",
            "r-s",
            "s-r",
            "s-r",
            "r-s",
            "r-s",
            "s-r",
            "s-r",
            "r-s",
        ]

        tabs = soup.find(class_="filterOver filterOver--indent")
        if tabs != None and ("Stats" in tabs.text or "stats" in tabs.text):
            try:
                stats_button = driver.find_element(
                    By.XPATH, '//button[contains(text(), "Stats")]'
                )
                """stats_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[7]/div/a[2]')
                if stats_button.text.upper() != 'STATS':
                    stats_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[8]/div/a[2]')
                """
                driver.execute_script("arguments[0].click();", stats_button)
                driver.implicitly_wait(10)

                page_src = test_download(driver)
                if page_src is None:
                    exit()

                soup = BeautifulSoup(page_src, "lxml")

                # Statistics overall
                rows = soup.find_all("div", class_="wcl-row_2oCpS")

                for row in rows:
                    category = row.find("div", class_="wcl-category_Ydwqh")

                    # Valor local (puede tener strong solo o strong + span)
                    h_block = category.find(
                        "div", class_="wcl-value_XJG99 wcl-homeValue_3Q-7P"
                    )
                    h_strong = h_block.find("strong").text.strip() if h_block else ""
                    h_span = (
                        h_block.find("span").text.strip()
                        if h_block and h_block.find("span")
                        else ""
                    )
                    h_list.append(f"{h_strong} {h_span}".strip())

                    # Nombre de la estadística
                    t_block = category.find("div", class_="wcl-category_6sT1J")
                    t_text = t_block.find("strong").text.strip() if t_block else ""
                    t_list.append(t_text)

                    # Valor visitante (puede tener strong solo o strong + span)
                    a_block = category.find(
                        "div", class_="wcl-value_XJG99 wcl-awayValue_Y-QR1"
                    )
                    a_strong = a_block.find("strong").text.strip() if a_block else ""
                    a_span = (
                        a_block.find("span").text.strip()
                        if a_block and a_block.find("span")
                        else ""
                    )
                    a_list.append(f"{a_strong} {a_span}".strip())

            except Exception:
                print("stats total problem")
            try:
                # First set statistics

                if h_1set != "" and a_1set != "" and h_2set != "" and a_2set != "":
                    # open first set stats
                    stats_button = driver.find_element(
                        By.XPATH, '//button[contains(text(), "Set 1")]'
                    )
                    """if stats_button.text.upper() == 'SET 1':
                        driver.execute_script('arguments[0].click();', stats_button)
                        driver.implicitly_wait(10)  
                    else:
                        stats_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[9]/div/a[2]/button')"""

                    driver.execute_script("arguments[0].click();", stats_button)
                    driver.implicitly_wait(10)

                    soup = BeautifulSoup(driver.page_source, "lxml")
                    rows = soup.find_all("div", class_="wcl-row_2oCpS")

                    for row in rows:
                        category = row.find("div", class_="wcl-category_Ydwqh")

                        # Valor local (puede tener strong solo o strong + span)
                        h_block = category.find(
                            "div", class_="wcl-value_XJG99 wcl-homeValue_3Q-7P"
                        )
                        h_strong = (
                            h_block.find("strong").text.strip() if h_block else ""
                        )
                        h_span = (
                            h_block.find("span").text.strip()
                            if h_block and h_block.find("span")
                            else ""
                        )
                        h_1list.append(f"{h_strong} {h_span}".strip())

                        # Nombre de la estadística
                        t_block = category.find("div", class_="wcl-category_6sT1J")
                        t_text = t_block.find("strong").text.strip() if t_block else ""
                        t_1list.append(t_text)

                        # Valor visitante (puede tener strong solo o strong + span)
                        a_block = category.find(
                            "div", class_="wcl-value_XJG99 wcl-awayValue_Y-QR1"
                        )
                        a_strong = (
                            a_block.find("strong").text.strip() if a_block else ""
                        )
                        a_span = (
                            a_block.find("span").text.strip()
                            if a_block and a_block.find("span")
                            else ""
                        )
                        a_1list.append(f"{a_strong} {a_span}".strip())
                else:
                    h_1list = [0] * len(t_list)
                    a_1list = [0] * len(t_list)
                    t_1list = t_list.copy()

                # Second set statistics
                if h_2set != "" and a_2set != "":
                    # open first set stats
                    # try:
                    stats_button = driver.find_element(
                        By.XPATH, '//button[contains(text(), "Set 2")]'
                    )
                    """if stats_button.text.upper() == 'SET 2':
                            driver.execute_script('arguments[0].click();', stats_button)
                        else:
                            stats_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[9]/div/a[3]/button')
                            driver.execute_script('arguments[0].click();', stats_button)
                            driver.implicitly_wait(10)
                    except:
                        stats_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[9]/div/a[3]/button')"""
                    driver.execute_script("arguments[0].click();", stats_button)
                    driver.implicitly_wait(10)

                    soup = BeautifulSoup(driver.page_source, "lxml")
                    rows = soup.find_all("div", class_="wcl-row_2oCpS")

                    for row in rows:
                        category = row.find("div", class_="wcl-category_Ydwqh")

                        # Valor local (puede tener strong solo o strong + span)
                        h_block = category.find(
                            "div", class_="wcl-value_XJG99 wcl-homeValue_3Q-7P"
                        )
                        h_strong = (
                            h_block.find("strong").text.strip() if h_block else ""
                        )
                        h_span = (
                            h_block.find("span").text.strip()
                            if h_block and h_block.find("span")
                            else ""
                        )
                        h_2list.append(f"{h_strong} {h_span}".strip())

                        # Nombre de la estadística
                        t_block = category.find("div", class_="wcl-category_6sT1J")
                        t_text = t_block.find("strong").text.strip() if t_block else ""
                        t_2list.append(t_text)

                        # Valor visitante (puede tener strong solo o strong + span)
                        a_block = category.find(
                            "div", class_="wcl-value_XJG99 wcl-awayValue_Y-QR1"
                        )
                        a_strong = (
                            a_block.find("strong").text.strip() if a_block else ""
                        )
                        a_span = (
                            a_block.find("span").text.strip()
                            if a_block and a_block.find("span")
                            else ""
                        )
                        a_2list.append(f"{a_strong} {a_span}".strip())
                else:
                    h_2list = [0] * len(t_list)
                    a_2list = [0] * len(t_list)
                    t_2list = t_list.copy()

                # Third set statistics
                if h_3set != "" and a_3set != "":
                    # open first set stats
                    # try:
                    stats_button = driver.find_element(
                        By.XPATH, '//button[contains(text(), "Set 3")]'
                    )
                    """if stats_button.text.upper() == 'SET 3':
                            driver.execute_script('arguments[0].click();', stats_button)
                            driver.implicitly_wait(10)  
                        else:
                            stats_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[9]/div/a[4]/button')
                            driver.execute_script('arguments[0].click();', stats_button)
                            driver.implicitly_wait(10)
                    except:
                        stats_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[9]/div/a[4]/button')"""
                    driver.execute_script("arguments[0].click();", stats_button)
                    driver.implicitly_wait(10)
                    soup = BeautifulSoup(driver.page_source, "lxml")
                    rows = soup.find_all("div", class_="wcl-row_2oCpS")

                    for row in rows:
                        category = row.find("div", class_="wcl-category_Ydwqh")

                        # Valor local (puede tener strong solo o strong + span)
                        h_block = category.find(
                            "div", class_="wcl-value_XJG99 wcl-homeValue_3Q-7P"
                        )
                        h_strong = (
                            h_block.find("strong").text.strip() if h_block else ""
                        )
                        h_span = (
                            h_block.find("span").text.strip()
                            if h_block and h_block.find("span")
                            else ""
                        )
                        h_3list.append(f"{h_strong} {h_span}".strip())

                        # Nombre de la estadística
                        t_block = category.find("div", class_="wcl-category_6sT1J")
                        t_text = t_block.find("strong").text.strip() if t_block else ""
                        t_3list.append(t_text)

                        # Valor visitante (puede tener strong solo o strong + span)
                        a_block = category.find(
                            "div", class_="wcl-value_XJG99 wcl-awayValue_Y-QR1"
                        )
                        a_strong = (
                            a_block.find("strong").text.strip() if a_block else ""
                        )
                        a_span = (
                            a_block.find("span").text.strip()
                            if a_block and a_block.find("span")
                            else ""
                        )
                        a_3list.append(f"{a_strong} {a_span}".strip())
                else:
                    h_3list = [0] * len(t_list)
                    a_3list = [0] * len(t_list)
                    t_3list = t_list.copy()

                # Fourth set statistics
                if h_4set != "" and a_4set != "":
                    # open first set stats
                    # try:
                    stats_button = driver.find_element(
                        By.XPATH, '//button[contains(text(), "Set 4")]'
                    )
                    """if stats_button.text.upper() == 'SET 4':
                            driver.execute_script('arguments[0].click();', stats_button)
                            driver.implicitly_wait(10)  
                        else:
                            stats_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[9]/div/a[5]/button')
                            driver.execute_script('arguments[0].click();', stats_button)
                            driver.implicitly_wait(10)
                    except:
                        stats_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[9]/div/a[5]/button')"""
                    driver.execute_script("arguments[0].click();", stats_button)
                    driver.implicitly_wait(10)

                    soup = BeautifulSoup(driver.page_source, "lxml")
                    rows = soup.find_all("div", class_="wcl-row_2oCpS")

                    for row in rows:
                        category = row.find("div", class_="wcl-category_Ydwqh")

                        # Valor local (puede tener strong solo o strong + span)
                        h_block = category.find(
                            "div", class_="wcl-value_XJG99 wcl-homeValue_3Q-7P"
                        )
                        h_strong = (
                            h_block.find("strong").text.strip() if h_block else ""
                        )
                        h_span = (
                            h_block.find("span").text.strip()
                            if h_block and h_block.find("span")
                            else ""
                        )
                        h_4list.append(f"{h_strong} {h_span}".strip())

                        # Nombre de la estadística
                        t_block = category.find("div", class_="wcl-category_6sT1J")
                        t_text = t_block.find("strong").text.strip() if t_block else ""
                        t_4list.append(t_text)

                        # Valor visitante (puede tener strong solo o strong + span)
                        a_block = category.find(
                            "div", class_="wcl-value_XJG99 wcl-awayValue_Y-QR1"
                        )
                        a_strong = (
                            a_block.find("strong").text.strip() if a_block else ""
                        )
                        a_span = (
                            a_block.find("span").text.strip()
                            if a_block and a_block.find("span")
                            else ""
                        )
                        a_4list.append(f"{a_strong} {a_span}".strip())
                else:
                    h_4list = [0] * len(t_list)
                    a_4list = [0] * len(t_list)
                    t_4list = t_list.copy()

                # Fifth set statistics
                if h_5set != "" and a_5set != "":
                    # open first set stats
                    # try:
                    stats_button = driver.find_element(
                        By.XPATH, '//button[contains(text(), "Set 5")]'
                    )
                    """if stats_button.text.upper() == 'SET 5':
                            driver.execute_script('arguments[0].click();', stats_button)
                            driver.implicitly_wait(10)  
                        else:
                            stats_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[9]/div/a[6]/button')
                            driver.execute_script('arguments[0].click();', stats_button)
                            driver.implicitly_wait(10)
                    except:
                        stats_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[9]/div/a[6]/button')"""
                    driver.execute_script("arguments[0].click();", stats_button)
                    driver.implicitly_wait(10)

                    soup = BeautifulSoup(driver.page_source, "lxml")
                    rows = soup.find_all("div", class_="wcl-row_2oCpS")

                    for row in rows:
                        category = row.find("div", class_="wcl-category_Ydwqh")

                        # Valor local (puede tener strong solo o strong + span)
                        h_block = category.find(
                            "div", class_="wcl-value_XJG99 wcl-homeValue_3Q-7P"
                        )
                        h_strong = (
                            h_block.find("strong").text.strip() if h_block else ""
                        )
                        h_span = (
                            h_block.find("span").text.strip()
                            if h_block and h_block.find("span")
                            else ""
                        )
                        h_5list.append(f"{h_strong} {h_span}".strip())

                        # Nombre de la estadística
                        t_block = category.find("div", class_="wcl-category_6sT1J")
                        t_text = t_block.find("strong").text.strip() if t_block else ""
                        t_5list.append(t_text)

                        # Valor visitante (puede tener strong solo o strong + span)
                        a_block = category.find(
                            "div", class_="wcl-value_XJG99 wcl-awayValue_Y-QR1"
                        )
                        a_strong = (
                            a_block.find("strong").text.strip() if a_block else ""
                        )
                        a_span = (
                            a_block.find("span").text.strip()
                            if a_block and a_block.find("span")
                            else ""
                        )
                        a_5list.append(f"{a_strong} {a_span}".strip())
                else:
                    h_5list = [0] * len(t_list)
                    a_5list = [0] * len(t_list)
                    t_5list = t_list.copy()

            except Exception:
                print("stats sets problem")

        if tabs != None and ("point" in tabs.text or "Point" in tabs.text):
            if "Stats" in tabs.text or "stats" in tabs.text:
                option_botton = "3"
            else:
                option_botton = "2"
            try:
                if h_1set != "" and a_1set != "":
                    points_button = driver.find_element(
                        By.XPATH, '//button[contains(text(), "Point by Point")]'
                    )
                    """if points_button.text.upper() != 'POINT BY POINT':
                        points_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[8]/div/a[' + option_botton + ']/button')"""
                    driver.execute_script("arguments[0].click();", points_button)
                    driver.implicitly_wait(10)

                    page_src = test_download(driver)
                    if page_src is None:
                        exit()

                    soup = BeautifulSoup(page_src, "lxml")
                    points = soup.find_all("div", class_="matchHistoryRowWrapper")
                    games = points[0].find_all(class_="matchHistoryRow__scoreBox")
                    fifteens = points[0].find_all(class_="matchHistoryRow__fifteens")
                    service = points[0].find_all(class_="matchHistoryRow__servis")
                    pointbypoint["1set"] = {}
                    tiebreak = ""
                    i = 0
                    for game in games:
                        if i < 12:
                            pointbypoint["1set"][game.text] = str(fifteens[i].text)
                            # if == 1 is serving player, if is == 0 is recived player
                            if len(service[0]) == 1:
                                pointbypoint["1set"]["service"] = service_h[: i + 1]
                            else:
                                pointbypoint["1set"]["service"] = service_a[: i + 1]
                            i += 1
                        else:
                            for j in range(13, len(games)):
                                tiebreak = tiebreak + games[j].text + ", "
                            tiebreak = tiebreak[0:-2]
                            pointbypoint["1set"]["tiebreak"] = tiebreak
                            if len(service[0]) == 1:
                                pointbypoint["1set"]["service"] = (
                                    pointbypoint["1set"]["service"]
                                    + service_h_tb[: len(games) - 13]
                                )
                            else:
                                pointbypoint["1set"]["service"] = (
                                    pointbypoint["1set"]["service"]
                                    + service_a_tb[: len(games) - 13]
                                )
                            break
                if h_2set != "" and a_2set != "" and (h_2set != "0" or a_2set != "0"):
                    # try:
                    points_button = driver.find_element(
                        By.XPATH, '//button[contains(text(), "Set 2")]'
                    )
                    """if points_button.text.upper() == 'SET 2':
                            driver.execute_script('arguments[0].click();', points_button)
                            driver.implicitly_wait(10)  
                        else:
                            points_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[9]/div/a[2]/button')
                            driver.execute_script('arguments[0].click();', points_button)
                            driver.implicitly_wait(10)
                    except:
                        points_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[9]/div/a[2]/button')"""
                    driver.execute_script("arguments[0].click();", points_button)
                    driver.implicitly_wait(10)

                    soup = BeautifulSoup(driver.page_source, "lxml")
                    points = soup.find_all("div", class_="matchHistoryRowWrapper")
                    games = points[0].find_all(class_="matchHistoryRow__scoreBox")
                    fifteens = points[0].find_all(class_="matchHistoryRow__fifteens")

                    service = points[0].find_all(class_="matchHistoryRow__servis")

                    pointbypoint["2set"] = {}
                    tiebreak = ""
                    i = 0
                    for game in games:
                        if i < 12:
                            pointbypoint["2set"][game.text] = str(fifteens[i].text)

                            if len(service[0]) == 1:
                                pointbypoint["2set"]["service"] = service_h[: i + 1]
                            else:
                                pointbypoint["2set"]["service"] = service_a[: i + 1]
                            i += 1
                        else:
                            for j in range(13, len(games)):
                                tiebreak = tiebreak + games[j].text + ", "
                            tiebreak = tiebreak[0:-2]
                            pointbypoint["2set"]["tiebreak"] = tiebreak
                            if len(service[0]) == 1:
                                pointbypoint["2set"]["service"] = (
                                    pointbypoint["2set"]["service"]
                                    + service_h_tb[: len(games) - 13]
                                )
                            else:
                                pointbypoint["2set"]["service"] = (
                                    pointbypoint["2set"]["service"]
                                    + service_a_tb[: len(games) - 13]
                                )
                            break

                if h_3set != "" and a_3set != "" and (h_3set != "0" or a_3set != "0"):
                    # try:
                    points_button = driver.find_element(
                        By.XPATH, '//button[contains(text(), "Set 3")]'
                    )
                    """if points_button.text.upper() == 'SET 3':
                            driver.execute_script('arguments[0].click();', points_button)
                            driver.implicitly_wait(10)  
                        else:
                            points_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[9]/div/a[3]/button')
                            driver.execute_script('arguments[0].click();', points_button)
                            driver.implicitly_wait(10)
                    except:
                        points_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[9]/div/a[3]/button')"""
                    driver.execute_script("arguments[0].click();", points_button)
                    driver.implicitly_wait(10)

                    soup = BeautifulSoup(driver.page_source, "lxml")
                    points = soup.find_all("div", class_="matchHistoryRowWrapper")
                    games = points[0].find_all(class_="matchHistoryRow__scoreBox")
                    fifteens = points[0].find_all(class_="matchHistoryRow__fifteens")

                    service = points[0].find_all(class_="matchHistoryRow__servis")

                    pointbypoint["3set"] = {}
                    tiebreak = ""
                    i = 0
                    for game in games:
                        if i < 12:
                            pointbypoint["3set"][game.text] = str(fifteens[i].text)

                            if len(service[0]) == 1:
                                pointbypoint["3set"]["service"] = service_h[: i + 1]
                            else:
                                pointbypoint["3set"]["service"] = service_a[: i + 1]
                            i += 1
                        else:
                            for j in range(13, len(games)):
                                tiebreak = tiebreak + games[j].text + ", "
                            tiebreak = tiebreak[0:-2]
                            pointbypoint["3set"]["tiebreak"] = tiebreak
                            if len(service[0]) == 1:
                                pointbypoint["3set"]["service"] = (
                                    pointbypoint["3set"]["service"]
                                    + service_h_tb[: len(games) - 13]
                                )
                            else:
                                pointbypoint["3set"]["service"] = (
                                    pointbypoint["3set"]["service"]
                                    + service_a_tb[: len(games) - 13]
                                )
                            break

                if h_4set != "" and a_4set != "" and (h_4set != "0" or a_4set != "0"):
                    # try:

                    points_button = driver.find_element(
                        By.XPATH, '//button[contains(text(), "Set 4")]'
                    )
                    """if points_button.text.upper() == 'SET 4':
                            driver.execute_script('arguments[0].click();', points_button)
                            driver.implicitly_wait(10)  
                        else:
                            points_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[9]/div/a[4]/button')
                            driver.execute_script('arguments[0].click();', points_button)
                            driver.implicitly_wait(10)
                    except:
                        points_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[9]/div/a[4]/button')"""
                    driver.execute_script("arguments[0].click();", points_button)
                    driver.implicitly_wait(10)

                    soup = BeautifulSoup(driver.page_source, "lxml")
                    points = soup.find_all("div", class_="matchHistoryRowWrapper")
                    games = points[0].find_all(class_="matchHistoryRow__scoreBox")
                    fifteens = points[0].find_all(class_="matchHistoryRow__fifteens")

                    service = points[0].find_all(class_="matchHistoryRow__servis")

                    pointbypoint["4set"] = {}
                    tiebreak = ""
                    i = 0
                    for game in games:
                        if i < 12:
                            pointbypoint["4set"][game.text] = str(fifteens[i].text)

                            if len(service[0]) == 1:
                                pointbypoint["4set"]["service"] = service_h[: i + 1]
                            else:
                                pointbypoint["4set"]["service"] = service_a[: i + 1]
                            i += 1
                        else:
                            for j in range(13, len(games)):
                                tiebreak = tiebreak + games[j].text + ", "
                            tiebreak = tiebreak[0:-2]
                            pointbypoint["4set"]["tiebreak"] = tiebreak
                            if len(service[0]) == 1:
                                pointbypoint["4set"]["service"] = (
                                    pointbypoint["4set"]["service"]
                                    + service_h_tb[: len(games) - 13]
                                )
                            else:
                                pointbypoint["4set"]["service"] = (
                                    pointbypoint["4set"]["service"]
                                    + service_a_tb[: len(games) - 13]
                                )
                            break

                if h_5set != "" and a_5set != "" and (h_5set != "0" or a_5set != "0"):
                    # try:
                    points_button = driver.find_element(
                        By.XPATH, '//button[contains(text(), "Set 5")]'
                    )
                    """if points_button.text.upper() == 'SET 5':
                            driver.execute_script('arguments[0].click();', points_button)
                            driver.implicitly_wait(10)  
                        else:
                            points_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[9]/div/a[5]/button')
                            driver.execute_script('arguments[0].click();', points_button)
                            driver.implicitly_wait(10)
                    except:
                        points_button = driver.find_element(By.XPATH, '//*[@id="detail"]/div[9]/div/a[5]/button')"""
                    driver.execute_script("arguments[0].click();", points_button)
                    driver.implicitly_wait(10)

                    soup = BeautifulSoup(driver.page_source, "lxml")
                    points = soup.find_all("div", class_="matchHistoryRowWrapper")
                    games = points[0].find_all(class_="matchHistoryRow__scoreBox")
                    fifteens = points[0].find_all(class_="matchHistoryRow__fifteens")

                    service = points[0].find_all(class_="matchHistoryRow__servis")

                    pointbypoint["5set"] = {}
                    tiebreak = ""
                    i = 0
                    for game in games:
                        if i < 12:
                            pointbypoint["5set"][game.text] = str(fifteens[i].text)

                            if len(service[0]) == 1:
                                pointbypoint["5set"]["service"] = service_h[: i + 1]
                            else:
                                pointbypoint["5set"]["service"] = service_a[: i + 1]
                            i += 1
                        else:
                            for j in range(13, len(games)):
                                tiebreak = tiebreak + games[j].text + ", "
                            tiebreak = tiebreak[0:-2]
                            pointbypoint["5set"]["tiebreak"] = tiebreak
                            if len(service[0]) == 1:
                                pointbypoint["5set"]["service"] = (
                                    pointbypoint["5set"]["service"]
                                    + service_h_tb[: len(games) - 13]
                                )
                            else:
                                pointbypoint["5set"]["service"] = (
                                    pointbypoint["5set"]["service"]
                                    + service_a_tb[: len(games) - 13]
                                )
                            break

            except Exception:
                print("Problem with point by point")
        else:
            driver.close()
            driver.quit()

        if winner == "home":
            elements = [
                tourney_level,
                tourney_name,
                country,
                surface,
                round_match,
                date_match,
                h_player,
                h_nac,
                h_seed,
                a_player,
                a_nac,
                a_seed,
                h_list,
                h_1list,
                h_2list,
                h_3list,
                h_4list,
                h_5list,
                a_list,
                a_1list,
                a_2list,
                a_3list,
                a_4list,
                a_5list,
                timestart,
                score,
                status,
                best,
                time_total,
                time_1s,
                time_2s,
                time_3s,
                time_4s,
                time_5s,
                t_list,
                t_1list,
                t_2list,
                t_3list,
                t_4list,
                t_5list,
                pointbypoint,
                anotations,
                winner,
            ]
        else:
            elements = [
                tourney_level,
                tourney_name,
                country,
                surface,
                round_match,
                date_match,
                a_player,
                a_nac,
                a_seed,
                h_player,
                h_nac,
                h_seed,
                a_list,
                a_1list,
                a_2list,
                a_3list,
                a_4list,
                a_5list,
                h_list,
                h_1list,
                h_2list,
                h_3list,
                h_4list,
                h_5list,
                timestart,
                score,
                status,
                best,
                time_total,
                time_1s,
                time_2s,
                time_3s,
                time_4s,
                time_5s,
                t_list,
                t_1list,
                t_2list,
                t_3list,
                t_4list,
                t_5list,
                pointbypoint,
                anotations,
                winner,
            ]
    name_file = (
        str(id)
        + "_"
        + tourney_name
        + "_"
        + str(date_match)[:-4]
        + "_"
        + h_player
        + "_"
        + a_player
        + "_"
        + datetime.now().strftime("%H:%M:%S").replace(":", "")
        + ".csv"
    )
    data_simple = pd.DataFrame(elements[:12] + elements[24:34] + elements[-2:]).T
    d_simple_check = "SI"
    data_simple.to_csv(
        "/Users/Paula/Documents/TennisData/TennisData/FS_matches/"
        + year_scrap
        + "/simple/"
        + name_file,
        index=False,
        header=None,
    )
    print("Se guardo data_simple de " + tourney_name + " " + h_player + "_" + a_player)
    # arranca stats
    if status.lower() == "walkover":
        data_stat_wo = {"w_t_Aces": ["WO"], "l_t_Aces": ["WO"]}
        df_data_stat = pd.DataFrame(data_stat_wo)
    else:
        labels_t = elements[34]
        labels_t = ["t_" + label for label in labels_t]

        labels_1 = elements[35]
        labels_1 = ["1_" + label for label in labels_1]

        labels_2 = elements[36]
        labels_2 = ["2_" + label for label in labels_2]

        labels_3 = elements[37]
        labels_3 = ["3_" + label for label in labels_3]

        labels_4 = elements[38]
        labels_4 = ["4_" + label for label in labels_4]

        labels_5 = elements[39]
        labels_5 = ["5_" + label for label in labels_5]

        labels_concat = labels_t + labels_1 + labels_2 + labels_3 + labels_4 + labels_5

        labels_concat_double = ["w_" + label for label in labels_concat] + [
            "l_" + label for label in labels_concat
        ]

        values = elements[12:24]
        values_concat = []
        for sublist in values:
            values_concat.extend(sublist)

        df_data_stat = pd.DataFrame(columns=labels_concat_double)
        df_data_stat.loc[0] = values_concat
    d_stat_check = "SI"
    df_data_stat.to_csv(
        "/Users/Paula/Documents/TennisData/TennisData/FS_matches/"
        + year_scrap
        + "/stats/"
        + name_file,
        index=False,
        header=True,
    )
    print("Se guardo data_stat de " + tourney_name + " " + h_player + "_" + a_player)
    # arranca pbyp
    if status.lower() == "walkover":
        data_pbyp_wo = {
            "Columna1": ["WO"],
            "Columna2": [None],
            "Columna3": [None],
            "Columna4": [None],
            "Columna5": [None],
            "Columna6": [None],
        }
        pbyp = pd.DataFrame(data_pbyp_wo)
    else:
        point_by_point = elements[40]
        pbyp = pd.DataFrame()
        tiebreak = ""
        set_anterior = ""
        indice = 1
        final_game = ""
        for valor in point_by_point.values():
            service = valor.pop("service", [])
            if elements[-1] == "home":
                df_servicio = pd.DataFrame(service, columns=["Servicio"])
                # Dividir los elementos en las columnas "recibe" y "saca"
                df_servicio[["home", "away"]] = df_servicio["Servicio"].str.split(
                    "-", expand=True
                )
                df_servicio = df_servicio.drop("Servicio", axis=1)
                # Reemplazar los valores 'r' por 'home' y 's' por 'away'
                df_servicio.replace({"r": "home", "s": "away"}, inplace=True)
                # Cambiar los nombres de las columnas
                df_servicio.rename(columns={"home": "r", "away": "s"}, inplace=True)

                # Reemplazar 'r' por "recibidor" en la columna "recibe"
                df_servicio["r"] = df_servicio["r"].replace("home", elements[6])
                df_servicio["r"] = df_servicio["r"].replace("away", elements[9])
                df_servicio["s"] = df_servicio["s"].replace("home", elements[6])
                df_servicio["s"] = df_servicio["s"].replace("away", elements[9])
            else:
                df_servicio = pd.DataFrame(service, columns=["Servicio"])
                # Dividir los elementos en las columnas "recibe" y "saca"
                df_servicio[["home", "away"]] = df_servicio["Servicio"].str.split(
                    "-", expand=True
                )
                df_servicio = df_servicio.drop("Servicio", axis=1)
                # Reemplazar los valores 'r' por 'home' y 's' por 'away'
                df_servicio.replace({"r": "home", "s": "away"}, inplace=True)
                # Cambiar los nombres de las columnas
                df_servicio.rename(columns={"home": "r", "away": "s"}, inplace=True)

                # Reemplazar 'r' por "recibidor" en la columna "recibe"
                df_servicio["r"] = df_servicio["r"].replace("home", elements[9])
                df_servicio["r"] = df_servicio["r"].replace("away", elements[6])
                df_servicio["s"] = df_servicio["s"].replace("home", elements[9])
                df_servicio["s"] = df_servicio["s"].replace("away", elements[6])

            try:
                tiebreak = valor.pop("tiebreak", [])
            except Exception:
                continue

            df_aux = pd.DataFrame.from_dict(
                valor, orient="index", columns=["MatchScore"]
            )
            df_aux["GameScore"] = df_aux["MatchScore"].str.split(", ")
            df_aux.reset_index(drop=True, inplace=True)
            df_servicio = pd.concat([df_aux, df_servicio], axis=1)
            df_servicio["GameScore"] = df_servicio["MatchScore"].str.split(", ")
            df_servicio = df_servicio.explode("GameScore")

            df = pd.DataFrame.from_dict(valor, orient="index", columns=["MatchScore"])
            df["GameScore"] = df["MatchScore"].str.split(", ")
            df = df.explode("GameScore")
            match_score = df.index.tolist()
            df.reset_index(drop=True, inplace=True)

            df_games = pd.DataFrame({"games": match_score})

            # Calcular la columna "cambios"
            df_games["cambios"] = (
                df_games["games"] != df_games["games"].shift()
            ).cumsum()
            df_games["new_games"] = df_games["games"].where(
                df_games["cambios"] != 1, "0-0"
            )

            filtered_df = df_games.drop_duplicates(["games", "cambios"])

            for index, row in df_games.iterrows():
                indice = row["cambios"] - 1
                matches = filtered_df.loc[filtered_df["cambios"] == indice, "games"]
                if len(matches) > 0:
                    df_games.at[index, "new_games"] = matches.values[0]
            new_rows = []

            df_servicio = pd.concat([df_aux, df_servicio], axis=1)

            if indice == 1:
                set_anterior = ""
            else:
                set_anterior = set_anterior + final_game + " "

            # Restablecer los índices de los dataframes
            df_games.reset_index(drop=True, inplace=True)
            df_servicio.reset_index(drop=True, inplace=True)

            # Seleccionar las columnas 'r' y 's' de df_servicio
            df_servicio_selected = df_servicio[["r", "s"]]

            # Concatenar los dataframes
            df_combined = pd.concat([df_games, df_servicio_selected], axis=1)

            final_game = df_games["games"][len(df_games["games"]) - 1]
            new_rows = pd.DataFrame({"MatchScore": [final_game], "GameScore": [None]})
            df["MatchScore"] = df_combined["new_games"]
            df["Recibe"] = df_combined["r"]
            df["Saca"] = df_combined["s"]
            df = pd.concat([df, new_rows], ignore_index=True)

            indice = 2
            # Nuevo DataFrame con las filas adicionales
            new_rows = []
            previous_match_score = None

            # Recorrer filas del DataFrame original
            for _, row in df.iterrows():
                match_score = row["MatchScore"]
                # game_score = row['GameScore']

                if match_score != previous_match_score:
                    next_row_index = _ + 1
                    if next_row_index < len(df):
                        next_row = df.loc[next_row_index]
                        new_row = {
                            "MatchScore": next_row["MatchScore"],
                            "GameScore": "0:0",
                        }
                        new_rows.append(new_row)

                new_rows.append(row)
                previous_match_score = match_score

            # Crear el nuevo DataFrame con las filas agregadas
            new_df = pd.DataFrame(new_rows)
            new_df["MatchScore"] = set_anterior + new_df["MatchScore"]
            pbyp = pd.concat([pbyp, new_df], ignore_index=True)
            if len(tiebreak) > 0:
                tiebreak = tiebreak.replace("-", ":")
                tiebreak = tiebreak.split(",")
                puntos = len(tiebreak)
                tiebreak = [i.lstrip() for i in tiebreak]
                tiebreak = [i.rstrip() for i in tiebreak]
                tiebreak = ["0:0"] + tiebreak
                tiebreak = list(OrderedDict.fromkeys(tiebreak))
                new_tb_df = pd.DataFrame(
                    {
                        "MatchScore": [set_anterior + "6-6"] * len(tiebreak),
                        "GameScore": tiebreak,
                    }
                )
                df_servicio_selected_last = df_servicio_selected.tail(puntos)
                df_servicio_selected_last.reset_index(drop=True, inplace=True)
                new_tb_df.reset_index(drop=True, inplace=True)
                # Concatenar los dataframes
                new_tb_df = pd.concat([new_tb_df, df_servicio_selected_last], axis=1)
                new_tb_df = new_tb_df.rename(
                    columns={
                        "MatchScore": "MatchScore",
                        "GameScore": "GameScore",
                        "r": "Recibe",
                        "s": "Saca",
                    }
                )
                last_game_score = new_tb_df["GameScore"][
                    len(new_tb_df["GameScore"]) - 1
                ].split(":")
                if last_game_score[0] > last_game_score[1]:
                    final_game = "7-6"

                else:
                    final_game = "6-7"
                pbyp = pd.concat([pbyp, new_tb_df], ignore_index=True)

        try:
            pbyp = pbyp.fillna("0:0")
            pbyp["MatchScore"] = pbyp["MatchScore"].str.lstrip()
            pbyp["BreakPoint"] = pbyp["GameScore"].apply(
                lambda x: 1 if x.endswith(("BP", "BPSP")) else 0
            )
            pbyp["MatchPoint"] = pbyp["GameScore"].apply(
                lambda x: 1 if x.endswith(("MP")) else 0
            )
            pbyp["GameScore"] = (
                pbyp["GameScore"]
                .str.replace("BP", "")
                .str.replace("SP", "")
                .str.replace("MP", "")
            )
        except Exception:
            pbyp = {}

        if elements[-1] == "away":
            try:
                pbyp["MatchScore"] = pbyp["MatchScore"].apply(
                    lambda x: " ".join([score[::-1] for score in x.split(" ")])
                )
                pbyp["GameScore"] = (
                    pbyp["GameScore"].str.split(":").apply(lambda x: x[1] + ":" + x[0])
                )
            except Exception:
                pbyp = {}

        try:
            for indice, valor in pbyp["MatchScore"].items():
                if (
                    valor[-3:] == "6-6"
                    and pbyp.at[indice, "GameScore"] == "0:0"
                    and pbyp.at[indice, "Recibe"] == "0:0"
                ):
                    pbyp.drop(indice, inplace=True)
                elif (
                    valor[-3:] == "6-6"
                    and pbyp.at[indice, "GameScore"] != "0:0"
                    and pbyp.at[indice, "Recibe"] == "0:0"
                ):
                    pbyp.at[indice, "Saca"] = "Fin tiebreak"
                    pbyp.at[indice, "Recibe"] = "Fin tiebreak"
            for indice, valor in pbyp["Recibe"].items():
                if valor == "0:0" and len(pbyp) > indice + 1:
                    pbyp.at[indice, "Recibe"] = pbyp.at[indice + 1, "Recibe"]
            for indice, valor in pbyp["Saca"].items():
                if valor == "0:0" and len(pbyp) > indice + 1:
                    pbyp.at[indice, "Saca"] = pbyp.at[indice + 1, "Saca"]
            for indice, valor in pbyp["Recibe"].items():
                if valor == "0:0" and len(pbyp) > indice + 1:
                    pbyp.drop(indice, inplace=True)

            pbyp = pbyp.reset_index(drop=True)
            pbyp.at[len(pbyp) - 1, "Recibe"] = "Fin partido"
            pbyp.at[len(pbyp) - 1, "Saca"] = "Fin partido"
        except Exception:
            pbyp = {}

    d_pbyp_check = "SI"
    pbyp.to_csv(
        "/Users/Paula/Documents/TennisData/TennisData/FS_matches/"
        + year_scrap
        + "/pbyp/"
        + name_file,
        index=False,
        header=None,
    )
    print("Se guardo data_pbyp de " + tourney_name + " " + h_player + "_" + a_player)

    return round_match, h_player, a_player


os.chdir("/Users/paula/Documents/TennisData/TennisData/FS_matches/")


# Definí los 3 parámetros directamente
one_match = "https://www.flashscore.com/match/OSSeziWp/#/match-summary/match-summary"  # ejemplo de link de partido
id_tourney = "3043"  # id del torneo
year_scrap = "2025"  # año que quieras

try:
    d_round_match, d_h_player, d_a_player = scrap_match(
        one_match, id_tourney, year_scrap
    )

except Exception as e:
    print("❌ No se pudo leer el archivo")
    print(e)
