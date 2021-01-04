DROP FUNCTION IF EXISTS nombre_billet(titre_film_p VARCHAR);
DROP TRIGGER IF EXISTS vérifier ON Billet;
DROP FUNCTION IF EXISTS acheterbillet();
DROP TRIGGER IF EXISTS capacite_cinema ON Salle;
DROP FUNCTION IF EXISTS vérifiernombresalle();
DROP TRIGGER IF EXISTS verifierbillet ON Billet;
DROP FUNCTION IF EXISTS ajouterbillet();
DROP TRIGGER  IF EXISTS verifierbillet_a ON Billet;
DROP FUNCTION IF EXISTS billet_a();
DROP TRIGGER  IF EXISTS verifier_récompense ON recompense;
DROP FUNCTION IF EXISTS récompense_ajout() CASCADE;
DROP TRIGGER  IF EXISTS modifier_grade ON Sponsor;
DROP FUNCTION IF EXISTS vérifier_grade();
DROP FUNCTION IF EXISTS nbr_billet_pour_age();

---------------renvoie le nombre de billet pris par des ultilisateurs ayant age_demande ou moins---------------------
CREATE OR REPLACE FUNCTION nbr_billet_pour_age(age_demande integer) RETURNS SETOF int AS $$
begin
	return query select count(*)::int 
				 from Billet natural join Utilisateur 
				 where Utilisateur.age <= age_demande;
    
end;
$$ LANGUAGE plpgsql; 
---------------renvoie le nombre de billet pris pour des films du genre genre_demande---------------------------------------------
CREATE OR REPLACE FUNCTION nbr_billet_pour_genre(genre_demande text) RETURNS SETOF int AS $$
begin
	return query select count(*)::int 
				 from Billet natural join Utilisateur natural join seance natural join Film 
				 where film.genre = genre_demande ;
    
end;
$$ LANGUAGE plpgsql; 
---------------renvoie le nombre de billet pris à la date film_date pour le film titre------------------------------------------------------------------------
CREATE FUNCTION nbr_billet_pr_film_date(titre text,film_date date) RETURNS SETOF int AS $$
begin
	 return query select count(*)::int  
	 			   from Billet natural join seance
	 			    where seance.titre_film = titre and seance.date_seance = film_date;
end;
$$ LANGUAGE plpgsql;

-------------renvoie le nombre de place restantes et le pourcentage d'occupation de la salle qui projette le film titre a la date film_date à l'heure heure_s-----
CREATE FUNCTION salle_est_occupee2(titre text,film_date date,heure_s time) RETURNS text AS $$
DECLARE
	nbr int;
	capacity int ;
begin
     nbr := 0; 
	 select count(*)::int INTO nbr from Billet natural join seance where seance.titre_film = titre and seance.date_seance = film_date and seance.heure = heure_s;
     select salle.capacite INTO capacity from Billet natural join seance natural join salle  where seance.titre_film = titre and seance.date_seance = film_date and seance.heure = heure_s;

	 return 'salle occupée à ' || (nbr*100 / capacity)::text || '%' || '; ' || 'nombre de place restantes est ' ||' '|| (capacity-nbr)::text ;

end;
$$ LANGUAGE plpgsql;
-----------type qui nous servira au meme temps a stocker le nom d'un film et le nombre de billet pour ce meme film---------- 
CREATE TYPE retour AS (nom_film varchar,nbr_billet INTEGER);
-----------renvoie le titre du film le plus regardé entre date1 et date2-dans le cinema cinema------------------------------------------------------
CREATE OR REPLACE FUNCTION film_plus_regarde(date1 date, date2 date , cinema varchar) RETURNS text AS $$
DECLARE 
	resultat INTEGER;
	i retour;
	nom_film varchar;
	
begin
      resultat := 0;
	  FOR i IN select s.titre_film,count(b.num_billet)::int
				from Billet as b natural join seance as s natural join cinema as c
				where c.nom_cinema = cinema and s.date_seance between date1 and date2  
				group by s.titre_film

	  LOOP
		  	IF i.nbr_billet > resultat then 
		  		resultat = i.nbr_billet ;
		  		nom_film = i.nom_film ;
		  	end IF;
	  end LOOP;
     
return 'le film le plus regardé entre '|| $1 || ' et ' || $2 || ' est: ' || '"'||nom_film||'"';
end;
$$ LANGUAGE plpgsql; 
---------------trigger +  fonction pour verifier que une salle n'est pas déja occupée avant de projeté un film dans cette salle---------------------------------
CREATE OR REPLACE FUNCTION verifier_seance() RETURNS TRIGGER AS $$
DECLARE
   ligne record;
BEGIN
	select num_seance INTO ligne from Seance as s
	where s.code_salle = new.code_salle and s.heure = new.heure and s.date_seance = new.date_seance;
	
	
    IF not found  THEN
 		return new;
    ELSE 
      RAISE notice 'Salle occupée!';
    END IF;
    
    return null;
       
END;
$$ language plpgsql;
--------------------------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER est_possible_seance
    BEFORE INSERT ON seance
    FOR EACH ROW EXECUTE PROCEDURE verifier_seance();

------------------trigger + fonction pour verifier avant l'insertion d'une seance que le film--------------------------------------
----------n'est pas déja programmé pour la meme heure, meme date et meme cinema; dans une autre salle------------------ 
CREATE OR REPLACE FUNCTION verifier_seance_film() RETURNS TRIGGER AS $$
DECLARE
   ligne record;
   cinema varchar;
BEGIN
  select salle.nom_cinema INTO cinema from salle where salle.code_salle = new.code_salle ;
	select titre_film INTO ligne from Seance as s natural join salle
	where salle.nom_cinema = cinema and s.heure = new.heure and s.date_seance = new.date_seance;
	
	
    IF not found  THEN
 		 return new;
    ELSE 
      RAISE notice 'le film est déja programmé pour cette date et cette heure! ';
    END IF;
    
    return null;
       
END;
$$ language plpgsql;
  ------------------trigger-------------------
CREATE TRIGGER film_en_double
    BEFORE INSERT ON Seance
    FOR EACH ROW EXECUTE PROCEDURE verifier_seance_film();
-------------verifer que la durée d'une seance = la durée du film concerné + 10 minutes de publicite-------------- 
CREATE OR REPLACE FUNCTION verifier_durée_seance() RETURNS TRIGGER AS $$
DECLARE
   durée time;

BEGIN
    	select duree_film INTO durée from seance as s natural join film as f
	    where f.titre_film = new.titre_film;
	
	
      IF new.durée_seance = durée + '00:10:00' or new.durée_seance > durée + '00:10:00'  THEN
 		     return new;
      ELSE 
        RAISE notice 'la durée de la seance n est pas compatible avec les autres informations! ';
      END IF;
    
    return null;
       
END;
$$ language plpgsql;
   --------------trigger----------------------
CREATE TRIGGER durée_seance
    BEFORE INSERT ON seance
    FOR EACH ROW EXECUTE PROCEDURE verifier_durée_seance();

---------retourne tous les festivals auqeuls un film donné participe entre deux dates donnees en parametre-------------------
CREATE FUNCTION liste_festivals(titre text,date1 date,date2 date) RETURNS text AS $$
DECLARE
  ligne text;
  i text;

begin
      ligne = '';
	  FOR i IN select fs.nom_festival
				from Film as f natural join recompense as r natural join festival as fs
				where f.titre_film = titre and fs.date_festival::date between date1 and date2  

	  LOOP
		  ligne = ligne  || i || ' ' ;
	  end LOOP;

return ligne;

end;
$$ LANGUAGE plpgsql;
--------------------------------renvoie tous les prix obtenu par un film donné dans un festival donné------------------------------------
CREATE FUNCTION liste_prix(film varchar,festival varchar) RETURNS text AS $$
DECLARE
  prix text;

begin
     select r.prix into prix
	 from recompense as r 
	 where r.titre_film = film and r.nom_festival = festival ; 

     if prix ='{""}' then
       return 'aucun prix pour : ' || $1 || ' pour le festival de ' || $2;
     end if;
return prix;

end;
$$ LANGUAGE plpgsql;
-------------------------renvoie tous les films qui participent à un festival--------------------------------------------------------
CREATE FUNCTION liste_films(festival varchar) RETURNS text AS $$
DECLARE
  ligne text;
  i text;

begin
      ligne = '';
	  FOR i IN select f.titre_film
				from Film as f natural join recompense as r natural join festival as fs
				where fs.nom_festival = festival  

	  LOOP
		  ligne = ligne  || i || ' ' ;
	  end LOOP;

return ligne;

end;
$$ LANGUAGE plpgsql;
----------renvoie le film qui a eu le prix donné en parametre dans le festival donné en parametre---------------------------------------
CREATE FUNCTION prix_festival(Lefestival varchar,Leprix text) RETURNS text AS $$
DECLARE
   reponse varchar;  

begin
      SELECT r.titre_film into reponse
      FROM festival natural join recompense as r natural join Film
      WHERE r.nom_festival = Lefestival and Leprix = ANY (r.prix);

      if not found then
       return 'aucun film a eu ce prix';
      end if;
return reponse;

end;
$$ LANGUAGE plpgsql;
--------------------------------------------------------------------------------------------------------------------------------------------

---------afficher le nombre de billet d'un film qui a comme titre ce que je donne en paramètre-----
CREATE OR REPLACE FUNCTION nombre_billet(titre_film_p VARCHAR) RETURNS INT AS $$
DECLARE 
NOMBRE_BILLET INT;
BEGIN
select count(num_billet) INTO NOMBRE_BILLET
from Billet as b natural join Seance as s
where s.titre_film=titre_film_p;
return NOMBRE_BILLET;
END;
$$ LANGUAGE plpgsql;
-- TRIGGER qui vérifie avant l'achat d'un billet si l'age d'un utilisateur est supérieur a l'age autorisé pour regarder un film---------------
CREATE OR REPLACE FUNCTION acheterbillet() RETURNS TRIGGER AS $$
DECLARE
  nombre INTEGER;
  age_aut INTEGER;
BEGIN

	select u.age INTO nombre
	from utilisateur as u 
	where u.num_utilisateur=new.num_utilisateur;

	select f.age_autorise INTO age_aut
	from Film as f natural join Seance  as s
	natural join Billet as b;

	if age_aut>nombre THEN 
		raise notice'votre age est inférieur à l''age autorisé pour regarder ce film';
	else
	return new;
	END IF;
	return null;
END;
$$ language plpgsql;

CREATE TRIGGER vérifier
    BEFORE INSERT ON Billet
    FOR EACH ROW EXECUTE PROCEDURE acheterbillet();
------ TRIGGER qui vérifie avant l'insertion d'une salle si la capacite du cinema n'est pas depasée-------------------------------------------
CREATE OR REPLACE FUNCTION vérifiernombresalle() RETURNS TRIGGER AS $$
DECLARE
nombre   INTEGER;
capacite REAL;
BEGIN
	select count(s.num_salle) into nombre
	from salle as s where s.nom_cinema=new.nom_cinema;
	select nombre_salle into capacite from cinema as c where c.nom_cinema=new.nom_cinema;
	
	
    IF capacite<=nombre THEN
       RAISE notice 'nombre de salle est dépassé';
    ELSE 
    return new;
    END IF;
    return null;
       
END;
$$ language plpgsql;
CREATE TRIGGER capacite_cinema
    BEFORE INSERT ON Salle
    FOR EACH ROW EXECUTE PROCEDURE vérifiernombresalle();
    ---------------------------------heure projection >=heure achat+10 min--------------------------------------------------------------
CREATE OR REPLACE FUNCTION ajouterbillet() RETURNS TRIGGER AS $$
DECLARE
horaire time;
minute time;
BEGIN
SELECT heure into horaire
FROM Seance as se
where new.num_seance=se.num_seance;

if ((SELECT DATE_PART('hour', horaire::time - new.heure_achat::time) * 60 +
              DATE_PART('minute', horaire::time - new.heure_achat::time))<10) then
raise notice 'horaire dépassé vous ne pouvez plus acheter un billet pour cette séance';
ELSE
return new;
end if;
RETURN NULL;
end;
$$ language plpgsql;
CREATE TRIGGER verifierbillet
    BEFORE INSERT ON Billet
    FOR EACH ROW EXECUTE PROCEDURE ajouterbillet();
---------------------------------------vérifier si y a de la place dans a salle pour une séance donnée---------------------------
CREATE OR REPLACE FUNCTION billet_a() RETURNS TRIGGER AS $$
DECLARE
nom VARCHAR;
c INTEGER;
nombre_billets INTEGER;
BEGIN
SELECT s.nom_cinema INTO nom 
FROM salle as s natural join Seance as se
WHERE se.num_seance=new.num_seance;
SELECT s.capacite INTO c 
FROM Billet NATURAL JOIN Seance NATURAL JOIN Salle as s
WHERE nom=s.nom_cinema;
SELECT count(num_billet) into nombre_billets
FROM Billet AS b
WHERE b.num_seance=new.num_seance;
IF c = nombre_billets THEN
raise notice'y en a plus de place disponible dans cette salle pour cette seance';
ELSE
return new;
END IF;
RETURN NULL;
END;
$$ language plpgsql;
CREATE TRIGGER verifierbillet_a
    BEFORE INSERT ON Billet
    FOR EACH ROW EXECUTE PROCEDURE billet_a();

--------------------------------si le meilleur film est déja choisi on ne peut pas insérer un autre film et donner la mee récompense

CREATE OR REPLACE FUNCTION récompense_ajout() RETURNS TRIGGER AS $$
DECLARE
meilleur VARCHAR array;
BEGIN

for meilleur in select prix 
                from recompense
                where nom_festival=new.nom_festival
LOOP
IF meilleur=new.prix then
RAISE notice 'le meilleur film est déjà choisi';

ELSE 
return new;
END IF;

end LOOP;
RETURN NULL;
END;
$$ language plpgsql;
CREATE TRIGGER verifier_récompense
    BEFORE INSERT ON recompense
    FOR EACH ROW EXECUTE PROCEDURE récompense_ajout();
------------------------------on modifie le grade d'un sponsor avant chaque insertion d'un sponsor----------------
CREATE OR REPLACE FUNCTION vérifier_grade() RETURNS TRIGGER AS $$
DECLARE
BEGIN
if new.montant>'0' and new.montant<'10000' then
    new.grade='Débutant';
    raise notice'débutant';
        
else if new.montant >'10000'  and new.montant<'100000' then
        new.grade ='Novice';
        raise notice 'novice';
   
     else
        new.grade='Expert';
        raise notice 'expert';
    end if;
end if;
    

return new;
END;
$$ language plpgsql;
CREATE TRIGGER modifier_grade
BEFORE INSERT ON Sponsor
FOR EACH ROW EXECUTE PROCEDURE vérifier_grade();

----------------------------les sponsors d'un grade donnée pour un film donné
CREATE OR REPLACE FUNCTION selection_sponsor(titre_film_s VARCHAR,grade_s VARCHAR) RETURNS SETOF varchar AS $$
BEGIN    
return query select nom_sponsor
from   sponsor 
where  titre_film=titre_film_s and grade=grade_s;
END;
$$ language plpgsql;
-----------------------------------fonction qui renvoie tous les sponsors d'un film donné
CREATE OR REPLACE FUNCTION sponsors(titre_film_s VARCHAR) RETURNS SETOF varchar AS $$
BEGIN    
return query select nom_sponsor
from   sponsor 
where  titre_film=titre_film_s;
END;
$$ language plpgsql;
