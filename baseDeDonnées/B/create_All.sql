DROP TABLE IF EXISTS Utilisateur CASCADE;
DROP TABLE IF EXISTS Participer CASCADE;
DROP TABLE IF EXISTS recompense CASCADE;
DROP TABLE IF EXISTS Salle CASCADE;
DROP TABLE IF EXISTS Seance CASCADE;
DROP TABLE IF EXISTS Billet CASCADE;
DROP TABLE IF EXISTS Sponsor CASCADE;

DROP TABLE IF EXISTS temporaire_film ;  
DROP TABLE IF EXISTS  Film cascade; 

DROP TABLE IF EXISTS table_x1 ;  
DROP TABLE IF EXISTS  Cinema cascade; 

DROP TABLE IF EXISTS table_x3 ;
DROP TABLE IF EXISTS Realisateur ;

DROP TABLE IF EXISTS table_x4 ;  
DROP TABLE IF EXISTS x2 ; 
DROP TABLE IF EXISTS  Festival cascade; 



CREATE TABLE table_x1(bigfield text);

------------Utilisateur-----------------------------------------------
CREATE TABLE Utilisateur(
num_utilisateur  INTEGER PRIMARY KEY,
age            INTEGER 
);
-------------------------------------------cinema-------------------------
copy table_x1 FROM PROGRAM 'wget -O  - "$@""https://cinema-public.opendatasoft.com/explore/dataset/liste-des-etablissements-cinematographiques-en-france/download/?format=csv&timezone=Europe/Berlin&lang=fr&use_labels_for_header=true&csv_separator=%3B"' 
HEADER CSV DELIMITER '$';
				
 
SELECT 
split_part(bigfield, ';',  1) 		AS nom_cinema,
split_part(bigfield, ';',  4) 		AS code_postale,
split_part(bigfield, ';',  3)	  	AS adresse,
split_part(bigfield, ';',  6)	    AS nombre_salle
into Cinema
from table_x1 limit 20
; 
alter table Cinema
add constraint pkey_c PRIMARY KEY(nom_cinema);
---------------------------------festival---------------------------
CREATE TABLE  table_x4 (bigfield TEXT)                     
;
 
copy table_x4 FROM PROGRAM 'wget -O  - "$@""https://cinema-public.opendatasoft.com/explore/dataset/panorama-des-festivals/download/?format=csv&timezone=Europe/Berlin&lang=fr&use_labels_for_header=true&csv_separator=%3B"' 
HEADER CSV DELIMITER '$';

select * into x2 from table_x4 where split_part(bigfield, ';',  3) = 'Cinéma et audiovisuel';				
 
SELECT 
split_part(bigfield, ';',  1) 		AS nom_festival,
split_part(bigfield, ';',  2)	  	AS lieu_festival
into Festival
from x2 limit 20
 
; 
ALTER TABLE Festival
 ADD column date_festival DATE;

		 UPDATE Festival SET date_festival ='2019-01-15' where nom_festival='Festival International du Film de comédie de l’Alpe d’Huez';
		 UPDATE Festival SET date_festival ='2019-01-18' where nom_festival='MyFrenchFilmFestival';
		 UPDATE Festival SET date_festival ='2019-01-25' where nom_festival='Festival Premiers plans d''Angers';
		 UPDATE Festival SET date_festival ='2019-03-13' where nom_festival='Traverse Vidéo - Toulouse';
		 UPDATE Festival SET date_festival ='2019-03-15' where nom_festival='Cinéma du réel';
		 UPDATE Festival SET date_festival ='2019-04-02' where nom_festival='Panorama des cinémas du Maghreb';
		 UPDATE Festival SET date_festival ='2019-04-03' where nom_festival='Festival International du Film Policier de Beaune';
		 UPDATE Festival SET date_festival ='2019-04-15' where nom_festival='FESTIVAL INTERNATIONAL DU FILM AVENTURE & DECOUVERTE';
		 UPDATE Festival SET date_festival ='2019-04-28' where nom_festival='Saint Barth Film Festival';
		 UPDATE Festival SET date_festival ='2019-06-10' where nom_festival='Festival international du film d''animation d''Annecy';
		 UPDATE Festival SET date_festival ='2019-06-18 ' where nom_festival='Champs Elysées Film Festival';
		 UPDATE Festival SET date_festival ='2019-06-24' where nom_festival='Sunny side of the doc';
		 UPDATE Festival SET date_festival ='2015-01-01' where nom_festival='Rencontres cinématographiques de Pézenas';
		 UPDATE Festival SET date_festival ='2017-06-10' where nom_festival='Festival Même pas peur';
		 UPDATE Festival SET date_festival ='2019-05-11' where nom_festival='Festival Prix de court';
		 UPDATE Festival SET date_festival ='2018-03-20' where nom_festival='Les Révoltés de l’Histoire';
		 UPDATE Festival SET date_festival ='2019-07-10' where nom_festival='Festival Plein la Bobine';
		 UPDATE Festival SET date_festival ='2017-06-08' where nom_festival='L’ACID à Cannes';
		 UPDATE Festival SET date_festival ='2019-07-10' where nom_festival='COURTS DANS LA VALLÉE';
		 UPDATE Festival SET date_festival ='2018-06-15' where nom_festival='Festival du cinéma de La Foa';
       

alter table Festival
add constraint p_festival PRIMARY KEY(nom_festival);
--------------------------------film-------------------------------------------
CREATE TABLE  temporaire_film (bigfield TEXT)                     
;

copy temporaire_film FROM PROGRAM 'wget -O  - "$@""https://cinema-public.opendatasoft.com/explore/dataset/cnc-production-cinematographique-liste-des-films-agreespublic/download/?format=csv&timezone=Europe/Berlin&lang=fr&use_labels_for_header=true&csv_separator=%3B"' 
 HEADER CSV  DELIMITER '$';
				
SELECT 
split_part(bigfield, ';',  2) 		AS titre_film,
split_part(bigfield, ';',  6) 		AS genre,
split_part(bigfield, ';',  12)	  	AS pays,
split_part(bigfield, ';',  13)	    AS annee_sortie
into Film

from temporaire_film limit 20
; 

alter table Film
add constraint p PRIMARY KEY(titre_film),
add column duree_film TIME  CHECK (duree_film BETWEEN '00:40:00' and '03:00:00'),
add column age_autorise  INTEGER CHECK( age_autorise > 4 ) ;

	 UPDATE Film SET age_autorise =10 ,duree_film = '01:31:00' where titre_film='Cachalots, à la rencontre des géants';
	 UPDATE Film SET age_autorise =14 ,duree_film = '01:25:00' where titre_film='Cold war';
     UPDATE Film SET age_autorise =16 ,duree_film = '01:23:00' where titre_film='Editeur';
   	 UPDATE Film SET age_autorise =6 ,duree_film = '01:47:00' where titre_film='Fahim';
	 UPDATE Film SET age_autorise =16 ,duree_film = '01:58:00' where titre_film='Kat people';
	 UPDATE Film SET age_autorise =7 ,duree_film = '01:47:00' where titre_film='Maya';
	 UPDATE Film SET age_autorise =5 ,duree_film = '01:39:00' where titre_film='Monsieur';
	 UPDATE Film SET age_autorise =10 ,duree_film = '01:37:00' where titre_film='Neuilly sa mère, sa mère';
	 UPDATE Film SET age_autorise =15 ,duree_film = '01:30:00' where titre_film='Positive school';
	 UPDATE Film SET age_autorise =8 ,duree_film = '01:35:00' where titre_film='Territoires';
	 UPDATE Film SET age_autorise =16 ,duree_film = '01:20:00' where titre_film='A 2 heures de Paris';
	 UPDATE Film SET age_autorise =10 ,duree_film = '01:47:00' where titre_film='Amanda';
	 UPDATE Film SET age_autorise =12 ,duree_film = '01:37:00' where titre_film='Belle et la belle (La)';
	 UPDATE Film SET age_autorise =16 ,duree_film = '01:43:00' where titre_film='Capital au Xxe siècle (Le)';
	 UPDATE Film SET age_autorise =14 ,duree_film = '01:38:00' where titre_film='C''est ça l''amour';
	 UPDATE Film SET age_autorise =10 ,duree_film = '01:23:00' where titre_film='Collier rouge (Le)';
	 UPDATE Film SET age_autorise =10 ,duree_film = '01:26:00' where titre_film='Fils de Garches';
	 UPDATE Film SET age_autorise =12 ,duree_film = '01:30:00' where titre_film='Jewell stone';  
     UPDATE Film SET age_autorise =16 ,duree_film = '01:30:00' where titre_film='Monnaie de leur pièce (La)';
     UPDATE Film SET age_autorise =5 ,duree_film = '01:12:00' where titre_film='Mort de Staline (La)'; 
    
---------------------------realisateur-----------------------------------------
CREATE TABLE  table_x3 (bigfield TEXT)
;
 copy table_x3 FROM PROGRAM 'wget -O  - "$@""https://cinema-public.opendatasoft.com/explore/dataset/cnc-production-cinematographique-liste-des-films-agreespublic/download/?format=csv&timezone=Europe/Berlin&lang=fr&use_labels_for_header=true&csv_separator=%3B"' 
HEADER CSV DELIMITER '$';
			
 
SELECT 
split_part(bigfield, ';',3) AS nom_realisateur
into Realisateur
from table_x3 limit 20
; 
 
ALTER TABLE Realisateur
 ADD column num_realisateur INTEGER;


       	  UPDATE realisateur SET num_realisateur =1 where nom_realisateur='VINCENT Guillaume';
       	 UPDATE realisateur SET num_realisateur =2 where nom_realisateur='PAWLIKOWSKI Pawel';
       	 UPDATE realisateur SET num_realisateur =3 where nom_realisateur='OTCHAKOVSKI-LAURENS Paul';
       	 UPDATE realisateur SET num_realisateur =4 where nom_realisateur='MARTIN LAVAL Pierre-François';
       	 UPDATE realisateur SET num_realisateur =5 where nom_realisateur='GASTINE Marco';
       	 UPDATE realisateur SET num_realisateur =6 where nom_realisateur='HANSEN-LOVE Mia';
       	 UPDATE realisateur SET num_realisateur =7 where nom_realisateur='GERA Rohena';
       	 UPDATE realisateur SET num_realisateur =8 where nom_realisateur='BENSALAH Djamel / JULIEN-LAFERRIERE Gabriel';
       	 UPDATE realisateur SET num_realisateur =9 where nom_realisateur='AYOUCH Nabil';
       	 UPDATE realisateur SET num_realisateur =10 where nom_realisateur='OELHOFFEN David';
       	 UPDATE realisateur SET num_realisateur =11 where nom_realisateur='VERRIER Virginie'; 
	 	 UPDATE realisateur SET num_realisateur =12 where nom_realisateur='HERS Mikhaël';
	 	 UPDATE realisateur SET num_realisateur =13 where nom_realisateur='FILLIERES Sophie';
	 	 UPDATE realisateur SET num_realisateur =14 where nom_realisateur='PEMBERTON Justin / PIKETTY Thomas';
	 	 UPDATE realisateur SET num_realisateur =15 where nom_realisateur='BURGER Claire';
	 	 UPDATE realisateur SET num_realisateur =16 where nom_realisateur='BECKER Jean';
	 	 UPDATE realisateur SET num_realisateur =17 where nom_realisateur='GENDARME Remi';
	 	 UPDATE realisateur SET num_realisateur =18 where nom_realisateur='DUMAS Sandrine';
	 	 UPDATE realisateur SET num_realisateur =19 where nom_realisateur='LE NY Anne';
	 	 UPDATE realisateur SET num_realisateur =20 where nom_realisateur='IANNUCCI Armando';
	 	

     
ALTER TABLE Realisateur
 add constraint p_real PRIMARY KEY(num_realisateur)

;
-------------Participer-------------------------------------------------
CREATE TABLE Participer(
num_realisateur INTEGER REFERENCES Utilisateur ON DELETE CASCADE,
titre_film     VARCHAR REFERENCES Film ON DELETE CASCADE
);
-------------recompense-------------------------------------------------
CREATE TABLE recompense (
nom_festival varchar REFERENCES festival,
titre_film   Varchar REFERENCES Film,
prix         varchar array,
Primary key(nom_festival,titre_film)
);
-------------Salle---------------------------------------------------------------
CREATE TABLE Salle(
num_salle INTEGER NOT NULL,
nom_cinema Varchar REFERENCES Cinema ON DELETE CASCADE,
code_salle VARCHAR UNIQUE,
capacite INTEGER CHECK (capacite>20 ),
Primary key(num_salle,nom_cinema)
);
-----------------------seance---------------
CREATE TABLE Seance(
num_seance SERIAL PRIMARY KEY,
date_seance date,
heure TIME CHECK (heure BETWEEN '08:00:00' and '20:00:00'),
durée_seance  time,
titre_film VARCHAR REFERENCES Film(titre_film) ON DELETE CASCADE,
code_salle VARCHAR  REFERENCES Salle(code_salle) ON DELETE CASCADE
);
----------------Billet-------------------
CREATE TABLE Billet (
num_billet     SERIAL PRIMARY KEY,
heure_achat    time,
num_seance     INTEGER REFERENCES Seance ON DELETE CASCADE,
num_utilisateur  INTEGER REFERENCES Utilisateur ON DELETE CASCADE
);
-------------------sponsor----------------------------------------------------
CREATE TABLE Sponsor(
nom_sponsor varchar ,
montant     integer,
grade       varchar CHECK(grade IN ('Débutant','Novice','Expert')),
titre_film  Varchar REFERENCES Film ON DELETE CASCADE,
Primary key (nom_sponsor,titre_film)
);
-----------------------------les indexs --------------------------------------
create index date_seance_index on seance using hash(date_seance);
create index date_festival_index on festival using btree(date_festival);
create index grade_index on sponsor using hash(grade);
create index montant_index on sponsor using btree(montant);
create index prix_recompense_index on recompense using hash(prix);
create index realisateur_index on realisateur using hash(nom_realisateur);
