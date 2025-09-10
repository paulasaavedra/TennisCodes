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
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0460_193204",
        "2025_0460_193228",
        "2025_0460_193253",
        "2025_0460_193316",
        "2025_0460_193341",
        "2025_0460_193404"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0460_193428",
        "2025_0460_193452",
        "2025_0460_193500",
        "2025_0460_193524",
        "2025_0460_193548",
        "2025_0460_193613",
        "2025_0460_193637",
        "2025_0460_193701",
        "2025_0460_193726",
        "2025_0460_193750",
        "2025_0460_193814",
        "2025_0460_193839"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0558_195146",
        "2025_0558_195210",
        "2025_0558_195234",
        "2025_0558_195257",
        "2025_0558_195322",
        "2025_0558_195345"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0558_195409",
        "2025_0558_195434",
        "2025_0558_195458",
        "2025_0558_195520",
        "2025_0558_195545",
        "2025_0558_195608",
        "2025_0558_195632",
        "2025_0558_195657",
        "2025_0558_195721",
        "2025_0558_195745",
        "2025_0558_195809",
        "2025_0558_195834"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_2873_182308",
        "2025_2873_201139",
        "2025_2873_201204",
        "2025_2873_201229",
        "2025_2873_201312",
        "2025_2873_201337"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_2873_201401",
        "2025_2873_201426",
        "2025_2873_201452",
        "2025_2873_201516",
        "2025_2873_201540",
        "2025_2873_201605",
        "2025_2873_201628",
        "2025_2873_201653",
        "2025_2873_201717",
        "2025_2873_201743",
        "2025_2873_201807",
        "2025_2873_201831"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_2887_172907",
        "2025_2887_172931",
        "2025_2887_172956",
        "2025_2887_173020",
        "2025_2887_173045",
        "2025_2887_173109"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_2887_173133",
        "2025_2887_173158",
        "2025_2887_173222",
        "2025_2887_173251",
        "2025_2887_173317",
        "2025_2887_173341",
        "2025_2887_173405",
        "2025_2887_173430",
        "2025_2887_173454",
        "2025_2887_173518",
        "2025_2887_173542",
        "2025_2887_182706"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_4940_191159",
        "2025_4940_191225",
        "2025_4940_191250",
        "2025_4940_191314",
        "2025_4940_191339",
        "2025_4940_191404"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_4940_191428",
        "2025_4940_191452",
        "2025_4940_191516",
        "2025_4940_191541",
        "2025_4940_191605",
        "2025_4940_191628",
        "2025_4940_191653",
        "2025_4940_191717",
        "2025_4940_191742",
        "2025_4940_191806",
        "2025_4940_191831",
        "2025_4940_191855"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0311_174738",
        "2025_0311_174802",
        "2025_0311_174827",
        "2025_0311_174849"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0311_174913",
        "2025_0311_174937",
        "2025_0311_175001",
        "2025_0311_175025",
        "2025_0311_175049",
        "2025_0311_175113",
        "2025_0311_175137",
        "2025_0311_175201"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0321_135200",
        "2025_0321_135224",
        "2025_0321_135248",
        "2025_0321_135312"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0321_135336",
        "2025_0321_135400",
        "2025_0321_135424",
        "2025_0321_135448",
        "2025_0321_135512",
        "2025_0321_135537",
        "2025_0321_135601",
        "2025_0321_135625"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0440_144312",
        "2025_0440_144401",
        "2025_0440_144513",
        "2025_0440_144537"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0440_144601",
        "2025_0440_144626",
        "2025_0440_144650",
        "2025_0440_144713",
        "2025_0440_144737",
        "2025_0440_144802",
        "2025_0440_144826",
        "2025_0440_144850"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0500_180506",
        "2025_0500_180530",
        "2025_0500_180554",
        "2025_0500_180617"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0500_180641",
        "2025_0500_180705",
        "2025_0500_180729",
        "2025_0500_180753",
        "2025_0500_180816",
        "2025_0500_180840",
        "2025_0500_180904",
        "2025_0500_180928"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0741_183636",
        "2025_0741_183700",
        "2025_0741_183724",
        "2025_0741_183747"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0741_183811",
        "2025_0741_183835",
        "2025_0741_183858",
        "2025_0741_183923",
        "2025_0741_183947",
        "2025_0741_184011",
        "2025_0741_184035",
        "2025_0741_184059"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0786_193456",
        "2025_0786_193521",
        "2025_0786_193551",
        "2025_0786_193617",
        "2025_0786_193643",
        "2025_0786_193714"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0786_193737",
        "2025_0786_193801",
        "2025_0786_193826",
        "2025_0786_193856",
        "2025_0786_193926",
        "2025_0786_193950",
        "2025_0786_194013",
        "2025_0786_194037",
        "2025_0786_194101",
        "2025_0786_194129",
        "2025_0786_194153",
        "2025_0786_205117"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_4942_201601",
        "2025_4942_201625",
        "2025_4942_201649",
        "2025_4942_201713",
        "2025_4942_201738",
        "2025_4942_201803"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_4942_201827",
        "2025_4942_201852",
        "2025_4942_201915",
        "2025_4942_201939",
        "2025_4942_202004",
        "2025_4942_202033",
        "2025_4942_202058",
        "2025_4942_202127",
        "2025_4942_202157",
        "2025_4942_202222",
        "2025_4942_202252",
        "2025_4942_202316"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_7536_133348",
        "2025_7536_133412",
        "2025_7536_133436",
        "2025_7536_133500",
        "2025_7536_133523",
        "2025_7536_133547"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_7536_133611",
        "2025_7536_133636",
        "2025_7536_133700",
        "2025_7536_133724",
        "2025_7536_133748",
        "2025_7536_133811",
        "2025_7536_133835",
        "2025_7536_133900",
        "2025_7536_133924",
        "2025_7536_133948",
        "2025_7536_134012",
        "2025_7536_134036"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_7740_191311",
        "2025_7740_191400",
        "2025_7740_191425",
        "2025_7740_191515",
        "2025_7740_191545",
        "2025_7740_191610"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_7740_191634",
        "2025_7740_191702",
        "2025_7740_191726",
        "2025_7740_191755",
        "2025_7740_191820",
        "2025_7740_191850",
        "2025_7740_191916",
        "2025_7740_191940",
        "2025_7740_192011",
        "2025_7740_192036",
        "2025_7740_192101",
        "2025_7740_204413"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_8994_182051",
        "2025_8994_182115",
        "2025_8994_182139",
        "2025_8994_182203"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_8994_182227",
        "2025_8994_182251",
        "2025_8994_182315",
        "2025_8994_182339",
        "2025_8994_182403",
        "2025_8994_182426",
        "2025_8994_182450",
        "2025_8994_182514"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_9001_125359",
        "2025_9001_125422",
        "2025_9001_125446",
        "2025_9001_125511",
        "2025_9001_125535",
        "2025_9001_125559"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_9001_125622",
        "2025_9001_125646",
        "2025_9001_125710",
        "2025_9001_125734",
        "2025_9001_125758",
        "2025_9001_125823",
        "2025_9001_125847",
        "2025_9001_125911",
        "2025_9001_125935",
        "2025_9001_125959",
        "2025_9001_130023",
        "2025_9001_130047"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_9003_131358",
        "2025_9003_131421",
        "2025_9003_131445",
        "2025_9003_131509",
        "2025_9003_131533",
        "2025_9003_131558"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_9003_131622",
        "2025_9003_131646",
        "2025_9003_131710",
        "2025_9003_131734",
        "2025_9003_131759",
        "2025_9003_131823",
        "2025_9003_131847",
        "2025_9003_131911",
        "2025_9003_131936",
        "2025_9003_132000",
        "2025_9003_132024",
        "2025_9003_132048"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_9479_195550",
        "2025_9479_195615",
        "2025_9479_195640",
        "2025_9479_195704",
        "2025_9479_195729",
        "2025_9479_195752"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_9479_195816",
        "2025_9479_195842",
        "2025_9479_195908",
        "2025_9479_195932",
        "2025_9479_195956",
        "2025_9479_200020",
        "2025_9479_200044",
        "2025_9479_200109",
        "2025_9479_200133",
        "2025_9479_200157",
        "2025_9479_200238",
        "2025_9479_215156"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_9835_185358",
        "2025_9835_185422",
        "2025_9835_185447",
        "2025_9835_185511",
        "2025_9835_185534",
        "2025_9835_185559"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_9835_185622",
        "2025_9835_185646",
        "2025_9835_185710",
        "2025_9835_185744",
        "2025_9835_185808",
        "2025_9835_185832",
        "2025_9835_185856",
        "2025_9835_185921",
        "2025_9835_185945",
        "2025_9835_190008",
        "2025_9835_190032",
        "2025_9835_190057"
    );
UPDATE atp_simple
SET round_match = 'Q3'
WHERE match_id IN (
        "2025_0540_184110",
        "2025_0540_184134",
        "2025_0540_184158",
        "2025_0540_184222",
        "2025_0540_184246",
        "2025_0540_184310",
        "2025_0540_184334",
        "2025_0540_184358",
        "2025_0540_184422",
        "2025_0540_184446",
        "2025_0540_184511",
        "2025_0540_184535",
        "2025_0540_184559",
        "2025_0540_184623",
        "2025_0540_184647",
        "2025_0540_184710"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0540_184734",
        "2025_0540_184757",
        "2025_0540_184821",
        "2025_0540_184844",
        "2025_0540_184909",
        "2025_0540_184932",
        "2025_0540_184956",
        "2025_0540_185020",
        "2025_0540_185044",
        "2025_0540_185108",
        "2025_0540_185131",
        "2025_0540_185155",
        "2025_0540_185219",
        "2025_0540_185243",
        "2025_0540_185306",
        "2025_0540_185330",
        "2025_0540_185354",
        "2025_0540_185418",
        "2025_0540_185442",
        "2025_0540_185506",
        "2025_0540_185529",
        "2025_0540_185553",
        "2025_0540_185617",
        "2025_0540_185641",
        "2025_0540_185705",
        "2025_0540_185729",
        "2025_0540_185753",
        "2025_0540_185817",
        "2025_0540_185841",
        "2025_0540_185904",
        "2025_0540_185927",
        "2025_0540_185951"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0540_190015",
        "2025_0540_190039",
        "2025_0540_190103",
        "2025_0540_190127",
        "2025_0540_190151",
        "2025_0540_190216",
        "2025_0540_190239",
        "2025_0540_190304",
        "2025_0540_190328",
        "2025_0540_190351",
        "2025_0540_190414",
        "2025_0540_190438",
        "2025_0540_190502",
        "2025_0540_190526",
        "2025_0540_190550",
        "2025_0540_190613",
        "2025_0540_190637",
        "2025_0540_190700",
        "2025_0540_190725",
        "2025_0540_190748",
        "2025_0540_190812",
        "2025_0540_190836",
        "2025_0540_190900",
        "2025_0540_190924",
        "2025_0540_190948",
        "2025_0540_191012",
        "2025_0540_191035",
        "2025_0540_191059",
        "2025_0540_191123",
        "2025_0540_191146",
        "2025_0540_191210",
        "2025_0540_191235",
        "2025_0540_191258",
        "2025_0540_191322",
        "2025_0540_191347",
        "2025_0540_191411",
        "2025_0540_191436",
        "2025_0540_191459",
        "2025_0540_191523",
        "2025_0540_191547",
        "2025_0540_191611",
        "2025_0540_191635",
        "2025_0540_191659",
        "2025_0540_191723",
        "2025_0540_191747",
        "2025_0540_191811",
        "2025_0540_191834",
        "2025_0540_191859",
        "2025_0540_191923",
        "2025_0540_191946",
        "2025_0540_192010",
        "2025_0540_192034",
        "2025_0540_192057",
        "2025_0540_192122",
        "2025_0540_192146",
        "2025_0540_192210",
        "2025_0540_192234",
        "2025_0540_192258",
        "2025_0540_192321",
        "2025_0540_192345",
        "2025_0540_192409",
        "2025_0540_192433",
        "2025_0540_192457",
        "2025_0540_192521"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_1214_113618",
        "2025_1214_113642",
        "2025_1214_113706",
        "2025_1214_113730",
        "2025_1214_113758",
        "2025_1214_113822"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_1214_113846",
        "2025_1214_113909",
        "2025_1214_113933",
        "2025_1214_113957",
        "2025_1214_114021",
        "2025_1214_114045",
        "2025_1214_114109",
        "2025_1214_114133",
        "2025_1214_114157",
        "2025_1214_114221",
        "2025_1214_114245",
        "2025_1214_114309"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_2787_200640",
        "2025_2787_200704",
        "2025_2787_200728",
        "2025_2787_200752",
        "2025_2787_200817",
        "2025_2787_200840"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_2787_200905",
        "2025_2787_200928",
        "2025_2787_200952",
        "2025_2787_201016",
        "2025_2787_201040",
        "2025_2787_201104",
        "2025_2787_201127",
        "2025_2787_201151",
        "2025_2787_201215",
        "2025_2787_201239",
        "2025_2787_201303",
        "2025_2787_201327"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_2877_210426",
        "2025_2877_210450",
        "2025_2877_210514",
        "2025_2877_210538",
        "2025_2877_210602",
        "2025_2877_210627"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_2877_210651",
        "2025_2877_210716",
        "2025_2877_210739",
        "2025_2877_210803",
        "2025_2877_210827",
        "2025_2877_210851",
        "2025_2877_210914",
        "2025_2877_210939",
        "2025_2877_211003",
        "2025_2877_211027",
        "2025_2877_211050",
        "2025_2877_211114"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_2931_204442",
        "2025_2931_204506",
        "2025_2931_204530",
        "2025_2931_204554",
        "2025_2931_204618",
        "2025_2931_204642"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_2931_204705",
        "2025_2931_204729",
        "2025_2931_204753",
        "2025_2931_204817",
        "2025_2931_204842",
        "2025_2931_204905",
        "2025_2931_204929",
        "2025_2931_204953",
        "2025_2931_205017",
        "2025_2931_205041",
        "2025_2931_205105",
        "2025_2931_205129"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_3463_194651",
        "2025_3463_194714",
        "2025_3463_194738",
        "2025_3463_194802",
        "2025_3463_194826",
        "2025_3463_194850"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_3463_194914",
        "2025_3463_194939",
        "2025_3463_195003",
        "2025_3463_195027",
        "2025_3463_195051",
        "2025_3463_195115",
        "2025_3463_195140",
        "2025_3463_195204",
        "2025_3463_195228",
        "2025_3463_195252",
        "2025_3463_195316",
        "2025_3463_195340"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_7316_111805",
        "2025_7316_111854",
        "2025_7316_111917",
        "2025_7316_111941",
        "2025_7316_112005"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_7316_112029",
        "2025_7316_112053",
        "2025_7316_112251",
        "2025_7316_112315",
        "2025_7316_112339",
        "2025_7316_132029",
        "2025_7316_141411",
        "2025_7316_144745",
        "2025_7316_150933",
        "2025_7316_160706",
        "2025_7316_170318"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0314_145917",
        "2025_0314_145941",
        "2025_0314_150006",
        "2025_0314_150030"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0314_150054",
        "2025_0314_150118",
        "2025_0314_150142",
        "2025_0314_150205",
        "2025_0314_150229",
        "2025_0314_150253",
        "2025_0314_150318",
        "2025_0314_150341"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0315_184344",
        "2025_0315_184408",
        "2025_0315_184432",
        "2025_0315_184521",
        "2025_0315_184545",
        "2025_0315_184608"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0315_184631",
        "2025_0315_184655",
        "2025_0315_184719",
        "2025_0315_184743",
        "2025_0315_184807",
        "2025_0315_184831",
        "2025_0315_184855",
        "2025_0315_184918",
        "2025_0315_184942",
        "2025_0315_185006",
        "2025_0315_185030",
        "2025_0315_185054"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0316_151504",
        "2025_0316_151527",
        "2025_0316_151551",
        "2025_0316_151615"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0316_151640",
        "2025_0316_151704",
        "2025_0316_151727",
        "2025_0316_151752",
        "2025_0316_151816",
        "2025_0316_151840",
        "2025_0316_151903",
        "2025_0316_151927"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0472_215841",
        "2025_0472_215929",
        "2025_0472_215953",
        "2025_0472_220017",
        "2025_0472_220041",
        "2025_0472_220105"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0472_220129",
        "2025_0472_220154",
        "2025_0472_220218",
        "2025_0472_220241",
        "2025_0472_220306",
        "2025_0472_220329",
        "2025_0472_220354",
        "2025_0472_220418",
        "2025_0472_220442",
        "2025_0472_220506",
        "2025_0472_220530",
        "2025_0472_220554"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0526_193020",
        "2025_0526_193027",
        "2025_0526_193051",
        "2025_0526_193115",
        "2025_0526_193139",
        "2025_0526_193204"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0526_193228",
        "2025_0526_193252",
        "2025_0526_193316",
        "2025_0526_193340",
        "2025_0526_193404",
        "2025_0526_193428",
        "2025_0526_193452",
        "2025_0526_193516",
        "2025_0526_193539",
        "2025_0526_193603",
        "2025_0526_193627"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0877_211923",
        "2025_0877_211947",
        "2025_0877_212010",
        "2025_0877_212035",
        "2025_0877_212059",
        "2025_0877_212123"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0877_212147",
        "2025_0877_212211",
        "2025_0877_212235",
        "2025_0877_212259",
        "2025_0877_212323",
        "2025_0877_212347",
        "2025_0877_212415",
        "2025_0877_212440",
        "2025_0877_212504",
        "2025_0877_212528",
        "2025_0877_212552",
        "2025_0877_212616"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_3007_201317",
        "2025_3007_201341",
        "2025_3007_201405",
        "2025_3007_201429",
        "2025_3007_201452",
        "2025_3007_201517"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_3007_201540",
        "2025_3007_201604",
        "2025_3007_201628",
        "2025_3007_201652",
        "2025_3007_201716",
        "2025_3007_201740",
        "2025_3007_201804",
        "2025_3007_201828",
        "2025_3007_201853",
        "2025_3007_201917",
        "2025_3007_201941",
        "2025_3007_202004"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_7480_144348",
        "2025_7480_144412",
        "2025_7480_144436",
        "2025_7480_144500"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_7480_144524",
        "2025_7480_144548",
        "2025_7480_144617",
        "2025_7480_144641",
        "2025_7480_144705",
        "2025_7480_144729",
        "2025_7480_144753",
        "2025_7480_154934"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_7542_194327",
        "2025_7542_194351",
        "2025_7542_194415",
        "2025_7542_194439",
        "2025_7542_194502",
        "2025_7542_194526"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_7542_194550",
        "2025_7542_194614",
        "2025_7542_194638",
        "2025_7542_194702",
        "2025_7542_194726",
        "2025_7542_194751",
        "2025_7542_194814",
        "2025_7542_194838",
        "2025_7542_194902",
        "2025_7542_194926",
        "2025_7542_194950",
        "2025_7542_195013"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_8394_190357",
        "2025_8394_190422",
        "2025_8394_190446",
        "2025_8394_190510",
        "2025_8394_190534",
        "2025_8394_190558"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_8394_190623",
        "2025_8394_190646",
        "2025_8394_190710",
        "2025_8394_190734",
        "2025_8394_190758",
        "2025_8394_190822",
        "2025_8394_190846",
        "2025_8394_190910",
        "2025_8394_190934",
        "2025_8394_190958",
        "2025_8394_191021",
        "2025_8394_191046"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_9198_213917",
        "2025_9198_213942",
        "2025_9198_214006",
        "2025_9198_214030",
        "2025_9198_214054",
        "2025_9198_214118"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_9198_214142",
        "2025_9198_214206",
        "2025_9198_214230",
        "2025_9198_214254",
        "2025_9198_214319",
        "2025_9198_214343",
        "2025_9198_214406",
        "2025_9198_214429",
        "2025_9198_214453",
        "2025_9198_214517",
        "2025_9198_214540",
        "2025_9198_214604"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_9351_192346",
        "2025_9351_192409",
        "2025_9351_192434",
        "2025_9351_192458",
        "2025_9351_192522",
        "2025_9351_192546"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_9351_192609",
        "2025_9351_192633",
        "2025_9351_192656",
        "2025_9351_192721",
        "2025_9351_192744",
        "2025_9351_192808",
        "2025_9351_192833",
        "2025_9351_192856",
        "2025_9351_192920",
        "2025_9351_192944",
        "2025_9351_193008",
        "2025_9351_193032"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_9540_210000",
        "2025_9540_210024",
        "2025_9540_210048",
        "2025_9540_210112",
        "2025_9540_210136",
        "2025_9540_210201"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_9540_210225",
        "2025_9540_210248",
        "2025_9540_210312",
        "2025_9540_210336",
        "2025_9540_210401",
        "2025_9540_210424",
        "2025_9540_210449",
        "2025_9540_210512",
        "2025_9540_210536",
        "2025_9540_210600",
        "2025_9540_210624",
        "2025_9540_210648"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0319_174740",
        "2025_0319_174804",
        "2025_0319_174828",
        "2025_0319_174851"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0319_174916",
        "2025_0319_174940",
        "2025_0319_175005",
        "2025_0319_175029",
        "2025_0319_175052",
        "2025_0319_175116",
        "2025_0319_175140",
        "2025_0319_175204"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0418_182546",
        "2025_0418_182610",
        "2025_0418_182634",
        "2025_0418_182657",
        "2025_0418_182721",
        "2025_0418_182745"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0418_182808",
        "2025_0418_182832",
        "2025_0418_182856",
        "2025_0418_182920",
        "2025_0418_182944",
        "2025_0418_183008",
        "2025_0418_183032",
        "2025_0418_183056",
        "2025_0418_183119",
        "2025_0418_183143",
        "2025_0418_183207",
        "2025_0418_183231"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0439_180308",
        "2025_0439_180356",
        "2025_0439_180420",
        "2025_0439_180444"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0439_180508",
        "2025_0439_180531",
        "2025_0439_180601",
        "2025_0439_180625",
        "2025_0439_180649",
        "2025_0439_180713",
        "2025_0439_180737",
        "2025_0439_183705"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0221_184532",
        "2025_0221_184556",
        "2025_0221_184621",
        "2025_0221_184645",
        "2025_0221_184709",
        "2025_0221_184732"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0221_184756",
        "2025_0221_184820",
        "2025_0221_184844",
        "2025_0221_184909",
        "2025_0221_184932",
        "2025_0221_184956",
        "2025_0221_185020",
        "2025_0221_185044",
        "2025_0221_185108",
        "2025_0221_185136",
        "2025_0221_185200",
        "2025_0221_185224"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0783_182547",
        "2025_0783_182611",
        "2025_0783_182635",
        "2025_0783_182659",
        "2025_0783_182722",
        "2025_0783_182746"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0783_182810",
        "2025_0783_182834",
        "2025_0783_182858",
        "2025_0783_182921",
        "2025_0783_182945",
        "2025_0783_183009",
        "2025_0783_183033",
        "2025_0783_183056",
        "2025_0783_183120",
        "2025_0783_183144",
        "2025_0783_183206",
        "2025_0783_183231"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_2785_174615",
        "2025_2785_174639",
        "2025_2785_174703",
        "2025_2785_174727",
        "2025_2785_174751",
        "2025_2785_174814"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_2785_174838",
        "2025_2785_174902",
        "2025_2785_174926",
        "2025_2785_174949",
        "2025_2785_175013",
        "2025_2785_175037",
        "2025_2785_175101",
        "2025_2785_175125",
        "2025_2785_175149",
        "2025_2785_175213",
        "2025_2785_175236",
        "2025_2785_175300"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_2883_180508",
        "2025_2883_180621",
        "2025_2883_180645",
        "2025_2883_180732",
        "2025_2883_180756",
        "2025_2883_180820"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_2883_180844",
        "2025_2883_180907",
        "2025_2883_180931",
        "2025_2883_180955",
        "2025_2883_181019",
        "2025_2883_181042",
        "2025_2883_181106",
        "2025_2883_181130",
        "2025_2883_181154",
        "2025_2883_181217",
        "2025_2883_181241",
        "2025_2883_181305"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0421_184418",
        "2025_0421_184443",
        "2025_0421_184506",
        "2025_0421_184531",
        "2025_0421_184555",
        "2025_0421_184618",
        "2025_0421_184642",
        "2025_0421_184705",
        "2025_0421_184729",
        "2025_0421_184754",
        "2025_0421_184818",
        "2025_0421_184842",
        "2025_0421_184906",
        "2025_0421_184931",
        "2025_0421_184954",
        "2025_0421_185018"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0586_184244",
        "2025_0586_184308",
        "2025_0586_184332",
        "2025_0586_184356",
        "2025_0586_184420",
        "2025_0586_184444"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0586_184508",
        "2025_0586_184532",
        "2025_0586_184557",
        "2025_0586_184620",
        "2025_0586_184644",
        "2025_0586_184708",
        "2025_0586_184732",
        "2025_0586_184756",
        "2025_0586_184820",
        "2025_0586_184844",
        "2025_0586_184908",
        "2025_0586_184932"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_6795_192222",
        "2025_6795_192245",
        "2025_6795_192309",
        "2025_6795_192333",
        "2025_6795_192357",
        "2025_6795_192422"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_6795_192446",
        "2025_6795_192510",
        "2025_6795_192534",
        "2025_6795_192557",
        "2025_6795_192621",
        "2025_6795_192644",
        "2025_6795_192708",
        "2025_6795_192732",
        "2025_6795_192756",
        "2025_6795_192820",
        "2025_6795_192844",
        "2025_6795_192908"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_9526_182255",
        "2025_9526_182319",
        "2025_9526_182344",
        "2025_9526_182407",
        "2025_9526_182431",
        "2025_9526_182455"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_9526_182519",
        "2025_9526_182543",
        "2025_9526_182607",
        "2025_9526_182631",
        "2025_9526_182655",
        "2025_9526_182719",
        "2025_9526_182743",
        "2025_9526_182807",
        "2025_9526_182831",
        "2025_9526_182855",
        "2025_9526_182919",
        "2025_9526_182943"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_9533_194142",
        "2025_9533_194230",
        "2025_9533_194254",
        "2025_9533_194318",
        "2025_9533_194343",
        "2025_9533_194407"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_9533_194431",
        "2025_9533_194455",
        "2025_9533_194519",
        "2025_9533_194544",
        "2025_9533_194607",
        "2025_9533_194632",
        "2025_9533_194656",
        "2025_9533_194720",
        "2025_9533_194743",
        "2025_9533_194807",
        "2025_9533_194831",
        "2025_9533_194855"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_9542_190232",
        "2025_9542_190255",
        "2025_9542_190319",
        "2025_9542_190343",
        "2025_9542_190408",
        "2025_9542_190432"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_9542_190455",
        "2025_9542_190520",
        "2025_9542_190544",
        "2025_9542_190607",
        "2025_9542_190631",
        "2025_9542_190656",
        "2025_9542_190719",
        "2025_9542_190743",
        "2025_9542_190808",
        "2025_9542_190831",
        "2025_9542_190856",
        "2025_9542_190920"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0422_130810",
        "2025_0422_130834",
        "2025_0422_130859",
        "2025_0422_130923",
        "2025_0422_130946",
        "2025_0422_131011",
        "2025_0422_131035",
        "2025_0422_131059",
        "2025_0422_131123",
        "2025_0422_131148",
        "2025_0422_131213",
        "2025_0422_131237"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0422_131302",
        "2025_0422_131326",
        "2025_0422_131351",
        "2025_0422_131415",
        "2025_0422_131438",
        "2025_0422_131502",
        "2025_0422_131527",
        "2025_0422_131551",
        "2025_0422_131616",
        "2025_0422_131640",
        "2025_0422_131705",
        "2025_0422_131728",
        "2025_0422_131752",
        "2025_0422_131817",
        "2025_0422_131841",
        "2025_0422_131906",
        "2025_0422_131930",
        "2025_0422_131955",
        "2025_0422_132019",
        "2025_0422_132054",
        "2025_0422_132118",
        "2025_0422_132143",
        "2025_0422_132207",
        "2025_0422_132231"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_2043_111129",
        "2025_2043_111154",
        "2025_2043_111218",
        "2025_2043_111243",
        "2025_2043_111307",
        "2025_2043_111332"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_2043_111356",
        "2025_2043_111421",
        "2025_2043_111445",
        "2025_2043_111509",
        "2025_2043_111534",
        "2025_2043_111558",
        "2025_2043_111622",
        "2025_2043_111646",
        "2025_2043_111710",
        "2025_2043_111734",
        "2025_2043_111758",
        "2025_2043_111822"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_2120_193908",
        "2025_2120_193932",
        "2025_2120_193956",
        "2025_2120_194020",
        "2025_2120_194044",
        "2025_2120_194108"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_2120_194132",
        "2025_2120_194157",
        "2025_2120_194221",
        "2025_2120_194245",
        "2025_2120_194308",
        "2025_2120_194332",
        "2025_2120_194356",
        "2025_2120_194419",
        "2025_2120_194442",
        "2025_2120_194506",
        "2025_2120_194530",
        "2025_2120_194554"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_2789_184042",
        "2025_2789_184106",
        "2025_2789_184129",
        "2025_2789_184153",
        "2025_2789_184216",
        "2025_2789_184240"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_2789_184305",
        "2025_2789_184329",
        "2025_2789_184353",
        "2025_2789_184417",
        "2025_2789_184441",
        "2025_2789_184506",
        "2025_2789_184530",
        "2025_2789_184553",
        "2025_2789_184617",
        "2025_2789_184642",
        "2025_2789_184705",
        "2025_2789_184729"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_2797_185950",
        "2025_2797_190038",
        "2025_2797_190101",
        "2025_2797_190125",
        "2025_2797_190149",
        "2025_2797_190214"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_2797_190238",
        "2025_2797_190303",
        "2025_2797_190327",
        "2025_2797_190351",
        "2025_2797_190415",
        "2025_2797_190439",
        "2025_2797_190503",
        "2025_2797_190526",
        "2025_2797_190550",
        "2025_2797_190614",
        "2025_2797_190638",
        "2025_2797_190702"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_2935_191955",
        "2025_2935_192001",
        "2025_2935_192026",
        "2025_2935_192049",
        "2025_2935_192113",
        "2025_2935_192137"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_2935_192202",
        "2025_2935_192226",
        "2025_2935_192249",
        "2025_2935_192313",
        "2025_2935_192337",
        "2025_2935_192400",
        "2025_2935_192424",
        "2025_2935_192448",
        "2025_2935_192511",
        "2025_2935_192535",
        "2025_2935_192558",
        "2025_2935_192622"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_2945_152324",
        "2025_2945_152348",
        "2025_2945_152412",
        "2025_2945_152436",
        "2025_2945_152500",
        "2025_2945_152525"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_2945_152549",
        "2025_2945_152612",
        "2025_2945_152637",
        "2025_2945_152701",
        "2025_2945_152726",
        "2025_2945_152750",
        "2025_2945_152814",
        "2025_2945_152838",
        "2025_2945_152902",
        "2025_2945_152927",
        "2025_2945_152952",
        "2025_2945_153016"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_3009_112955",
        "2025_3009_113019",
        "2025_3009_113043",
        "2025_3009_113107"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_3009_113132",
        "2025_3009_113156",
        "2025_3009_113226",
        "2025_3009_113250",
        "2025_3009_113315",
        "2025_3009_113339",
        "2025_3009_113404",
        "2025_3009_134527"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_3017_120648",
        "2025_3017_120712",
        "2025_3017_120737",
        "2025_3017_120801",
        "2025_3017_120825",
        "2025_3017_120850"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_3017_120915",
        "2025_3017_120941",
        "2025_3017_121007",
        "2025_3017_121032",
        "2025_3017_121058",
        "2025_3017_121125",
        "2025_3017_121149",
        "2025_3017_121214",
        "2025_3017_121238",
        "2025_3017_121302",
        "2025_3017_121327",
        "2025_3017_121351"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_3019_160149",
        "2025_3019_160214",
        "2025_3019_160238",
        "2025_3019_160303",
        "2025_3019_160327",
        "2025_3019_160352"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_3019_160416",
        "2025_3019_160440",
        "2025_3019_160504",
        "2025_3019_160529",
        "2025_3019_160553",
        "2025_3019_160618",
        "2025_3019_160642",
        "2025_3019_160706",
        "2025_3019_160731",
        "2025_3019_160755",
        "2025_3019_160819",
        "2025_3019_160844"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_3025_122530",
        "2025_3025_122554",
        "2025_3025_122619",
        "2025_3025_122643"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_3025_122707",
        "2025_3025_122732",
        "2025_3025_122755",
        "2025_3025_122820",
        "2025_3025_122901",
        "2025_3025_145930"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_6242_162719",
        "2025_6242_162744",
        "2025_6242_162808",
        "2025_6242_162831"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_6242_162855",
        "2025_6242_162919",
        "2025_6242_162944",
        "2025_6242_163008",
        "2025_6242_163032",
        "2025_6242_163057",
        "2025_6242_163121",
        "2025_6242_163145"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_6250_114644",
        "2025_6250_114709",
        "2025_6250_114733",
        "2025_6250_114756",
        "2025_6250_114821",
        "2025_6250_114845"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_6250_114909",
        "2025_6250_114934",
        "2025_6250_114958",
        "2025_6250_115023",
        "2025_6250_115047",
        "2025_6250_115111",
        "2025_6250_115135",
        "2025_6250_115200",
        "2025_6250_115223",
        "2025_6250_115247",
        "2025_6250_115312",
        "2025_6250_115336"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_8266_154301",
        "2025_8266_154326",
        "2025_8266_154351",
        "2025_8266_154415",
        "2025_8266_154439",
        "2025_8266_154504"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_8266_154528",
        "2025_8266_154552",
        "2025_8266_154617",
        "2025_8266_154641",
        "2025_8266_154705",
        "2025_8266_154730",
        "2025_8266_154753",
        "2025_8266_154817",
        "2025_8266_154841"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_8392_105147",
        "2025_8392_105211",
        "2025_8392_105243",
        "2025_8392_105308",
        "2025_8392_105331",
        "2025_8392_105356"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_8392_105420",
        "2025_8392_105444",
        "2025_8392_105508",
        "2025_8392_105533",
        "2025_8392_105557",
        "2025_8392_105622",
        "2025_8392_105646",
        "2025_8392_105710",
        "2025_8392_105735",
        "2025_8392_105759",
        "2025_8392_105823",
        "2025_8392_133615"
    );
UPDATE atp_simple
SET round_match = 'Q3'
WHERE match_id IN (
        "2025_0560_121805",
        "2025_0560_121829",
        "2025_0560_121853",
        "2025_0560_121918",
        "2025_0560_121941",
        "2025_0560_122004",
        "2025_0560_122029",
        "2025_0560_122053",
        "2025_0560_122117",
        "2025_0560_122141",
        "2025_0560_122205",
        "2025_0560_122229",
        "2025_0560_122253",
        "2025_0560_122317",
        "2025_0560_122341",
        "2025_0560_122406"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0560_122430",
        "2025_0560_122454",
        "2025_0560_122518",
        "2025_0560_122542",
        "2025_0560_122607",
        "2025_0560_122631",
        "2025_0560_122654",
        "2025_0560_122718",
        "2025_0560_122742",
        "2025_0560_122807",
        "2025_0560_122831",
        "2025_0560_122855",
        "2025_0560_122919",
        "2025_0560_122942",
        "2025_0560_123006",
        "2025_0560_123031",
        "2025_0560_123054",
        "2025_0560_123119",
        "2025_0560_123143",
        "2025_0560_123206",
        "2025_0560_123230",
        "2025_0560_123255",
        "2025_0560_123319",
        "2025_0560_123343",
        "2025_0560_123408",
        "2025_0560_123432",
        "2025_0560_123456",
        "2025_0560_123519",
        "2025_0560_123543",
        "2025_0560_123608",
        "2025_0560_123632",
        "2025_0560_123656"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0560_123721",
        "2025_0560_123745",
        "2025_0560_123809",
        "2025_0560_123833",
        "2025_0560_123857",
        "2025_0560_123921",
        "2025_0560_123946",
        "2025_0560_124010",
        "2025_0560_124034",
        "2025_0560_124058",
        "2025_0560_124122",
        "2025_0560_124146",
        "2025_0560_124210",
        "2025_0560_124235",
        "2025_0560_124259",
        "2025_0560_124323",
        "2025_0560_124347",
        "2025_0560_124412",
        "2025_0560_124436",
        "2025_0560_124500",
        "2025_0560_124525",
        "2025_0560_124549",
        "2025_0560_124612",
        "2025_0560_124637",
        "2025_0560_124701",
        "2025_0560_124725",
        "2025_0560_124749",
        "2025_0560_124814",
        "2025_0560_124838",
        "2025_0560_124903",
        "2025_0560_124927",
        "2025_0560_124952",
        "2025_0560_125015",
        "2025_0560_125039",
        "2025_0560_125111",
        "2025_0560_125135",
        "2025_0560_125200",
        "2025_0560_125224",
        "2025_0560_125248",
        "2025_0560_125312",
        "2025_0560_125337",
        "2025_0560_125401",
        "2025_0560_125425",
        "2025_0560_125449",
        "2025_0560_125514",
        "2025_0560_125538",
        "2025_0560_125603",
        "2025_0560_125627",
        "2025_0560_125651",
        "2025_0560_125716",
        "2025_0560_125740",
        "2025_0560_125804",
        "2025_0560_125828",
        "2025_0560_125853",
        "2025_0560_125917",
        "2025_0560_125941",
        "2025_0560_130006",
        "2025_0560_130030",
        "2025_0560_130054",
        "2025_0560_130119",
        "2025_0560_130143",
        "2025_0560_130207",
        "2025_0560_130231",
        "2025_0560_142704"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_0784_192445",
        "2025_0784_192510",
        "2025_0784_192533",
        "2025_0784_192557",
        "2025_0784_192621",
        "2025_0784_192646"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_0784_192710",
        "2025_0784_192735",
        "2025_0784_192759",
        "2025_0784_192823",
        "2025_0784_192847",
        "2025_0784_192911",
        "2025_0784_192935",
        "2025_0784_193000",
        "2025_0784_193024",
        "2025_0784_193049",
        "2025_0784_193113",
        "2025_0784_193138"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_1763_200440",
        "2025_1763_200504",
        "2025_1763_200528",
        "2025_1763_200552",
        "2025_1763_200622",
        "2025_1763_200646"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_1763_200710",
        "2025_1763_200735",
        "2025_1763_200759",
        "2025_1763_200823",
        "2025_1763_200847",
        "2025_1763_200912",
        "2025_1763_200936",
        "2025_1763_201000",
        "2025_1763_201024",
        "2025_1763_201049",
        "2025_1763_201113",
        "2025_1763_201138"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_2933_182509",
        "2025_2933_182558",
        "2025_2933_182622",
        "2025_2933_182647",
        "2025_2933_182711",
        "2025_2933_182735"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_2933_182751",
        "2025_2933_182815",
        "2025_2933_182840",
        "2025_2933_182904",
        "2025_2933_182928",
        "2025_2933_182953",
        "2025_2933_183019",
        "2025_2933_183043",
        "2025_2933_183108",
        "2025_2933_183132",
        "2025_2933_183156"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_3473_180536",
        "2025_3473_180601",
        "2025_3473_180624",
        "2025_3473_180648",
        "2025_3473_180712",
        "2025_3473_180736"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_3473_180800",
        "2025_3473_180824",
        "2025_3473_180848",
        "2025_3473_180912",
        "2025_3473_180936",
        "2025_3473_181001",
        "2025_3473_181026",
        "2025_3473_181050",
        "2025_3473_181115",
        "2025_3473_181139",
        "2025_3473_181203",
        "2025_3473_181227"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_6313_194430",
        "2025_6313_194519",
        "2025_6313_194543",
        "2025_6313_194608",
        "2025_6313_194632",
        "2025_6313_194656"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_6313_194721",
        "2025_6313_194745",
        "2025_6313_194809",
        "2025_6313_194834",
        "2025_6313_194858",
        "2025_6313_194923",
        "2025_6313_194947",
        "2025_6313_195011",
        "2025_6313_195036",
        "2025_6313_195101",
        "2025_6313_195125",
        "2025_6313_195149"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_7083_204348",
        "2025_7083_204412",
        "2025_7083_204436",
        "2025_7083_204500",
        "2025_7083_204524",
        "2025_7083_204548"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_7083_204613",
        "2025_7083_204637",
        "2025_7083_204701",
        "2025_7083_204726",
        "2025_7083_204749",
        "2025_7083_204813",
        "2025_7083_204837",
        "2025_7083_204902",
        "2025_7083_204926",
        "2025_7083_204950",
        "2025_7083_205014",
        "2025_7083_205038"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_7783_175937",
        "2025_7783_184505",
        "2025_7783_184530",
        "2025_7783_184554",
        "2025_7783_184618",
        "2025_7783_184642"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_7783_184706",
        "2025_7783_184731",
        "2025_7783_184755",
        "2025_7783_184820",
        "2025_7783_184844",
        "2025_7783_184908",
        "2025_7783_184932",
        "2025_7783_184957",
        "2025_7783_185021",
        "2025_7783_185045",
        "2025_7783_185110",
        "2025_7783_185133"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_7973_190452",
        "2025_7973_190516",
        "2025_7973_190539",
        "2025_7973_190604",
        "2025_7973_190628",
        "2025_7973_190653"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_7973_190717",
        "2025_7973_190741",
        "2025_7973_190806",
        "2025_7973_190830",
        "2025_7973_190854",
        "2025_7973_190918",
        "2025_7973_190942",
        "2025_7973_191006",
        "2025_7973_191030",
        "2025_7973_191054",
        "2025_7973_191118",
        "2025_7973_191143"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_9120_210346",
        "2025_9120_210420",
        "2025_9120_210445",
        "2025_9120_210509",
        "2025_9120_210533",
        "2025_9120_210557"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_9120_210622",
        "2025_9120_210646",
        "2025_9120_210709",
        "2025_9120_210733",
        "2025_9120_210757",
        "2025_9120_210822",
        "2025_9120_210846",
        "2025_9120_210910",
        "2025_9120_210935",
        "2025_9120_210959",
        "2025_9120_211023",
        "2025_9120_211048"
    );
UPDATE atp_simple
SET round_match = 'Q2'
WHERE match_id IN (
        "2025_9556_191800",
        "2025_9556_202438",
        "2025_9556_202503",
        "2025_9556_202528",
        "2025_9556_202552",
        "2025_9556_202615"
    );
UPDATE atp_simple
SET round_match = 'Q1'
WHERE match_id IN (
        "2025_9556_202640",
        "2025_9556_202702",
        "2025_9556_202727",
        "2025_9556_202751",
        "2025_9556_202815",
        "2025_9556_202839",
        "2025_9556_202904",
        "2025_9556_202928",
        "2025_9556_203000",
        "2025_9556_203024",
        "2025_9556_203048"
    );
UPDATE atp_simple
SET best = 3
WHERE TOURNEY_LEVEL IN ('CH', 'ATP', 'M1000')
    AND (
        best IS NULL
        OR best = 0
        OR best = 1
    );
UPDATE atp_simple
SET best = 5
WHERE TOURNEY_LEVEL = 'GS'
    AND (
        best IS NULL
        OR best = 0
        OR best = 1
    );
UPDATE atp_simple
SET TOURNEY_LEVEL = 'GS'
WHERE TOURNEY_NAME = 'Wimbledon';
UPDATE atp_simple
SET TOURNEY_LEVEL = 'GS'
WHERE TOURNEY_NAME = 'US Open';
UPDATE atp_simple
SET TOURNEY_NAME = 'US Open'
WHERE TOURNEY_NAME = 'Us Open';
UPDATE atp_simple
SET l_player = REPLACE(
        l_player,
        'Santiago Fa Rodriguez Taverna',
        'Santiago Rodriguez Taverna'
    )
WHERE l_player LIKE '%Santiago Fa Rodriguez Taverna%';
UPDATE atp_simple
SET w_player = REPLACE(
        w_player,
        'Santiago Fa Rodriguez Taverna',
        'Santiago Rodriguez Taverna'
    )
WHERE w_player LIKE '%Santiago Fa Rodriguez Taverna%';
-----------------
select *
from atp_simple
where w_nac is null -- chequear
select *
from atp_simple
WHERE round_match = '';
select *
from atp_simple
where best = 0;
-- mysql -u root -p -D tennis_db -e "SELECT * FROM atp_simple;" > "/Users/paula/Documents/TennisData/TennisData/database/atp_simple.csv"
SELECT *
FROM atp_simple INTO OUTFILE '/Users/paula/Documents/TennisData/TennisData/database/atp_simple.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';