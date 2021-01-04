-------test : la salle qui a comme code 6cr est deja ouccupée donc cette ligne serait pas inserer et le trigger est_possible_senace sera declencher------------------------
  insert into seance values(20,'21/04/2020','16:00:00','02:00:00','Fahim','3e3');
   --cette salle n'est pas occupée pour la date et leur donné l'insertion reussira
  insert into seance values(21,'22/08/2020','18:00:00','01:57:00','Fahim','3e3');


  	------test : pourcentage d'occupation de la salle diffusant le film "Edieteur" le '01/02/2020' a 16H----------------------------
select salle_est_occupee('Cold war','20/04/2010','14:00:00');
