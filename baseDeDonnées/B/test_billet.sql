------test : nombre de billet achetes par des utilisateurs ayant 40 ans ou moins----------------------------------------
 select nbr_billet_pour_age(20);  

-----test : nombre de billet achété pour des films de Fiction--------------------------------------------------------------------------
select nbr_billet_pour_genre('Fiction');

-----test : le nombre de billet achetes pour le film 'Cold war' le 20/03/2020------------------------------------------------
select nbr_billet_pr_film_date('Cold war','20/04/2010'); 
