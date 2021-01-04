----test : tous les festivals auqel le film 'Amanda' participe entre les deuc dates
select liste_festivals('Amanda','01/01/2019','01/05/2020');

   --test : tous les prix obtenus par le 'film Belle et la belle (La)' dans le festival 'Festival Résistances - Foix'
 select liste_prix('Positive school','Festival international du film d''animation d''Annecy');

-----test : liste de tous les films qui participent au festival 'FESTIVAL CURIEUX VOYAGEURS'
 select liste_films('FESTIVAL CURIEUX VOYAGEURS');  --un festival qui n'existe pas dans la base on aura 0 lignes 
 select liste_films('Traverse Vidéo - Toulouse');   --ce festival existe dans la base

----test : affiche le film qui a eu le prix du jury au festival 'Festival Petites Bobines' 
 select prix_festival('L’ACID à Cannes','prix du public');
