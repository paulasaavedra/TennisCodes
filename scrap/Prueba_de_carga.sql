select *
from atp_simple
where tourney_name like 'United Cup%'
    and date_match > "2024-05-01" -- corregir si cargo desde cero
UPDATE atp_simple
SET tourney_name = 'United Cup'
WHERE tourney_name like 'United Cup%'
    and date_match > "2024-05-01"
    AND tourney_name != 'United Cup';
UPDATE atp_simple
SET round_match = 'F'
WHERE w_player = 'Taylor Fritz'
    AND l_player = 'Hubert Hurkacz'
    AND tourney_name = 'United Cup'
    AND date_match > '2024-05-01';
UPDATE atp_simple
SET round_match = 'SF'
WHERE w_player = 'Taylor Fritz'
    AND l_player = 'Tomas Machac'
    AND tourney_name = 'United Cup'
    AND date_match > '2024-05-01';
UPDATE atp_simple
SET round_match = 'SF'
WHERE MATCH_ID = '2025_9900_090808';
UPDATE atp_simple
SET round_match = 'QF'
WHERE w_player = 'Tomas Machac'
    AND l_player = 'Flavio Cobolli'
    AND tourney_name = 'United Cup'
    AND date_match > '2024-05-01';
UPDATE atp_simple
SET round_match = 'QF'
WHERE w_player = 'Hubert Hurkacz'
    AND l_player = 'Billy Harris'
    AND tourney_name = 'United Cup'
    AND date_match > '2024-05-01';
UPDATE atp_simple
SET round_match = 'QF'
WHERE MATCH_ID = '2025_9900_090935';
UPDATE atp_simple
SET round_match = 'QF'
WHERE MATCH_ID = '2025_9900_091034';
UPDATE atp_simple
SET round_match = 'QF'
WHERE w_player = 'Alexander Schevchenko'
    AND l_player = 'Daniel Masur'
    AND tourney_name = 'United Cup'
    AND date_match > '2024-05-01';
UPDATE atp_simple
SET round_match = 'RR'
WHERE round_match is null
    AND tourney_name = 'United Cup'
    AND date_match > '2024-05-01';
-- Seteando primera y segunda ronda de qualys
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'San Luis Potosi'
    AND date_match = '2025-04-14';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'San Luis Potosi'
    AND date_match = '2025-04-13';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Auckland'
    AND date_match = '2025-01-04';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Auckland'
    AND date_match = '2025-01-03';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Munich'
    AND date_match = '2025-04-13';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Munich'
    AND date_match = '2025-04-12';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Hong Kong'
    AND date_match = '2024-12-30';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Hong Kong'
    AND date_match = '2024-12-29';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Marrakech'
    AND date_match = '2025-03-31';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Marrakech'
    AND date_match = '2025-03-30';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Montpellier'
    AND date_match = '2025-01-27';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Montpellier'
    AND date_match = '2025-01-26';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Cherbourg'
    AND date_match = '2025-03-10';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Cherbourg'
    AND date_match = '2025-03-09';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Miami'
    AND date_match = '2025-03-18';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Miami'
    AND date_match = '2025-03-17';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Indian Wells'
    AND date_match = '2025-03-04';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Indian Wells'
    AND date_match = '2025-03-03';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Rotterdam'
    AND date_match = '2025-02-02';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Rotterdam'
    AND date_match = '2025-02-01';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Monte Carlo'
    AND date_match = '2025-04-06';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Monte Carlo'
    AND date_match = '2025-04-05';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Hamburg'
    AND date_match = '2025-05-18';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Hamburg'
    AND date_match = '2025-05-17';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Rome'
    AND date_match = '2025-05-06';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Rome'
    AND date_match = '2025-05-05';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Dallas'
    AND date_match = '2025-02-02';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Dallas'
    AND date_match = '2025-02-01';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Barcelona'
    AND date_match = '2025-04-13';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Barcelona'
    AND date_match = '2025-04-12';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Doha'
    AND date_match = '2025-02-16';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Doha'
    AND date_match = '2025-02-15';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Dubai'
    AND date_match = '2025-02-23';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Dubai'
    AND date_match = '2025-02-22';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Marseille'
    AND date_match = '2025-02-10';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Marseille'
    AND date_match = '2025-02-09';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Delray Beach'
    AND date_match = '2025-02-09';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Delray Beach'
    AND date_match = '2025-02-08';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Buenos Aires'
    AND date_match = '2025-02-09';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Buenos Aires'
    AND date_match = '2025-02-08';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Prague'
    AND date_match = '2025-05-05'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Prague'
    AND date_match = '2025-05-04'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Tallahassee'
    AND date_match = '2025-04-14'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Tallahassee'
    AND date_match = '2025-04-13'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Houston'
    AND date_match = '2025-03-30'
    AND tourney_level = 'ATP';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Houston'
    AND date_match = '2025-03-29'
    AND tourney_level = 'ATP';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Acapulco'
    AND date_match = '2025-02-23'
    AND tourney_level = 'ATP';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Acapulco'
    AND date_match = '2025-02-22'
    AND tourney_level = 'ATP';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Madrid'
    AND date_match = '2025-04-22'
    AND tourney_level = 'M1000';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Madrid'
    AND date_match = '2025-04-21'
    AND tourney_level = 'M1000';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Tunis'
    AND date_match = '2025-05-12'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Tunis'
    AND date_match = '2025-05-11'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Busan'
    AND date_match = '2025-04-14'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Busan'
    AND date_match = '2025-04-12'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Ostrava'
    AND date_match = '2025-04-28'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Ostrava'
    AND date_match = '2025-04-27'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Rome'
    AND date_match = '2025-04-21'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Rome'
    AND date_match = '2025-04-20'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Noumea'
    AND date_match = '2024-12-29'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Noumea'
    AND date_match = '2024-12-28'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Nonthaburi'
    AND date_match = '2024-12-30'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Nonthaburi'
    AND date_match = '2024-12-29'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Nonthaburi 2'
    AND date_match = '2025-01-06'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Nonthaburi 2'
    AND date_match = '2025-01-05'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Nonthaburi 3'
    AND date_match = '2025-01-13'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Nonthaburi 3'
    AND date_match = '2025-01-12'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Oeiras'
    AND date_match = '2025-01-06'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Oeiras'
    AND date_match = '2025-01-05'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Oeiras 2'
    AND date_match = '2025-01-13'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Oeiras 2'
    AND date_match = '2025-01-12'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Piracicaba'
    AND date_match = '2025-01-27'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Piracicaba'
    AND date_match = '2025-01-26'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Skopje'
    AND date_match = '2025-05-19'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Skopje'
    AND date_match = '2025-05-18'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Wuxi'
    AND date_match = '2025-05-05'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Wuxi'
    AND date_match = '2025-05-04'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Santos'
    AND date_match = '2025-05-05'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Santos'
    AND date_match = '2025-05-04'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Tbilisi'
    AND date_match = '2025-05-19'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Tbilisi'
    AND date_match = '2025-05-18'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Bordeaux'
    AND date_match = '2025-05-13'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Bordeaux'
    AND date_match = '2025-05-12'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Bogota'
    AND date_match = '2025-05-12'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Bogota'
    AND date_match = '2025-05-11'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Francavilla'
    AND date_match = '2025-05-05'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Francavilla'
    AND date_match = '2025-05-04'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Zagreb'
    AND date_match = '2025-05-12'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Zagreb'
    AND date_match = '2025-05-11'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Geneva'
    AND date_match = '2025-05-18'
    AND tourney_level = 'ATP';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Geneva'
    AND date_match = '2025-05-17'
    AND tourney_level = 'ATP';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Naples'
    AND date_match = '2025-03-24'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Naples'
    AND date_match = '2025-03-23'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Kigali'
    AND date_match = '2025-02-24'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Kigali'
    AND date_match = '2025-02-23'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Kigali 2'
    AND date_match = '2025-03-03'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Kigali 2'
    AND date_match = '2025-02-02'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Merida'
    AND date_match = '2025-03-17'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Merida'
    AND date_match = '2025-03-16'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Porto Alegre'
    AND date_match = '2025-04-28'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Porto Alegre'
    AND date_match = '2025-04-27'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'San Miguel de Tucuman'
    AND date_match = '2025-04-22'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'San Miguel de Tucuman'
    AND date_match = '2025-04-21'
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Rosario'
    AND date_match = '2025-02-03'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Rosario'
    AND date_match = '2025-02-02'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Mauthausen'
    AND date_match = '2025-04-28'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Mauthausen'
    AND date_match = '2025-04-27'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Madrid'
    AND date_match = '2025-04-07'
    AND tourney_level = 'M1000';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Madrid'
    AND date_match = '2025-04-06'
    AND tourney_level = 'M1000';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Buenos Aires 2'
    AND date_match = '2025-01-13'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Buenos Aires 2'
    AND date_match = '2025-01-12'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Manama'
    AND date_match = '2025-02-10'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Manama'
    AND date_match = '2025-02-09'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Tenerife'
    AND date_match = '2025-02-03'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Tenerife'
    AND date_match = '2025-02-02'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Lugano'
    AND date_match = '2025-02-24'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Lugano'
    AND date_match = '2025-02-23'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Zadar'
    AND date_match = '2025-03-17'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Zadar'
    AND date_match = '2025-03-16'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Concepcion'
    AND date_match = '2025-03-24'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Concepcion'
    AND date_match = '2025-03-23'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Phoenix'
    AND date_match = '2025-03-11'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Phoenix'
    AND date_match = '2025-03-10'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Pau'
    AND date_match = '2025-02-17'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Pau'
    AND date_match = '2025-02-16'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Cleveland'
    AND date_match = '2025-01-27'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Cleveland'
    AND date_match = '2025-01-26'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Santiago'
    AND date_match = '2025-02-23'
    AND tourney_level = 'ATP';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Santiago'
    AND date_match = '2025-02-22'
    AND tourney_level = 'ATP';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Mexico City'
    AND date_match = '2025-04-07'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Mexico City'
    AND date_match = '2025-04-06'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Glasgow'
    AND date_match = '2025-02-17'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Glasgow'
    AND date_match = '2025-02-16'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Lille'
    AND date_match = '2025-02-03'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Lille'
    AND date_match = '2025-02-02'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Chennai'
    AND date_match = '2025-02-03'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Chennai'
    AND date_match = '2025-02-02'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Bengaluru'
    AND date_match = '2025-02-24'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Bengaluru'
    AND date_match = '2025-02-23'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Koblenz'
    AND date_match = '2025-01-27'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Koblenz'
    AND date_match = '2025-01-26'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Gwangju'
    AND date_match = '2025-04-21'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Gwangju'
    AND date_match = '2025-04-20'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Estoril'
    AND date_match = '2025-04-29'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Estoril'
    AND date_match = '2025-04-28'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Pune'
    AND date_match = '2025-02-17'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Pune'
    AND date_match = '2025-02-16'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Aix en Provence'
    AND date_match = '2025-04-29'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Aix en Provence'
    AND date_match = '2025-04-28'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Guangzhou'
    AND date_match = '2025-04-28'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Guangzhou'
    AND date_match = '2025-04-27'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Morelos'
    AND date_match = '2025-03-31'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Morelos'
    AND date_match = '2025-03-30'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'New Delhi'
    AND date_match = '2025-02-10'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'New Delhi'
    AND date_match = '2025-02-09'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Rio de Janeiro'
    AND date_match = '2025-02-16'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Rio de Janeiro'
    AND date_match = '2025-02-15'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Campinas'
    AND date_match = '2025-03-31'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Campinas'
    AND date_match = '2025-03-30'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Quimper'
    AND date_match = '2025-01-21'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Quimper'
    AND date_match = '2025-01-20'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Sarasota'
    AND date_match = '2025-04-07'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Sarasota'
    AND date_match = '2025-04-06'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Savannah'
    AND date_match = '2025-04-21'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Savannah'
    AND date_match = '2025-04-20'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Bucharest'
    AND date_match = '2025-03-31'
    AND tourney_level = 'ATP';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Bucharest'
    AND date_match = '2025-03-31'
    AND tourney_level = 'ATP';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Santiago'
    AND date_match = '2025-03-10'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Santiago'
    AND date_match = '2025-03-09'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Brisbane'
    AND tourney_level = 'ATP'
    AND MATCH_ID in (
        '2025_0339_104102',
        '2025_0339_104322',
        '2025_0339_104254',
        '2025_0339_104226',
        '2025_0339_104159',
        '2025_0339_104130'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Brisbane'
    AND tourney_level = 'ATP'
    AND round_match = '';
UPDATE atp_simple
SET round_match = 'Q3'
WHERE tourney_name = 'Australian Open'
    AND tourney_level = 'GS'
    AND date_match = '2025-01-09';
UPDATE atp_simple
SET round_match = 'Q3'
WHERE tourney_name = 'Australian Open'
    AND tourney_level = 'GS'
    AND MATCH_ID in (
        '2025_0580_132350',
        '2025_0580_132322',
        '2025_0580_132254',
        '2025_0580_132157',
        '2025_0580_132130',
        '2025_0580_132101'
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Australian Open'
    AND tourney_level = 'GS'
    AND MATCH_ID in (
        "2025_0580_132225",
        "2025_0580_132418",
        "2025_0580_132447",
        "2025_0580_132514",
        "2025_0580_132542",
        "2025_0580_132610",
        "2025_0580_132639",
        "2025_0580_132707",
        "2025_0580_132735",
        "2025_0580_132802",
        "2025_0580_132830",
        "2025_0580_132858",
        "2025_0580_132926",
        "2025_0580_132954",
        "2025_0580_133022",
        "2025_0580_133050",
        "2025_0580_133119",
        "2025_0580_133147",
        "2025_0580_133215",
        "2025_0580_133243",
        "2025_0580_133311",
        "2025_0580_133339",
        "2025_0580_133407",
        "2025_0580_133436",
        "2025_0580_133504",
        "2025_0580_133532",
        "2025_0580_133600",
        "2025_0580_133628",
        "2025_0580_133657",
        "2025_0580_133725",
        "2025_0580_133753",
        "2025_0580_133822",
        "2025_0580_133850"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Australian Open'
    AND tourney_level = 'GS'
    AND round_match = '';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Tenerife 2'
    AND date_match = '2025-02-10'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Tenerife 2'
    AND date_match = '2025-02-09'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Punta Del Este'
    AND date_match = '2025-01-20'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Punta Del Este'
    AND date_match = '2025-01-19'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Nottingham 3'
    AND date_match = '2025-01-06'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Nottingham 3'
    AND date_match = '2025-01-05'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Thionville'
    AND date_match = '2025-03-03'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Thionville'
    AND date_match = '2025-03-02'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Cap Cana'
    AND date_match = '2025-03-11'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Cap Cana'
    AND date_match = '2025-03-10'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Rio de Janeiro'
    AND date_match = '2025-02-16'
    AND tourney_level = 'ATP';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Rio de Janeiro'
    AND date_match = '2025-02-15'
    AND tourney_level = 'ATP';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Abidjan 2'
    AND date_match = '2025-04-21'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Abidjan 2'
    AND date_match = '2025-04-20'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Cordoba 2'
    AND date_match = '2025-03-03'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Cordoba 2'
    AND date_match = '2025-03-02'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Hersonissos'
    AND date_match = '2025-03-03'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Hersonissos'
    AND date_match = '2025-03-02'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Hersonissos 2'
    AND date_match = '2025-03-10'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Hersonissos 2'
    AND date_match = '2025-03-09'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Abidjan'
    AND date_match = '2025-04-14'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Abidjan'
    AND date_match = '2025-04-13'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Monza'
    AND date_match = '2025-04-07'
    AND tourney_level = 'CH';
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Monza'
    AND date_match = '2025-04-06'
    AND tourney_level = 'CH';
select *
from atp_simple
WHERE round_match = ''
    and date_match > '2025-01-01';
DELETE FROM atp_simple
WHERE tourney_name = 'Brazzaville';