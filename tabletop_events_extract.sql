
use cabs;
SELECT 'Name'
,'Catalog Number'
,'Description'
,'BGG ID'
,'Is Play To Win'
-- ,'Publisher Name'
,'Min Players'
,'Max Players'
,'Min Play Time'
,'Max Play Time'
,'Age'
,'Is In Circulation'
,'Overall Condition'
,'Missing Components'
,'Game Weight'

UNION ALL

select 
cg.name,
cg.UPC as 'Catalog Number',
CASE 
WHEN cg.location LIKE 'bd%' THEN CONCAT("Blue Diamond"," ",RIGHT(cg.location,1)) 
WHEN cg.location LIKE 'ys%' THEN CONCAT("Yellow Sun"," ",RIGHT(cg.location,1)) 
WHEN cg.location LIKE 'gt%' THEN CONCAT("Green Triangle"," ",RIGHT(cg.location,1)) 
WHEN cg.location LIKE 'ph%' THEN CONCAT("Purple Heart"," ",RIGHT(cg.location,1)) 
WHEN cg.location LIKE 'rf%' THEN CONCAT("Red Flag"," ",RIGHT(cg.location,1)) 
WHEN cg.location LIKE 'gs%' THEN CONCAT("Grey Shield"," ",RIGHT(cg.location,1)) 
WHEN cg.location LIKE 'oc%' THEN CONCAT("Orange Circle"," ",RIGHT(cg.location,1)) 
WHEN cg.location LIKE 'ps%' THEN CONCAT("Pink Star"," ",RIGHT(cg.location,1)) 
WHEN cg.location LIKE 'bc%' THEN CONCAT("Brown Crown"," ",RIGHT(cg.location,1)) 
WHEN cg.location LIKE 'ps%' THEN CONCAT("Pink Star"," ",RIGHT(cg.location,1)) 
WHEN cg.location LIKE 'op%' THEN CONCAT("Orange Padlock"," ",RIGHT(cg.location,1)) 
WHEN cg.location LIKE 'tm%' THEN CONCAT("Turquoise Meeple"," ",RIGHT(cg.location,1)) 

ELSE cg.location
END as 'Description',
cg.bgg_id as 'BGG ID',
'' as 'Is Play To Win',
-- bg.publisher as 'Publisher Name',
bg.minplayers as 'Min Players',
bg.maxplayers as 'Max Players',
bg.playingtime as 'Min Play Time',
bg.playingtime as 'Max Play Time',
bg.minage as 'Age',
'1' as 'Is In Circulation',
'' as 'Overall Condition',
'' as 'Missing Components',
'' as 'Game Weight'


from cabs_games cg 
LEFT JOIN bgg_games bg on cg.bgg_id = bg.bgg_id
where cg.location not in 
('removed','gone','base','forsale','mia','kids')

INTO OUTFILE 'tabletop_events_extract_6.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'