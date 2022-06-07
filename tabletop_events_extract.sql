use cabs;
SELECT 'Name'
,'Catalog Number'
,'Description'
,'BGG ID'
,'Is Play To Win'
,'Publisher Name'
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
WHEN cg.location LIKE 'rp%' THEN CONCAT("Rainbow Puzzle"," ",RIGHT(cg.location,1)) 
WHEN cg.location LIKE 'br%' THEN CONCAT("Black Rook"," ",RIGHT(cg.location,1)) 
WHEN cg.location LIKE 'new' THEN 'Added Before Origins' 

ELSE cg.location
END as 'Description',
cg.bgg_id as 'BGG ID',
'' as 'Is Play To Win',
bg.publisher as 'Publisher Name',
CASE WHEN bg.minplayers = '' then '2' else bg.minplayers END as 'Min Players',
CASE WHEN bg.maxplayers = '' then '4' else bg.maxplayers END as 'Max Players',
CASE WHEN bg.playingtime = '' then '1' else bg.playingtime END as 'Min Play Time',
CASE WHEN bg.playingtime = '' then '1' else bg.playingtime END as 'Max Play Time',
CASE WHEN bg.minage = '' then '10' else bg.minage END as 'Age',
'1' as 'Is In Circulation',
'' as 'Overall Condition',
'' as 'Missing Components',
'' as 'Game Weight'


from cabs_games cg 
LEFT JOIN bgg_games bg on cg.bgg_id = bg.bgg_id
where cg.location not in 
('removed','gone','base','forsale','mia','kids')

INTO OUTFILE 'tabletop_events_origins_2022_2.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';