---------test : les sponsors du film 'maya' qui ont comme grade expert  
 select selection_sponsor('Maya','Expert');
    --verification : on selection tous les sponsor du film maya avec leur grade 
  select nom_sponsor,grade from sponsor where titre_film = 'Maya'  ;

--------test : affiche tous les sponsors du film cold war
 select sponsors('Cold war');
 --test de nombre de billet pour un film donné