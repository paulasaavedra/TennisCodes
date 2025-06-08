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
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_0213_203323',
        '2025_0213_203354',
        '2025_0213_203423',
        '2025_0213_203453',
        '2025_0213_203523',
        '2025_0213_203551'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'San Luis Potosi'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_0213_203621',
        '2025_0213_203651',
        '2025_0213_203719',
        '2025_0213_203749',
        '2025_0213_203817',
        '2025_0213_203847',
        '2025_0213_203916',
        '2025_0213_203945',
        '2025_0213_204015',
        '2025_0213_204043',
        '2025_0213_204112',
        '2025_0213_204142'
    );
-- Auckland
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Auckland'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0301_114947',
        '2025_0301_115015',
        '2025_0301_115043',
        '2025_0301_115112'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Auckland'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0301_115140',
        '2025_0301_115209',
        '2025_0301_115237',
        '2025_0301_115305',
        '2025_0301_115333',
        '2025_0301_115402',
        '2025_0301_115430',
        '2025_0301_115458'
    );
-- Munich
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Munich'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0308_145216',
        '2025_0308_145243',
        '2025_0308_145311',
        '2025_0308_145339'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Munich'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0308_145406',
        '2025_0308_145434',
        '2025_0308_145502',
        '2025_0308_145529',
        '2025_0308_145557',
        '2025_0308_145625',
        '2025_0308_145652',
        '2025_0308_145720'
    );
-- Geneva
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Geneva'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0322_183346',
        '2025_0322_183411',
        '2025_0322_183458',
        '2025_0322_183523'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Geneva'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0322_183547',
        '2025_0322_183611',
        '2025_0322_183634',
        '2025_0322_183659',
        '2025_0322_183723',
        '2025_0322_183747',
        '2025_0322_183811',
        '2025_0322_183835'
    );
-- Hong Kong
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Hong Kong'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0336_111308',
        '2025_0336_111337',
        '2025_0336_111406',
        '2025_0336_111434'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Hong Kong'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0336_111502',
        '2025_0336_111530',
        '2025_0336_111558',
        '2025_0336_111625',
        '2025_0336_111654',
        '2025_0336_111721',
        '2025_0336_111749',
        '2025_0336_111817'
    );
-- Brisbane
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Brisbane'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0339_104102',
        '2025_0339_104130',
        '2025_0339_104159',
        '2025_0339_104226',
        '2025_0339_104254',
        '2025_0339_104322'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Brisbane'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0339_104350',
        '2025_0339_104419',
        '2025_0339_104447',
        '2025_0339_104515',
        '2025_0339_104543',
        '2025_0339_104611',
        '2025_0339_104638',
        '2025_0339_104706',
        '2025_0339_104734',
        '2025_0339_104803',
        '2025_0339_104831',
        '2025_0339_104858'
    );
-- Marrakech
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Marrakech'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0360_105916',
        '2025_0360_105945',
        '2025_0360_110016',
        '2025_0360_110046'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Marrakech'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0360_110116',
        '2025_0360_110147',
        '2025_0360_110217',
        '2025_0360_110247',
        '2025_0360_110317',
        '2025_0360_110346',
        '2025_0360_110416',
        '2025_0360_110446'
    );
-- Montpellier
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Montpellier'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0375_145319',
        '2025_0375_145347',
        '2025_0375_145415',
        '2025_0375_145443'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Montpellier'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0375_145511',
        '2025_0375_145539',
        '2025_0375_145607',
        '2025_0375_145634',
        '2025_0375_145703',
        '2025_0375_145730',
        '2025_0375_145758',
        '2025_0375_145826'
    );
-- Cherbourg
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Cherbourg'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_0398_123652',
        '2025_0398_123719',
        '2025_0398_123747',
        '2025_0398_123815',
        '2025_0398_123843',
        '2025_0398_123912'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Cherbourg'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_0398_123940',
        '2025_0398_124008',
        '2025_0398_124036',
        '2025_0398_124104',
        '2025_0398_124132',
        '2025_0398_124201',
        '2025_0398_124229',
        '2025_0398_124257',
        '2025_0398_124325',
        '2025_0398_124353',
        '2025_0398_124421',
        '2025_0398_124449'
    );
-- Miami
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Miami'
    AND tourney_level = 'M1000'
    AND match_id IN (
        '2025_0403_223858',
        '2025_0403_223926',
        '2025_0403_223954',
        '2025_0403_224022',
        '2025_0403_224049',
        '2025_0403_224117',
        '2025_0403_224146',
        '2025_0403_224214',
        '2025_0403_224242',
        '2025_0403_224309',
        '2025_0403_224337',
        '2025_0403_224405'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Miami'
    AND tourney_level = 'M1000'
    AND match_id IN (
        '2025_0403_224433',
        '2025_0403_224501',
        '2025_0403_224529',
        '2025_0403_224557',
        '2025_0403_224625',
        '2025_0403_224654',
        '2025_0403_224722',
        '2025_0403_224750',
        '2025_0403_224818',
        '2025_0403_224846',
        '2025_0403_224915',
        '2025_0403_224943',
        '2025_0403_225011',
        '2025_0403_225040',
        '2025_0403_225107',
        '2025_0403_225135',
        '2025_0403_225203',
        '2025_0403_225231',
        '2025_0403_225259',
        '2025_0403_225327',
        '2025_0403_225355',
        '2025_0403_225423',
        '2025_0403_225450',
        '2025_0403_225518'
    );
-- Indian Wells
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Indian Wells'
    AND tourney_level = 'M1000'
    AND match_id IN (
        '2025_0404_102736',
        '2025_0404_102837',
        '2025_0404_102929',
        '2025_0404_103036',
        '2025_0404_103138',
        '2025_0404_103302',
        '2025_0404_103353',
        '2025_0404_103511',
        '2025_0404_103626',
        '2025_0404_103700',
        '2025_0404_103733',
        '2025_0404_103806'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Indian Wells'
    AND tourney_level = 'M1000'
    AND match_id IN (
        '2025_0404_103841',
        '2025_0404_103936',
        '2025_0404_104024',
        '2025_0404_104237',
        '2025_0404_214524',
        '2025_0404_214552',
        '2025_0404_214620',
        '2025_0404_214648',
        '2025_0404_214716',
        '2025_0404_214744',
        '2025_0404_214812',
        '2025_0404_214840',
        '2025_0404_214908',
        '2025_0404_214936',
        '2025_0404_215004',
        '2025_0404_215032',
        '2025_0404_215100',
        '2025_0404_215128',
        '2025_0404_215155',
        '2025_0404_215223',
        '2025_0404_215251',
        '2025_0404_215319',
        '2025_0404_215347',
        '2025_0404_215415'
    );
-- Rotterdam
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Rotterdam'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0407_151341',
        '2025_0407_151409',
        '2025_0407_151437',
        '2025_0407_151505'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Rotterdam'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0407_151532',
        '2025_0407_151600',
        '2025_0407_151628',
        '2025_0407_151656',
        '2025_0407_151724',
        '2025_0407_151752',
        '2025_0407_151820',
        '2025_0407_151848'
    );
-- Monte Carlo
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Monte Carlo'
    AND tourney_level = 'M1000'
    AND match_id IN (
        '2025_0410_120113',
        '2025_0410_120142',
        '2025_0410_120210',
        '2025_0410_120238',
        '2025_0410_120306',
        '2025_0410_120335',
        '2025_0410_120403'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Monte Carlo'
    AND tourney_level = 'M1000'
    AND match_id IN (
        '2025_0410_120431',
        '2025_0410_120459',
        '2025_0410_120527',
        '2025_0410_120555',
        '2025_0410_120623',
        '2025_0410_120651',
        '2025_0410_120719',
        '2025_0410_120746',
        '2025_0410_120814',
        '2025_0410_120842',
        '2025_0410_120911',
        '2025_0410_120939',
        '2025_0410_121007',
        '2025_0410_121035'
    );
-- Hamburg
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Hamburg'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0414_090336',
        '2025_0414_090359',
        '2025_0414_090423',
        '2025_0414_090447'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Hamburg'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0414_090511',
        '2025_0414_090540',
        '2025_0414_090603',
        '2025_0414_090627',
        '2025_0414_090651',
        '2025_0414_090715',
        '2025_0414_090739',
        '2025_0414_090806'
    );
-- Rome
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Rome'
    AND tourney_level = 'M1000'
    AND match_id IN (
        '2025_0416_210515',
        '2025_0416_210543',
        '2025_0416_210612',
        '2025_0416_210639',
        '2025_0416_210708',
        '2025_0416_210736',
        '2025_0416_210804',
        '2025_0416_210833',
        '2025_0416_210901',
        '2025_0416_210929',
        '2025_0416_210957',
        '2025_0416_211025'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Rome'
    AND tourney_level = 'M1000'
    AND match_id IN (
        '2025_0416_225301',
        '2025_0416_225328',
        '2025_0416_225355',
        '2025_0416_225422',
        '2025_0416_225449',
        '2025_0416_225516',
        '2025_0416_225543',
        '2025_0416_225611',
        '2025_0416_225638',
        '2025_0416_225706',
        '2025_0416_225733',
        '2025_0416_225801',
        '2025_0416_225829',
        '2025_0416_225858',
        '2025_0416_225926',
        '2025_0416_225954',
        '2025_0416_230021',
        '2025_0416_230049',
        '2025_0416_230116',
        '2025_0416_230143',
        '2025_0416_230211',
        '2025_0416_230238',
        '2025_0416_230305',
        '2025_0416_230333'
    );
-- Dallas
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Dallas'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0424_155005',
        '2025_0424_155033',
        '2025_0424_155101',
        '2025_0424_155129'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Dallas'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0424_155158',
        '2025_0424_155225',
        '2025_0424_155253',
        '2025_0424_155321',
        '2025_0424_155349',
        '2025_0424_155417',
        '2025_0424_155444',
        '2025_0424_155513'
    );
-- Barcelona
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Barcelona'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0425_142924',
        '2025_0425_142951',
        '2025_0425_143019',
        '2025_0425_143046',
        '2025_0425_143114',
        '2025_0425_143141'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Barcelona'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0425_143209',
        '2025_0425_143237',
        '2025_0425_143305',
        '2025_0425_143332',
        '2025_0425_143400',
        '2025_0425_143428',
        '2025_0425_143455',
        '2025_0425_143523',
        '2025_0425_143550',
        '2025_0425_143618',
        '2025_0425_143646',
        '2025_0425_143713'
    );
-- Doha
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Doha'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0451_171250',
        '2025_0451_171318',
        '2025_0451_171346',
        '2025_0451_171414'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Doha'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0451_171442',
        '2025_0451_171510',
        '2025_0451_171538',
        '2025_0451_171606',
        '2025_0451_171634',
        '2025_0451_171702',
        '2025_0451_171730',
        '2025_0451_171758'
    );
-- Dubai
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Dubai'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0495_181323',
        '2025_0495_181351',
        '2025_0495_181419',
        '2025_0495_181447'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Dubai'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0495_181515',
        '2025_0495_181543',
        '2025_0495_181611',
        '2025_0495_181639',
        '2025_0495_181706',
        '2025_0495_181734',
        '2025_0495_181802',
        '2025_0495_181830'
    );
-- Marseille
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Marseille'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0496_165114',
        '2025_0496_165142',
        '2025_0496_165210',
        '2025_0496_165238'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Marseille'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0496_165306',
        '2025_0496_165333',
        '2025_0496_165401',
        '2025_0496_165429',
        '2025_0496_165456',
        '2025_0496_165524',
        '2025_0496_165553',
        '2025_0496_165621'
    );
-- Delray Beach
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Delray Beach'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0499_161120',
        '2025_0499_161147',
        '2025_0499_161215',
        '2025_0499_161244'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Delray Beach'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0499_161312',
        '2025_0499_161339',
        '2025_0499_161408',
        '2025_0499_161436',
        '2025_0499_161503',
        '2025_0499_161531',
        '2025_0499_161559',
        '2025_0499_161628'
    );
-- Buenos Aires
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Buenos Aires'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0506_163108',
        '2025_0506_163136',
        '2025_0506_163204',
        '2025_0506_163232'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Buenos Aires'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0506_163300',
        '2025_0506_163328',
        '2025_0506_163355',
        '2025_0506_163423',
        '2025_0506_163451',
        '2025_0506_163519',
        '2025_0506_163547',
        '2025_0506_163615'
    );
-- Australian Open
UPDATE atp_simple
SET round_match = 'Q3'
WHERE tourney_name = 'Australian Open'
    AND tourney_level = 'GS'
    AND match_id IN (
        '2025_0580_131649',
        '2025_0580_131718',
        '2025_0580_131745',
        '2025_0580_131814',
        '2025_0580_131842',
        '2025_0580_131909',
        '2025_0580_131937',
        '2025_0580_132005',
        '2025_0580_132033',
        '2025_0580_132101',
        '2025_0580_132130',
        '2025_0580_132157',
        '2025_0580_132225',
        '2025_0580_132254',
        '2025_0580_132322',
        '2025_0580_132350'
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Australian Open'
    AND tourney_level = 'GS'
    AND match_id IN (
        '2025_0580_132418',
        '2025_0580_132447',
        '2025_0580_132514',
        '2025_0580_132542',
        '2025_0580_132610',
        '2025_0580_132639',
        '2025_0580_132707',
        '2025_0580_132735',
        '2025_0580_132802',
        '2025_0580_132830',
        '2025_0580_132858',
        '2025_0580_132926',
        '2025_0580_132954',
        '2025_0580_133022',
        '2025_0580_133050',
        '2025_0580_133119',
        '2025_0580_133147',
        '2025_0580_133215',
        '2025_0580_133243',
        '2025_0580_133311',
        '2025_0580_133339',
        '2025_0580_133407',
        '2025_0580_133436',
        '2025_0580_133504',
        '2025_0580_133532',
        '2025_0580_133600',
        '2025_0580_133628',
        '2025_0580_133657',
        '2025_0580_133725',
        '2025_0580_133753',
        '2025_0580_133822',
        '2025_0580_133850'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Australian Open'
    AND tourney_level = 'GS'
    AND match_id IN (
        '2025_0580_133919',
        '2025_0580_133947',
        '2025_0580_134014',
        '2025_0580_134042',
        '2025_0580_134110',
        '2025_0580_134138',
        '2025_0580_134207',
        '2025_0580_134235',
        '2025_0580_134302',
        '2025_0580_134330',
        '2025_0580_134358',
        '2025_0580_134426',
        '2025_0580_134454',
        '2025_0580_134523',
        '2025_0580_134551',
        '2025_0580_134619',
        '2025_0580_134648',
        '2025_0580_134716',
        '2025_0580_134744',
        '2025_0580_134812',
        '2025_0580_134840',
        '2025_0580_134908',
        '2025_0580_134936',
        '2025_0580_135005',
        '2025_0580_135033',
        '2025_0580_135101',
        '2025_0580_135129',
        '2025_0580_135157',
        '2025_0580_135224',
        '2025_0580_135253',
        '2025_0580_135321',
        '2025_0580_135349',
        '2025_0580_135417',
        '2025_0580_135445',
        '2025_0580_135513',
        '2025_0580_135542',
        '2025_0580_135610',
        '2025_0580_135638',
        '2025_0580_135706',
        '2025_0580_135734',
        '2025_0580_135801',
        '2025_0580_135829',
        '2025_0580_135858',
        '2025_0580_135925',
        '2025_0580_135953',
        '2025_0580_140022',
        '2025_0580_140050',
        '2025_0580_140118',
        '2025_0580_140146',
        '2025_0580_140214',
        '2025_0580_140242',
        '2025_0580_140310',
        '2025_0580_140338',
        '2025_0580_140406',
        '2025_0580_140434',
        '2025_0580_140502',
        '2025_0580_140530',
        '2025_0580_140559',
        '2025_0580_140627',
        '2025_0580_140655',
        '2025_0580_140723',
        '2025_0580_140751',
        '2025_0580_140819',
        '2025_0580_140847'
    );
-- Prague CH Q2
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Prague'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_0600_202503',
        '2025_0600_202627',
        '2025_0600_202655',
        '2025_0600_202723',
        '2025_0600_202750',
        '2025_0600_202818'
    );
-- Prague CH Q1
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Prague'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_0600_202846',
        '2025_0600_202913',
        '2025_0600_202941',
        '2025_0600_203009',
        '2025_0600_203036',
        '2025_0600_203105',
        '2025_0600_203133',
        '2025_0600_203201',
        '2025_0600_203229',
        '2025_0600_203256',
        '2025_0600_203324',
        '2025_0600_203352'
    );
-- Tallahassee CH Q2
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Tallahassee'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_0692_205732',
        '2025_0692_205803',
        '2025_0692_205831',
        '2025_0692_205901',
        '2025_0692_205930',
        '2025_0692_205957'
    );
-- Tallahassee CH Q1
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Tallahassee'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_0692_210027',
        '2025_0692_210056',
        '2025_0692_210123',
        '2025_0692_210151',
        '2025_0692_210219',
        '2025_0692_210248',
        '2025_0692_210319',
        '2025_0692_210347',
        '2025_0692_210416',
        '2025_0692_210444',
        '2025_0692_210512',
        '2025_0692_210540'
    );
-- Houston ATP Q2
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Houston'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0717_103117',
        '2025_0717_103149',
        '2025_0717_103219',
        '2025_0717_103250'
    );
-- Houston ATP Q1
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Houston'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0717_103320',
        '2025_0717_103352',
        '2025_0717_103425',
        '2025_0717_103455',
        '2025_0717_103527',
        '2025_0717_103557',
        '2025_0717_103627',
        '2025_0717_103659'
    );
-- Acapulco ATP Q2
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Acapulco'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0807_175301',
        '2025_0807_175329',
        '2025_0807_175357',
        '2025_0807_175425'
    );
-- Acapulco ATP Q1
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Acapulco'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_0807_175453',
        '2025_0807_175521',
        '2025_0807_175549',
        '2025_0807_175617',
        '2025_0807_175645',
        '2025_0807_175713',
        '2025_0807_175741',
        '2025_0807_175809'
    );
-- Madrid M1000 Q2
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Madrid'
    AND tourney_level = 'M1000'
    AND match_id IN (
        '2025_1536_215809',
        '2025_1536_215837',
        '2025_1536_215905',
        '2025_1536_215934',
        '2025_1536_220001',
        '2025_1536_220029',
        '2025_1536_220056',
        '2025_1536_220124',
        '2025_1536_220151',
        '2025_1536_220218',
        '2025_1536_220246',
        '2025_1536_220313'
    );
-- Madrid M1000 Q1
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Madrid'
    AND tourney_level = 'M1000'
    AND match_id IN (
        '2025_1536_220341',
        '2025_1536_220409',
        '2025_1536_220438',
        '2025_1536_220505',
        '2025_1536_220533',
        '2025_1536_220600',
        '2025_1536_220628',
        '2025_1536_220656',
        '2025_1536_220724',
        '2025_1536_220752',
        '2025_1536_220819',
        '2025_1536_220847',
        '2025_1536_220915',
        '2025_1536_220943',
        '2025_1536_221011',
        '2025_1536_221039',
        '2025_1536_221107',
        '2025_1536_221135',
        '2025_1536_221203',
        '2025_1536_221231',
        '2025_1536_221258',
        '2025_1536_221326',
        '2025_1536_221354',
        '2025_1536_221421'
    );
-- Tunis
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Tunis'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_1541_092107',
        '2025_1541_092130',
        '2025_1541_092155',
        '2025_1541_092218',
        '2025_1541_092242',
        '2025_1541_092307'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Tunis'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_1541_092331',
        '2025_1541_092354',
        '2025_1541_092419',
        '2025_1541_092442',
        '2025_1541_092507',
        '2025_1541_092531',
        '2025_1541_092554',
        '2025_1541_092618',
        '2025_1541_092642',
        '2025_1541_092706',
        '2025_1541_092730',
        '2025_1541_092753'
    );
-- Busan
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Busan'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_1741_194510',
        '2025_1741_194540',
        '2025_1741_194611',
        '2025_1741_194640',
        '2025_1741_194710',
        '2025_1741_194739'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Busan'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_1741_194809',
        '2025_1741_194838',
        '2025_1741_194908',
        '2025_1741_194939',
        '2025_1741_195009',
        '2025_1741_195039',
        '2025_1741_195109',
        '2025_1741_195139',
        '2025_1741_195208',
        '2025_1741_195239',
        '2025_1741_195309',
        '2025_1741_195339'
    );
-- Ostrava
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Ostrava'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_1797_205910',
        '2025_1797_205938',
        '2025_1797_210022',
        '2025_1797_210103',
        '2025_1797_210138',
        '2025_1797_210211'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Ostrava'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_1797_210247',
        '2025_1797_210322',
        '2025_1797_210350',
        '2025_1797_210432',
        '2025_1797_210512',
        '2025_1797_210540',
        '2025_1797_210616',
        '2025_1797_210654',
        '2025_1797_210723',
        '2025_1797_210805',
        '2025_1797_210845',
        '2025_1797_210913'
    );
-- Rome
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Rome'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2151_194005',
        '2025_2151_194033',
        '2025_2151_194101',
        '2025_2151_194129',
        '2025_2151_194158',
        '2025_2151_194226'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Rome'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2151_194254',
        '2025_2151_194324',
        '2025_2151_194352',
        '2025_2151_194420',
        '2025_2151_194448',
        '2025_2151_194518',
        '2025_2151_194546',
        '2025_2151_194614',
        '2025_2151_194642',
        '2025_2151_194710',
        '2025_2151_194738',
        '2025_2151_194806'
    );
-- Noumea
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Noumea'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2205_232607',
        '2025_2205_232634',
        '2025_2205_232702',
        '2025_2205_232730',
        '2025_2205_232758',
        '2025_2205_232856'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Noumea'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2205_232828',
        '2025_2205_232924',
        '2025_2205_233011',
        '2025_2205_233039'
    );
-- Nonthaburi
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Nonthaburi'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2791_234551',
        '2025_2791_234619',
        '2025_2791_234646',
        '2025_2791_234714',
        '2025_2791_234743',
        '2025_2791_234812'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Nonthaburi'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2791_234839',
        '2025_2791_234907',
        '2025_2791_234935',
        '2025_2791_235003',
        '2025_2791_235030',
        '2025_2791_235058',
        '2025_2791_235126',
        '2025_2791_235153',
        '2025_2791_235221',
        '2025_2791_235249',
        '2025_2791_235317',
        '2025_2791_235345'
    );
-- Nonthaburi 2
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Nonthaburi 2'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2795_000858',
        '2025_2795_000926',
        '2025_2795_000954',
        '2025_2795_001022',
        '2025_2795_001050',
        '2025_2795_001118'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Nonthaburi 2'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2795_001146',
        '2025_2795_001214',
        '2025_2795_001243',
        '2025_2795_001311',
        '2025_2795_001339',
        '2025_2795_001407',
        '2025_2795_001434',
        '2025_2795_001502',
        '2025_2795_001531',
        '2025_2795_001559',
        '2025_2795_001628',
        '2025_2795_001655'
    );
-- Nonthaburi 3
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Nonthaburi 3'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2801_014104',
        '2025_2801_014132',
        '2025_2801_014159',
        '2025_2801_014227',
        '2025_2801_014255',
        '2025_2801_014323'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Nonthaburi 3'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2801_014350',
        '2025_2801_014418',
        '2025_2801_014445',
        '2025_2801_014513',
        '2025_2801_014541',
        '2025_2801_014610',
        '2025_2801_014638',
        '2025_2801_014706',
        '2025_2801_014734',
        '2025_2801_014802',
        '2025_2801_014829',
        '2025_2801_014857'
    );
-- Oeiras
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Oeiras'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2831_005525',
        '2025_2831_005554',
        '2025_2831_005621',
        '2025_2831_005649',
        '2025_2831_005718',
        '2025_2831_005745'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Oeiras'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2831_005813',
        '2025_2831_005841',
        '2025_2831_005909',
        '2025_2831_005937',
        '2025_2831_010005',
        '2025_2831_010057',
        '2025_2831_010125',
        '2025_2831_010153',
        '2025_2831_010221',
        '2025_2831_010249',
        '2025_2831_010317'
    );
-- Oeiras 2
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Oeiras 2'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2833_011825',
        '2025_2833_011853',
        '2025_2833_011921',
        '2025_2833_011948',
        '2025_2833_012016',
        '2025_2833_012044'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Oeiras 2'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2833_012112',
        '2025_2833_012140',
        '2025_2833_012208',
        '2025_2833_012235',
        '2025_2833_012303',
        '2025_2833_012331',
        '2025_2833_012359',
        '2025_2833_012427',
        '2025_2833_012454',
        '2025_2833_012522',
        '2025_2833_012550',
        '2025_2833_012617'
    );
-- Piracicaba
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Piracicaba'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2835_033435',
        '2025_2835_033503',
        '2025_2835_033531',
        '2025_2835_033559',
        '2025_2835_033627',
        '2025_2835_033655'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Piracicaba'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2835_033722',
        '2025_2835_033750',
        '2025_2835_033818',
        '2025_2835_033846',
        '2025_2835_033913',
        '2025_2835_033941',
        '2025_2835_034009',
        '2025_2835_034037',
        '2025_2835_034105',
        '2025_2835_034132',
        '2025_2835_034200',
        '2025_2835_034228'
    );
-- Tenerife 2
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Tenerife 2'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2839_074848',
        '2025_2839_074915',
        '2025_2839_074943',
        '2025_2839_075011',
        '2025_2839_075038',
        '2025_2839_075106'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Tenerife 2'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2839_075133',
        '2025_2839_075201',
        '2025_2839_075229',
        '2025_2839_075257',
        '2025_2839_075325',
        '2025_2839_075352',
        '2025_2839_075420',
        '2025_2839_075448',
        '2025_2839_075515',
        '2025_2839_075543',
        '2025_2839_075611',
        '2025_2839_075640'
    );
-- Girona
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Girona'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2855_155344',
        '2025_2855_155440',
        '2025_2855_155508',
        '2025_2855_155536',
        '2025_2855_155604',
        '2025_2855_155632'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Girona'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2855_155700',
        '2025_2855_155727',
        '2025_2855_155755',
        '2025_2855_155823',
        '2025_2855_155852',
        '2025_2855_155920',
        '2025_2855_155948',
        '2025_2855_160016',
        '2025_2855_160044',
        '2025_2855_160112',
        '2025_2855_160139',
        '2025_2855_160207'
    );
-- Skopje
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Skopje'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2869_103505',
        '2025_2869_103555',
        '2025_2869_103643',
        '2025_2869_103707',
        '2025_2869_103731',
        '2025_2869_103755'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Skopje'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2869_103819',
        '2025_2869_103842',
        '2025_2869_103906',
        '2025_2869_103930',
        '2025_2869_103954',
        '2025_2869_104018',
        '2025_2869_104042',
        '2025_2869_104106',
        '2025_2869_104130',
        '2025_2869_104154',
        '2025_2869_104218',
        '2025_2869_104242'
    );
-- Punta Del Este
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Punta Del Este'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2901_022637',
        '2025_2901_022705',
        '2025_2901_022801',
        '2025_2901_022829',
        '2025_2901_022857',
        '2025_2901_022925'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Punta Del Este'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2901_022953',
        '2025_2901_023020',
        '2025_2901_023048',
        '2025_2901_023115',
        '2025_2901_023143',
        '2025_2901_023211',
        '2025_2901_023239',
        '2025_2901_023307',
        '2025_2901_023335',
        '2025_2901_023402',
        '2025_2901_023431',
        '2025_2901_023459'
    );
-- Nottingham 3
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Nottingham 3'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2907_003212',
        '2025_2907_003240',
        '2025_2907_003308',
        '2025_2907_003336',
        '2025_2907_003404',
        '2025_2907_003432'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Nottingham 3'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2907_003500',
        '2025_2907_003528',
        '2025_2907_003556',
        '2025_2907_003624',
        '2025_2907_003653',
        '2025_2907_003721',
        '2025_2907_003749',
        '2025_2907_003817',
        '2025_2907_003845',
        '2025_2907_003913',
        '2025_2907_003941',
        '2025_2907_004009'
    );
-- Asuncion
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Asuncion'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2909_135833',
        '2025_2909_140023',
        '2025_2909_140051',
        '2025_2909_140119',
        '2025_2909_140147',
        '2025_2909_140215'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Asuncion'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2909_140243',
        '2025_2909_140311',
        '2025_2909_140339',
        '2025_2909_140408',
        '2025_2909_140436',
        '2025_2909_140504',
        '2025_2909_140532',
        '2025_2909_140600',
        '2025_2909_140628',
        '2025_2909_195815',
        '2025_2909_200134',
        '2025_2909_200446'
    );
-- Naples
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Naples'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2911_153104',
        '2025_2911_153133',
        '2025_2911_153200',
        '2025_2911_153228',
        '2025_2911_153256',
        '2025_2911_153324'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Naples'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2911_153353',
        '2025_2911_153420',
        '2025_2911_153449',
        '2025_2911_153517',
        '2025_2911_153544',
        '2025_2911_153612',
        '2025_2911_153640',
        '2025_2911_153708',
        '2025_2911_153737',
        '2025_2911_153805',
        '2025_2911_153832',
        '2025_2911_153900'
    );
-- Kigali
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Kigali'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2913_095832',
        '2025_2913_095900',
        '2025_2913_095927',
        '2025_2913_095955',
        '2025_2913_100023',
        '2025_2913_100051'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Kigali'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2913_100119',
        '2025_2913_100146',
        '2025_2913_100214',
        '2025_2913_100242',
        '2025_2913_100310',
        '2025_2913_100321',
        '2025_2913_100349',
        '2025_2913_100417',
        '2025_2913_100445',
        '2025_2913_100513',
        '2025_2913_100541'
    );
-- Kigali 2
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Kigali 2'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2915_104310',
        '2025_2915_104406',
        '2025_2915_104502',
        '2025_2915_104530',
        '2025_2915_104559',
        '2025_2915_104626'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Kigali 2'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2915_104655',
        '2025_2915_104723',
        '2025_2915_104751',
        '2025_2915_104818',
        '2025_2915_104846',
        '2025_2915_104914',
        '2025_2915_104942',
        '2025_2915_105010',
        '2025_2915_105037',
        '2025_2915_105105',
        '2025_2915_105133',
        '2025_2915_105201'
    );
-- Merida
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Merida'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2917_142132',
        '2025_2917_142200',
        '2025_2917_142228',
        '2025_2917_142256',
        '2025_2917_142324',
        '2025_2917_142352'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Merida'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2917_142420',
        '2025_2917_142448',
        '2025_2917_142516',
        '2025_2917_142544',
        '2025_2917_142611',
        '2025_2917_142640',
        '2025_2917_142707',
        '2025_2917_142736',
        '2025_2917_142804',
        '2025_2917_142832',
        '2025_2917_142928',
        '2025_2917_201636'
    );
-- Porto Alegre
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Porto Alegre'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2919_213010',
        '2025_2919_213039',
        '2025_2919_213116',
        '2025_2919_213151',
        '2025_2919_213227',
        '2025_2919_213327'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Porto Alegre'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2919_213405',
        '2025_2919_213444',
        '2025_2919_213513',
        '2025_2919_213541',
        '2025_2919_213624',
        '2025_2919_213707',
        '2025_2919_213749',
        '2025_2919_213817',
        '2025_2919_213858',
        '2025_2919_213927',
        '2025_2919_214002',
        '2025_2919_214031'
    );
-- Wuxi
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Wuxi'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2921_200242',
        '2025_2921_200310',
        '2025_2921_200338',
        '2025_2921_200434',
        '2025_2921_200502',
        '2025_2921_200529'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Wuxi'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2921_200557',
        '2025_2921_200625',
        '2025_2921_200653',
        '2025_2921_200721',
        '2025_2921_200749',
        '2025_2921_200817',
        '2025_2921_200845',
        '2025_2921_200912',
        '2025_2921_200940',
        '2025_2921_201008',
        '2025_2921_201036',
        '2025_2921_201104'
    );
-- Santos
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Santos'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2923_211159',
        '2025_2923_211227',
        '2025_2923_211255',
        '2025_2923_211323',
        '2025_2923_211351',
        '2025_2923_211418'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Santos'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2923_211446',
        '2025_2923_211515',
        '2025_2923_211542',
        '2025_2923_211611',
        '2025_2923_211639',
        '2025_2923_211707',
        '2025_2923_211736',
        '2025_2923_211804',
        '2025_2923_211832',
        '2025_2923_211859',
        '2025_2923_211927',
        '2025_2923_211955'
    );
-- Tbilisi
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Tbilisi'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2925_105527',
        '2025_2925_105551',
        '2025_2925_105615',
        '2025_2925_105638',
        '2025_2925_105702',
        '2025_2925_105726'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Tbilisi'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2925_105750',
        '2025_2925_105814',
        '2025_2925_105838',
        '2025_2925_105902',
        '2025_2925_105926',
        '2025_2925_105950',
        '2025_2925_110014',
        '2025_2925_110038',
        '2025_2925_110102',
        '2025_2925_110126',
        '2025_2925_110150',
        '2025_2925_110214'
    );
-- San Miguel de Tucuman
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'San Miguel de Tucuman'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2927_191730',
        '2025_2927_191757',
        '2025_2927_191826',
        '2025_2927_191854',
        '2025_2927_191922',
        '2025_2927_191950'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'San Miguel de Tucuman'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2927_192018',
        '2025_2927_192046',
        '2025_2927_192115',
        '2025_2927_192142',
        '2025_2927_192211',
        '2025_2927_192239',
        '2025_2927_192307',
        '2025_2927_192335',
        '2025_2927_192403',
        '2025_2927_192431',
        '2025_2927_192459',
        '2025_2927_192528'
    );
-- Rosario
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Rosario'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2965_052851',
        '2025_2965_052919',
        '2025_2965_052947',
        '2025_2965_053015',
        '2025_2965_053042',
        '2025_2965_053110'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Rosario'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2965_053138',
        '2025_2965_053206',
        '2025_2965_053234',
        '2025_2965_053302',
        '2025_2965_053329',
        '2025_2965_053357',
        '2025_2965_053425',
        '2025_2965_053452',
        '2025_2965_053520',
        '2025_2965_053548',
        '2025_2965_053616',
        '2025_2965_053644'
    );
-- Brisbane
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Brisbane'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2967_042022',
        '2025_2967_042050',
        '2025_2967_042118',
        '2025_2967_042145',
        '2025_2967_042213',
        '2025_2967_042241'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Brisbane'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2967_042309',
        '2025_2967_042337',
        '2025_2967_042404',
        '2025_2967_042432',
        '2025_2967_042500',
        '2025_2967_042527',
        '2025_2967_042556',
        '2025_2967_042623',
        '2025_2967_042652',
        '2025_2967_042719',
        '2025_2967_042747',
        '2025_2967_042815'
    );
-- Brisbane 2
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Brisbane 2'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2969_061451',
        '2025_2969_061518',
        '2025_2969_061546',
        '2025_2969_061614',
        '2025_2969_061642',
        '2025_2969_061710'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Brisbane 2'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2969_061738',
        '2025_2969_061806',
        '2025_2969_061834',
        '2025_2969_061902',
        '2025_2969_061929',
        '2025_2969_061958',
        '2025_2969_062026',
        '2025_2969_062054',
        '2025_2969_062122',
        '2025_2969_062149',
        '2025_2969_062217',
        '2025_2969_062245'
    );
-- Thionville
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Thionville'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2973_112939',
        '2025_2973_113007',
        '2025_2973_113035',
        '2025_2973_113103',
        '2025_2973_113131',
        '2025_2973_113158'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Thionville'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2973_113227',
        '2025_2973_113254',
        '2025_2973_113322',
        '2025_2973_113350',
        '2025_2973_113418',
        '2025_2973_113446',
        '2025_2973_113514',
        '2025_2973_113542',
        '2025_2973_113610',
        '2025_2973_113638',
        '2025_2973_113706',
        '2025_2973_113734'
    );
-- Cap Cana
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Cap Cana'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2975_133953',
        '2025_2975_134022',
        '2025_2975_134050',
        '2025_2975_134101'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Cap Cana'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2975_134129',
        '2025_2975_134156',
        '2025_2975_134224',
        '2025_2975_134252',
        '2025_2975_134320',
        '2025_2975_134348'
    );
-- Oeiras 5
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Oeiras 5'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2979_031159',
        '2025_2979_031324',
        '2025_2979_031351',
        '2025_2979_031419',
        '2025_2979_031446',
        '2025_2979_031514'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Oeiras 5'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2979_031542',
        '2025_2979_031610',
        '2025_2979_031638',
        '2025_2979_031705',
        '2025_2979_031733',
        '2025_2979_031801',
        '2025_2979_031833',
        '2025_2979_031901',
        '2025_2979_031929'
    );
-- Cordoba 2
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Cordoba 2'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2981_110713',
        '2025_2981_110741',
        '2025_2981_110809',
        '2025_2981_110837',
        '2025_2981_110904'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Cordoba 2'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2981_110932',
        '2025_2981_111000',
        '2025_2981_111028',
        '2025_2981_111057',
        '2025_2981_111125',
        '2025_2981_111153',
        '2025_2981_111221',
        '2025_2981_111250',
        '2025_2981_111318',
        '2025_2981_111346',
        '2025_2981_111414',
        '2025_2981_111442'
    );
-- Hersonissos
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Hersonissos'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2983_115248',
        '2025_2983_115316',
        '2025_2983_115344',
        '2025_2983_115412',
        '2025_2983_115440',
        '2025_2983_115508'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Hersonissos'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2983_115537',
        '2025_2983_115604',
        '2025_2983_115632',
        '2025_2983_115700',
        '2025_2983_115728',
        '2025_2983_115756',
        '2025_2983_115826'
    );
-- Hersonissos 2
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Hersonissos 2'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2985_130003',
        '2025_2985_130031',
        '2025_2985_130100',
        '2025_2985_130128',
        '2025_2985_130156',
        '2025_2985_130225'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Hersonissos 2'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2985_130253',
        '2025_2985_130321',
        '2025_2985_130349',
        '2025_2985_130417',
        '2025_2985_130445',
        '2025_2985_130513',
        '2025_2985_130542',
        '2025_2985_130609',
        '2025_2985_130638',
        '2025_2985_130706',
        '2025_2985_130735',
        '2025_2985_130802'
    );
-- Menorca
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Menorca'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2987_164029',
        '2025_2987_164057',
        '2025_2987_164125',
        '2025_2987_164154',
        '2025_2987_164222',
        '2025_2987_164250'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Menorca'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2987_164317',
        '2025_2987_164346',
        '2025_2987_164413',
        '2025_2987_164441',
        '2025_2987_164509',
        '2025_2987_164537',
        '2025_2987_164606',
        '2025_2987_164634',
        '2025_2987_164702',
        '2025_2987_164730',
        '2025_2987_164757',
        '2025_2987_164825'
    );
-- Monza
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Monza'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2989_183539',
        '2025_2989_183607',
        '2025_2989_183635',
        '2025_2989_183703',
        '2025_2989_183731',
        '2025_2989_183759'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Monza'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2989_183827',
        '2025_2989_183855',
        '2025_2989_183923',
        '2025_2989_183951',
        '2025_2989_184020',
        '2025_2989_184048',
        '2025_2989_184115',
        '2025_2989_184143',
        '2025_2989_184211',
        '2025_2989_184239',
        '2025_2989_184306',
        '2025_2989_184334'
    );
-- Abidjan
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Abidjan'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2995_212538',
        '2025_2995_212605',
        '2025_2995_212633',
        '2025_2995_212711',
        '2025_2995_212739',
        '2025_2995_212807'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Abidjan'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2995_212835',
        '2025_2995_212904',
        '2025_2995_212931',
        '2025_2995_212959',
        '2025_2995_213027',
        '2025_2995_213055',
        '2025_2995_213123',
        '2025_2995_213151',
        '2025_2995_213219',
        '2025_2995_213247',
        '2025_2995_213314',
        '2025_2995_214125'
    );
-- Abidjan 2
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Abidjan 2'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2997_202513',
        '2025_2997_202630',
        '2025_2997_202657',
        '2025_2997_202726',
        '2025_2997_202754',
        '2025_2997_202822'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Abidjan 2'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_2997_202849',
        '2025_2997_202917',
        '2025_2997_202946',
        '2025_2997_203014',
        '2025_2997_203041',
        '2025_2997_203110',
        '2025_2997_203137',
        '2025_2997_203205',
        '2025_2997_203233',
        '2025_2997_203301',
        '2025_2997_203330',
        '2025_2997_203927'
    );
-- Santiago
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Santiago'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_3406_121340',
        '2025_3406_121408',
        '2025_3406_121436',
        '2025_3406_121504',
        '2025_3406_121533',
        '2025_3406_121600'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Santiago'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_3406_121628',
        '2025_3406_121656',
        '2025_3406_121725',
        '2025_3406_121753',
        '2025_3406_121821',
        '2025_3406_121849',
        '2025_3406_121917',
        '2025_3406_121944',
        '2025_3406_122012',
        '2025_3406_122040',
        '2025_3406_122108',
        '2025_3406_122136'
    );
-- Bordeaux
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Bordeaux'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_3824_101817',
        '2025_3824_101840',
        '2025_3824_101904',
        '2025_3824_101928'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Bordeaux'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_3824_101953',
        '2025_3824_102017',
        '2025_3824_102041',
        '2025_3824_102105',
        '2025_3824_102129',
        '2025_3824_102154',
        '2025_3824_102217',
        '2025_3824_102241'
    );
-- Bucharest
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Bucharest'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_4462_111847',
        '2025_4462_111917',
        '2025_4462_112018',
        '2025_4462_112047'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Bucharest'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_4462_112116',
        '2025_4462_112147',
        '2025_4462_112215',
        '2025_4462_112245',
        '2025_4462_112315',
        '2025_4462_112344',
        '2025_4462_112414',
        '2025_4462_112444'
    );
-- Savannah
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Savannah'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_5067_185416',
        '2025_5067_185444',
        '2025_5067_185513',
        '2025_5067_185541',
        '2025_5067_185609',
        '2025_5067_185637'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Savannah'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_5067_185705',
        '2025_5067_185733',
        '2025_5067_185801',
        '2025_5067_185829',
        '2025_5067_185857',
        '2025_5067_185925',
        '2025_5067_185953',
        '2025_5067_190022',
        '2025_5067_190050',
        '2025_5067_190118',
        '2025_5067_190146',
        '2025_5067_190214'
    );
-- Sarasota
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Sarasota'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_5067_192118',
        '2025_5067_192213',
        '2025_5067_192242',
        '2025_5067_192309',
        '2025_5067_192338',
        '2025_5067_192406'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Sarasota'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_5067_192434',
        '2025_5067_192502',
        '2025_5067_192530',
        '2025_5067_192558',
        '2025_5067_192626',
        '2025_5067_192654',
        '2025_5067_192722',
        '2025_5067_192750',
        '2025_5067_192818',
        '2025_5067_192846',
        '2025_5067_192915',
        '2025_5067_192943'
    );
-- Quimper
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Quimper'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_6239_025010',
        '2025_6239_025039',
        '2025_6239_025106',
        '2025_6239_025134',
        '2025_6239_025201',
        '2025_6239_025229'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Quimper'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_6239_025257',
        '2025_6239_025325',
        '2025_6239_025352',
        '2025_6239_025420',
        '2025_6239_025448',
        '2025_6239_025516',
        '2025_6239_025544',
        '2025_6239_025612',
        '2025_6239_025641',
        '2025_6239_025708',
        '2025_6239_025736',
        '2025_6239_025804'
    );
-- Campinas
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Campinas'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_6307_170329',
        '2025_6307_170356',
        '2025_6307_170424',
        '2025_6307_170453',
        '2025_6307_170521',
        '2025_6307_170549'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Campinas'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_6307_170617',
        '2025_6307_170644',
        '2025_6307_170713',
        '2025_6307_170741',
        '2025_6307_170808',
        '2025_6307_170836',
        '2025_6307_170904',
        '2025_6307_170932',
        '2025_6307_171000',
        '2025_6307_171029',
        '2025_6307_171056',
        '2025_6307_171125'
    );
-- Rio de Janeiro
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Rio de Janeiro'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_6932_173314',
        '2025_6932_173343',
        '2025_6932_173411',
        '2025_6932_173440'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Rio de Janeiro'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_6932_173507',
        '2025_6932_173536',
        '2025_6932_173604',
        '2025_6932_173632',
        '2025_6932_173700',
        '2025_6932_173728',
        '2025_6932_173756',
        '2025_6932_173824'
    );
-- New Delhi
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'New Delhi'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_6961_072605',
        '2025_6961_072633',
        '2025_6961_072701',
        '2025_6961_072729',
        '2025_6961_072757',
        '2025_6961_072825'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'New Delhi'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_6961_072852',
        '2025_6961_072920',
        '2025_6961_072948',
        '2025_6961_073016',
        '2025_6961_073044',
        '2025_6961_073112',
        '2025_6961_073139',
        '2025_6961_073207',
        '2025_6961_073234',
        '2025_6961_073302',
        '2025_6961_073330',
        '2025_6961_073358'
    );
-- Morelos
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Morelos'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_6963_172636',
        '2025_6963_172704',
        '2025_6963_172732',
        '2025_6963_172800',
        '2025_6963_172828',
        '2025_6963_172856'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Morelos'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_6963_172924',
        '2025_6963_172952',
        '2025_6963_173020',
        '2025_6963_173048',
        '2025_6963_173116',
        '2025_6963_173145',
        '2025_6963_173212',
        '2025_6963_173240',
        '2025_6963_173308',
        '2025_6963_173336',
        '2025_6963_173404',
        '2025_6963_173431'
    );
-- Guangzhou
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Guangzhou'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_6965_203028',
        '2025_6965_203107',
        '2025_6965_203142',
        '2025_6965_203219',
        '2025_6965_203248',
        '2025_6965_203327'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Guangzhou'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_6965_203358',
        '2025_6965_203440',
        '2025_6965_203508',
        '2025_6965_203542',
        '2025_6965_203615',
        '2025_6965_203653',
        '2025_6965_203722',
        '2025_6965_203759',
        '2025_6965_203840',
        '2025_6965_203910',
        '2025_6965_203949',
        '2025_6965_204018'
    );
-- Aix en Provence
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Aix en Provence'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7009_215613',
        '2025_7009_215652',
        '2025_7009_215837',
        '2025_7009_215915'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Aix en Provence'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7009_215953',
        '2025_7009_220040',
        '2025_7009_220108',
        '2025_7009_220138',
        '2025_7009_220224',
        '2025_7009_220252',
        '2025_7009_220333',
        '2025_7009_220412'
    );
-- Pune
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Pune'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7100_083437',
        '2025_7100_083505',
        '2025_7100_083533',
        '2025_7100_083601',
        '2025_7100_083629',
        '2025_7100_083640'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Pune'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7100_083708',
        '2025_7100_083736',
        '2025_7100_083804',
        '2025_7100_083831',
        '2025_7100_083859',
        '2025_7100_083927',
        '2025_7100_083955',
        '2025_7100_084023',
        '2025_7100_084050',
        '2025_7100_084118',
        '2025_7100_084146',
        '2025_7100_084213'
    );
-- Estoril
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Estoril'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7290_193338',
        '2025_7290_193424',
        '2025_7290_193453',
        '2025_7290_193527'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Estoril'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7290_193601',
        '2025_7290_193640',
        '2025_7290_193708',
        '2025_7290_193737',
        '2025_7290_193807',
        '2025_7290_193835',
        '2025_7290_193913',
        '2025_7290_193953'
    );
-- Bogota
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Bogota'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7389_095915',
        '2025_7389_100028',
        '2025_7389_100052',
        '2025_7389_100116',
        '2025_7389_100140',
        '2025_7389_100207'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Bogota'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7389_100231',
        '2025_7389_100255',
        '2025_7389_100319',
        '2025_7389_100343',
        '2025_7389_100407',
        '2025_7389_100431',
        '2025_7389_100455',
        '2025_7389_100519',
        '2025_7389_100542',
        '2025_7389_100607',
        '2025_7389_100631',
        '2025_7389_100655'
    );
-- Canberra
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Canberra'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7393_230250',
        '2025_7393_230318',
        '2025_7393_230413',
        '2025_7393_230441'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Canberra'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7393_230544',
        '2025_7393_230612',
        '2025_7393_230641',
        '2025_7393_230709',
        '2025_7393_230737',
        '2025_7393_230805',
        '2025_7393_230833',
        '2025_7393_230901',
        '2025_7393_230929',
        '2025_7393_230957',
        '2025_7393_231025',
        '2025_7393_231052'
    );
-- Gwangju
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Gwangju'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7490_183130',
        '2025_7490_183158',
        '2025_7490_183209',
        '2025_7490_183237',
        '2025_7490_183304',
        '2025_7490_183332'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Gwangju'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7490_183400',
        '2025_7490_183428',
        '2025_7490_183456',
        '2025_7490_183524',
        '2025_7490_183552',
        '2025_7490_183620',
        '2025_7490_183648',
        '2025_7490_183716',
        '2025_7490_183743',
        '2025_7490_183812',
        '2025_7490_183840',
        '2025_7490_183908'
    );
-- Barletta
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Barletta'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7494_174721',
        '2025_7494_174943',
        '2025_7494_175011',
        '2025_7494_175106',
        '2025_7494_175135',
        '2025_7494_175202'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Barletta'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7494_175231',
        '2025_7494_175259',
        '2025_7494_175327',
        '2025_7494_175355',
        '2025_7494_175423',
        '2025_7494_175453',
        '2025_7494_175521',
        '2025_7494_175549',
        '2025_7494_175617',
        '2025_7494_175644',
        '2025_7494_175712',
        '2025_7494_204038'
    );
-- Koblenz
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Koblenz'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7652_035736',
        '2025_7652_035804',
        '2025_7652_035832',
        '2025_7652_035900',
        '2025_7652_035928',
        '2025_7652_035956'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Koblenz'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7652_040024',
        '2025_7652_040051',
        '2025_7652_040119',
        '2025_7652_040148',
        '2025_7652_040215',
        '2025_7652_040243',
        '2025_7652_040311',
        '2025_7652_040322',
        '2025_7652_040350',
        '2025_7652_040419',
        '2025_7652_040448',
        '2025_7652_040515'
    );
-- Francavilla
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Francavilla'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7707_205048',
        '2025_7707_204856',
        '2025_7707_204924',
        '2025_7707_204952',
        '2025_7707_205020',
        '2025_7707_205116'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Francavilla'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7707_205143',
        '2025_7707_205211',
        '2025_7707_205239',
        '2025_7707_205307',
        '2025_7707_205336',
        '2025_7707_205403',
        '2025_7707_205431',
        '2025_7707_205459',
        '2025_7707_205528',
        '2025_7707_205556',
        '2025_7707_205625',
        '2025_7707_205652'
    );
-- Bengaluru
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Bengaluru'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7808_093513',
        '2025_7808_093540',
        '2025_7808_093608',
        '2025_7808_093637',
        '2025_7808_093705',
        '2025_7808_093733'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Bengaluru'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7808_093800',
        '2025_7808_093828',
        '2025_7808_093856',
        '2025_7808_093924',
        '2025_7808_093953',
        '2025_7808_094021',
        '2025_7808_094049',
        '2025_7808_094117',
        '2025_7808_094144',
        '2025_7808_094213',
        '2025_7808_094241',
        '2025_7808_094308'
    );
-- Chennai
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Chennai'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7849_055149',
        '2025_7849_055217',
        '2025_7849_055245',
        '2025_7849_055313',
        '2025_7849_055340',
        '2025_7849_055409'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Chennai'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7849_055436',
        '2025_7849_055504',
        '2025_7849_055532',
        '2025_7849_055600',
        '2025_7849_055628',
        '2025_7849_055655',
        '2025_7849_055723',
        '2025_7849_055751',
        '2025_7849_055818',
        '2025_7849_055846',
        '2025_7849_055914',
        '2025_7849_055942'
    );
-- Lille
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Lille'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7874_050551',
        '2025_7874_050619',
        '2025_7874_050647',
        '2025_7874_050715',
        '2025_7874_050743',
        '2025_7874_050811'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Lille'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7874_050839',
        '2025_7874_050907',
        '2025_7874_050934',
        '2025_7874_051002',
        '2025_7874_051030',
        '2025_7874_051058',
        '2025_7874_051126',
        '2025_7874_051154',
        '2025_7874_051222',
        '2025_7874_051249',
        '2025_7874_051317',
        '2025_7874_051345'
    );
-- Glasgow
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Glasgow'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7916_085722',
        '2025_7916_085751',
        '2025_7916_085819',
        '2025_7916_085847',
        '2025_7916_085914',
        '2025_7916_085943'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Glasgow'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_7916_090011',
        '2025_7916_090038',
        '2025_7916_090106',
        '2025_7916_090134',
        '2025_7916_090202',
        '2025_7916_090230',
        '2025_7916_090258',
        '2025_7916_090326',
        '2025_7916_090354',
        '2025_7916_090422',
        '2025_7916_090450',
        '2025_7916_090518'
    );
-- Mexico City
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Mexico City'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_8375_181225',
        '2025_8375_181253',
        '2025_8375_181322',
        '2025_8375_181350',
        '2025_8375_181418',
        '2025_8375_181446'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Mexico City'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_8375_181514',
        '2025_8375_181542',
        '2025_8375_181610',
        '2025_8375_181638',
        '2025_8375_181706',
        '2025_8375_181735',
        '2025_8375_181803',
        '2025_8375_181831',
        '2025_8375_181858',
        '2025_8375_181926',
        '2025_8375_181955',
        '2025_8375_182026'
    );
-- Santiago
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Santiago'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_8996_205431',
        '2025_8996_205459',
        '2025_8996_205527',
        '2025_8996_205555'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Santiago'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_8996_205623',
        '2025_8996_205651',
        '2025_8996_205719',
        '2025_8996_205747',
        '2025_8996_205815',
        '2025_8996_205843',
        '2025_8996_205911',
        '2025_8996_205939'
    );
-- Adelaide
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Adelaide'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_8998_113119',
        '2025_8998_113147',
        '2025_8998_113215',
        '2025_8998_113243'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Adelaide'
    AND tourney_level = 'ATP'
    AND match_id IN (
        '2025_8998_113310',
        '2025_8998_113338',
        '2025_8998_113405',
        '2025_8998_113434',
        '2025_8998_113502',
        '2025_8998_113529',
        '2025_8998_113557',
        '2025_8998_113625'
    );
-- Cleveland
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Cleveland'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9154_044307',
        '2025_9154_044335',
        '2025_9154_044402',
        '2025_9154_044430',
        '2025_9154_044458',
        '2025_9154_044526'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Cleveland'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9154_044554',
        '2025_9154_044622',
        '2025_9154_044650',
        '2025_9154_044718',
        '2025_9154_044746',
        '2025_9154_044814',
        '2025_9154_044842',
        '2025_9154_044910',
        '2025_9154_044938',
        '2025_9154_045006',
        '2025_9154_045033',
        '2025_9154_045101'
    );
-- Pau
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Pau'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9162_081131',
        '2025_9162_081159',
        '2025_9162_081227',
        '2025_9162_081255',
        '2025_9162_081324',
        '2025_9162_081352'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Pau'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9162_081419',
        '2025_9162_081447',
        '2025_9162_081515',
        '2025_9162_081542',
        '2025_9162_081611',
        '2025_9162_081639',
        '2025_9162_081707',
        '2025_9162_081804',
        '2025_9162_081832',
        '2025_9162_081900',
        '2025_9162_081928'
    );
-- Phoenix
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Phoenix'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9167_132027',
        '2025_9167_132123',
        '2025_9167_132219',
        '2025_9167_132247'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Phoenix'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9167_132315',
        '2025_9167_132343',
        '2025_9167_132411',
        '2025_9167_132439',
        '2025_9167_132507',
        '2025_9167_132535',
        '2025_9167_132603',
        '2025_9167_132631'
    );
-- Murcia
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Murcia'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9171_144435',
        '2025_9171_144503',
        '2025_9171_144531',
        '2025_9171_144559',
        '2025_9171_144627',
        '2025_9171_144655'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Murcia'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9171_144724',
        '2025_9171_144752',
        '2025_9171_144819',
        '2025_9171_144848',
        '2025_9171_144858',
        '2025_9171_144926',
        '2025_9171_144954',
        '2025_9171_145022',
        '2025_9171_145050',
        '2025_9171_145118',
        '2025_9171_145145',
        '2025_9171_145213'
    );
-- Concepcion
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Concepcion'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9452_161720',
        '2025_9452_161748',
        '2025_9452_161816',
        '2025_9452_161844',
        '2025_9452_161913',
        '2025_9452_161941'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Concepcion'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9452_162010',
        '2025_9452_162038',
        '2025_9452_162105',
        '2025_9452_162133',
        '2025_9452_162201',
        '2025_9452_162230',
        '2025_9452_162258',
        '2025_9452_162326',
        '2025_9452_162354',
        '2025_9452_162423',
        '2025_9452_162451',
        '2025_9452_162518'
    );
-- Zadar
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Zadar'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9472_150751',
        '2025_9472_150818',
        '2025_9472_150846',
        '2025_9472_150914',
        '2025_9472_150943',
        '2025_9472_151011'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Zadar'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9472_151039',
        '2025_9472_151107',
        '2025_9472_151136',
        '2025_9472_151204',
        '2025_9472_151233',
        '2025_9472_151301',
        '2025_9472_151330',
        '2025_9472_151358',
        '2025_9472_151426',
        '2025_9472_151455',
        '2025_9472_151523',
        '2025_9472_151551'
    );
-- Zagreb
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Zagreb'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9500_094054',
        '2025_9500_094118',
        '2025_9500_094142',
        '2025_9500_094207',
        '2025_9500_094230',
        '2025_9500_094254'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Zagreb'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9500_094318',
        '2025_9500_094342',
        '2025_9500_094407',
        '2025_9500_094431',
        '2025_9500_094454',
        '2025_9500_094518',
        '2025_9500_094542',
        '2025_9500_094613',
        '2025_9500_094637',
        '2025_9500_094701'
    );
-- Oeiras 3
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Oeiras 3'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9514_200922',
        '2025_9514_200951',
        '2025_9514_201021',
        '2025_9514_201050',
        '2025_9514_201120',
        '2025_9514_201131'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Oeiras 3'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9514_201159',
        '2025_9514_201229',
        '2025_9514_201257',
        '2025_9514_201324',
        '2025_9514_201354',
        '2025_9514_201424',
        '2025_9514_201452',
        '2025_9514_201522',
        '2025_9514_201552',
        '2025_9514_201620',
        '2025_9514_201648',
        '2025_9514_201716'
    );
-- Lugano
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Lugano'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9516_102117',
        '2025_9516_102128',
        '2025_9516_102156',
        '2025_9516_102224',
        '2025_9516_102252',
        '2025_9516_102320'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Lugano'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9516_102348',
        '2025_9516_102416',
        '2025_9516_102444',
        '2025_9516_102511',
        '2025_9516_102539',
        '2025_9516_102607',
        '2025_9516_102635',
        '2025_9516_102703',
        '2025_9516_102731',
        '2025_9516_102759',
        '2025_9516_102828',
        '2025_9516_102856'
    );
-- Tenerife
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Tenerife'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9623_064119',
        '2025_9623_064146',
        '2025_9623_064214',
        '2025_9623_064242',
        '2025_9623_064311',
        '2025_9623_064339'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Tenerife'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9623_064406',
        '2025_9623_064434',
        '2025_9623_064502',
        '2025_9623_064530',
        '2025_9623_064558',
        '2025_9623_064626',
        '2025_9623_064654',
        '2025_9623_064721',
        '2025_9623_064749',
        '2025_9623_064817'
    );
-- Manama
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Manama'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9635_070257',
        '2025_9635_070353',
        '2025_9635_070421',
        '2025_9635_070448',
        '2025_9635_070516',
        '2025_9635_070544'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Manama'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9635_070612',
        '2025_9635_070639',
        '2025_9635_070650',
        '2025_9635_070718',
        '2025_9635_070746',
        '2025_9635_070814',
        '2025_9635_070842',
        '2025_9635_070909',
        '2025_9635_070937',
        '2025_9635_071005',
        '2025_9635_071032',
        '2025_9635_071100'
    );
-- Buenos Aires 2
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Buenos Aires 2'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9678_020406',
        '2025_9678_020434',
        '2025_9678_020502',
        '2025_9678_020530',
        '2025_9678_020557',
        '2025_9678_020625'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Buenos Aires 2'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9678_020653',
        '2025_9678_020720',
        '2025_9678_020748',
        '2025_9678_020817',
        '2025_9678_020845',
        '2025_9678_020913',
        '2025_9678_020940',
        '2025_9678_021008',
        '2025_9678_021036',
        '2025_9678_021104',
        '2025_9678_021131',
        '2025_9678_021159'
    );
-- Madrid (M1000)
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Madrid'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9687_185843',
        '2025_9687_185911',
        '2025_9687_185939',
        '2025_9687_190007',
        '2025_9687_190035',
        '2025_9687_190103'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Madrid'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9687_190131',
        '2025_9687_190159',
        '2025_9687_190227',
        '2025_9687_190255',
        '2025_9687_190324',
        '2025_9687_190352',
        '2025_9687_190420',
        '2025_9687_190447',
        '2025_9687_190516',
        '2025_9687_190544',
        '2025_9687_190612',
        '2025_9687_190639'
    );
-- Mauthausen (CH)
UPDATE atp_simple
SET round_match = 'Q2'
WHERE tourney_name = 'Mauthausen'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9697_195958',
        '2025_9697_200046',
        '2025_9697_200451',
        '2025_9697_200525',
        '2025_9697_200602',
        '2025_9697_200646'
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE tourney_name = 'Mauthausen'
    AND tourney_level = 'CH'
    AND match_id IN (
        '2025_9697_200716',
        '2025_9697_200744',
        '2025_9697_200812',
        '2025_9697_200855',
        '2025_9697_200929',
        '2025_9697_201019',
        '2025_9697_201104',
        '2025_9697_201145'
    );
UPDATE atp_simple
SET tourney_level = 'CH'
WHERE match_id IN (
        '2025_2151_194005',
        '2025_2151_194033',
        '2025_2151_194101',
        '2025_2151_194129',
        '2025_2151_194158',
        '2025_2151_194226',
        '2025_2151_194254',
        '2025_2151_194324',
        '2025_2151_194352',
        '2025_2151_194420',
        '2025_2151_194448',
        '2025_2151_194518',
        '2025_2151_194546',
        '2025_2151_194614',
        '2025_2151_194642',
        '2025_2151_194710',
        '2025_2151_194738',
        '2025_2151_194806',
        '2025_9687_185843',
        '2025_9687_185911',
        '2025_9687_185939',
        '2025_9687_190007',
        '2025_9687_190035',
        '2025_9687_190103',
        '2025_9687_190131',
        '2025_9687_190159',
        '2025_9687_190227',
        '2025_9687_190255',
        '2025_9687_190324',
        '2025_9687_190352',
        '2025_9687_190420',
        '2025_9687_190447',
        '2025_9687_190516',
        '2025_9687_190544',
        '2025_9687_190612',
        '2025_9687_190639'
    );
UPDATE atp_simple
SET round_match = 'Q2'
where tourney_name = 'Brazzaville'
    and round_match = '';
UPDATE atp_simple
SET tourney_level = 'GS'
WHERE tourney_name = "Roland Garros";
UPDATE atp_simple
SET round_match = 'Q3'
WHERE match_id IN (
        "2025_0520_153305",
        "2025_0520_183932",
        "2025_0520_183956",
        "2025_0520_184020",
        "2025_0520_184044",
        "2025_0520_184108",
        "2025_0520_184131",
        "2025_0520_184155",
        "2025_0520_184219",
        "2025_0520_184243",
        "2025_0520_184307",
        "2025_0520_184331",
        "2025_0520_184354",
        "2025_0520_184418",
        "2025_0520_184442",
        "2025_0520_184506"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0520_184531",
        "2025_0520_221555",
        "2025_0520_184555",
        "2025_0520_184619",
        "2025_0520_184643",
        "2025_0520_184707",
        "2025_0520_184731",
        "2025_0520_184755",
        "2025_0520_184819",
        "2025_0520_184843",
        "2025_0520_184907",
        "2025_0520_184932",
        "2025_0520_184955",
        "2025_0520_185019",
        "2025_0520_185044",
        "2025_0520_185107",
        "2025_0520_185131",
        "2025_0520_185155",
        "2025_0520_185225",
        "2025_0520_185249",
        "2025_0520_185256",
        "2025_0520_185321",
        "2025_0520_185345",
        "2025_0520_185409",
        "2025_0520_185433",
        "2025_0520_185457",
        "2025_0520_185522",
        "2025_0520_185546",
        "2025_0520_185610",
        "2025_0520_185634",
        "2025_0520_185658",
        "2025_0520_185722",
        "2025_0520_185747"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0520_185810",
        "2025_0520_185834",
        "2025_0520_185859",
        "2025_0520_185923",
        "2025_0520_185947",
        "2025_0520_190011",
        "2025_0520_190035",
        "2025_0520_190059",
        "2025_0520_190123",
        "2025_0520_190148",
        "2025_0520_190212",
        "2025_0520_190236",
        "2025_0520_190300",
        "2025_0520_190324",
        "2025_0520_190349",
        "2025_0520_190413",
        "2025_0520_190437",
        "2025_0520_190501",
        "2025_0520_190525",
        "2025_0520_190549",
        "2025_0520_190613",
        "2025_0520_190637",
        "2025_0520_190701",
        "2025_0520_190725",
        "2025_0520_190749",
        "2025_0520_190813",
        "2025_0520_190837",
        "2025_0520_190901",
        "2025_0520_190925",
        "2025_0520_190949",
        "2025_0520_191013",
        "2025_0520_191037",
        "2025_0520_191101",
        "2025_0520_191125",
        "2025_0520_191149",
        "2025_0520_191214",
        "2025_0520_191238",
        "2025_0520_191301",
        "2025_0520_191325",
        "2025_0520_191349",
        "2025_0520_191413",
        "2025_0520_191437",
        "2025_0520_191502",
        "2025_0520_191526",
        "2025_0520_191550",
        "2025_0520_191614",
        "2025_0520_191638",
        "2025_0520_191703",
        "2025_0520_191727",
        "2025_0520_191751",
        "2025_0520_191815",
        "2025_0520_191839",
        "2025_0520_191903",
        "2025_0520_191927",
        "2025_0520_191951",
        "2025_0520_192015",
        "2025_0520_192039",
        "2025_0520_192103",
        "2025_0520_192127",
        "2025_0520_192151",
        "2025_0520_192215",
        "2025_0520_192239",
        "2025_0520_192303",
        "2025_0520_192328"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_2993_221142",
        "2025_2993_221206",
        "2025_2993_221230",
        "2025_2993_221255",
        "2025_2993_221319",
        "2025_2993_221343",
        "2025_2993_221408"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_2993_221432",
        "2025_2993_221457",
        "2025_2993_221522",
        "2025_2993_221547",
        "2025_2993_221611",
        "2025_2993_221636",
        "2025_2993_221700",
        "2025_2993_221724",
        "2025_2993_221747",
        "2025_2993_221811",
        "2025_2993_221834"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_7015_215144",
        "2025_7015_215208",
        "2025_7015_215233",
        "2025_7015_215257",
        "2025_7015_215322",
        "2025_7015_215345"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_7015_215409",
        "2025_7015_215432",
        "2025_7015_215457",
        "2025_7015_215522",
        "2025_7015_215545",
        "2025_7015_215610",
        "2025_7015_215634",
        "2025_7015_215658",
        "2025_7015_215723",
        "2025_7015_215747",
        "2025_7015_215811",
        "2025_7015_215835"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_9188_213230",
        "2025_9188_213255",
        "2025_9188_213319",
        "2025_9188_213342",
        "2025_9188_213406",
        "2025_9188_213431"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_9188_213455",
        "2025_9188_213520",
        "2025_9188_213544",
        "2025_9188_213607",
        "2025_9188_213632",
        "2025_9188_213656",
        "2025_9188_213720",
        "2025_9188_213745",
        "2025_9188_213809",
        "2025_9188_213839",
        "2025_9188_213903",
        "2025_9188_202840"
    );
select *
from atp_simple
where l_nac is null -- chequear
select *
from atp_simple
WHERE round_match = ''
select *
from atp_simple
where tourney_name = 'Roland Garros'