# -*- coding: utf-8 -*-
"""
Created on Wed Jul 19 16:10:06 2023

@author: Paula
"""

"""
Este script carga la lista de jugadores ATP creada por mi, levanta la de Jeff
y las compara, y si Jeff tiene nuevos jugadores o nuevos datos, actualizo mi
tabla. Y después de eso, revisa de mi tabla los datos faltantes y los chequea
con los jugadores de la ATP en la página oficial.
"""

import pandas as pd
import numpy as np
from scrap_players_atp import scrap_players_atp

# %% Levantar mi database de jugadores


# %% Levantar la database de Jeff
jeff_path = "/Users/paula/Documents/TennisData/TennisCodes/Players/ATP_players.csv"
jeff_players = pd.read_csv(jeff_path, low_memory=False, dtype={"dob": str})

# %% Levanto mis datos del archivo players.csv
players_path = "/Users/paula/Documents/TennisData/TennisCodes/Players/players.csv"
players = pd.read_csv(players_path, low_memory=False, dtype={"dob": str})


# %% Controlo si algun elemento de Jeff no esta en mi lista para buscarlo en ATP
# Iteración a través del DataFrame y obtención de los elementos de cada fila
jeffcito = 0
jeff_players = jeff_players[:]
jeff_players = jeff_players.dropna(subset=["name_first"])
jeff_players = jeff_players.dropna(subset=["name_last"])
for index, row in jeff_players.iterrows():
    jeffcito = jeffcito + 1
    nombre = row["name_first"]
    apellido = row["name_last"]
    if str(nombre) == "nan":
        nombre = ""
    # Verificar si existe alguna fila con first_name=nombre y last_name=apellido
    filtro = (players["first_name"] == nombre) & (players["last_name"] == apellido)
    existe_fila = players[filtro].shape[0] > 0

    if existe_fila:
        print("Existing player: " + str(nombre) + " " + str(apellido))
    else:
        print("Loading player: " + str(nombre) + " " + str(apellido))
        # new_player = scrap_players_atp(nombre, apellido)

        new_player = {
            "player_id": input("Ingrese player_id: "),
            "first_name": input("Ingrese first_name: "),
            "last_name": input("Ingrese last_name: "),
            "country": input("Ingrese country: "),
            "dob": input("Ingrese dob (YYYY-MM-DD): "),
            "turned_pro": input("Ingrese turned_pro (YYYY): "),
            "weight": input("Ingrese weight (en kg): "),
            "height": input("Ingrese height (en cm): "),
            "birth_city": input("Ingrese birth_city: "),
            "birth_country": input("Ingrese birth_country: "),
            "hand": input("Ingrese hand (left/right): "),
            "backhand": input("Ingrese backhand (one/two-handed): "),
            "coach": input("Ingrese coach: "),
        }
        if type(new_player) == str:
            if jeff_players.loc[index][3] == "R":
                hand = "right-handed"
            elif jeff_players.loc[index][3] == "L":
                hand = "left-handed"
            elif jeff_players.loc[index][3] == "A":
                hadn = "ambidextrous"
            else:
                hand = "unknown"
            if not np.isnan(jeff_players.loc[index][6]):
                height = int(jeff_players.loc[index][6])
            else:
                height = ""
            dob = jeff_players.loc[index][4]
            try:
                dob = int(dob)
            except:
                dob = ""
            new_player = {
                "player_id": "",
                "first_name": nombre,
                "last_name": apellido,
                "country": jeff_players.loc[index][5],
                "dob": dob,
                "turned_pro": "",
                "weight": "",
                "height": height,
                "birth_city": "",
                "birth_country": "",
                "hand": hand,
                "backhand": "unknown backhand",
                "coach": "",
            }
        else:
            if len(new_player["height"]) < 1 and not np.isnan(
                jeff_players.loc[index][6]
            ):
                new_player["height"] = int(jeff_players.loc[index][6])
        # Crear un DataFrame temporal a partir del diccionario
        df_new_player = pd.DataFrame([new_player])

        # Ahora, podemos agregar el DataFrame temporal al DataFrame principal
        players = pd.concat([players, df_new_player], ignore_index=True)

players.to_csv("players.csv", index=False)
