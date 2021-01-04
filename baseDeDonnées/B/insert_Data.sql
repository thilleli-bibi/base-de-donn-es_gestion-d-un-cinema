---------------------------------------------------------------------------------------
INSERT INTO Utilisateur(num_utilisateur,age) VALUES
(1,20),
(2,20),
(3,20),
(4,20),
(5,20),
(6,20),
(7,20),
(8,21),
(9,21),
(10,21),
(11,21),
(12,21),
(13,21),
(14,18),
(15,18),
(16,18),
(17,18),
(18,18),
(19,20),
(20,20),
(21,10),
(22,26),
(23,35),
(24,40),
(25,28),
(26,18),
(27,30)
;
----------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO Participer(num_realisateur,titre_film ) VALUES
(1,'Cold war'),
(2,'Editeur'),
(3,'Fahim'),
(4,'Kat people'),
(5,'Maya'),
(6,'Monsieur'),
(7,'Neuilly sa mère, sa mère'),
(8,'Positive school'),
(9,'Territoires'),
(10,'A 2 heures de Paris'),
(11,'Amanda'),
(12,'Belle et la belle (La)'),
(13,'Capital au Xxe siècle (Le)'),
(14,'C''est ça l''amour'),
(15,'Collier rouge (Le)'),
(16,'Fils de Garches'),
(17,'Jewell stone'),
(18,'Mort de Staline (La)'),
(19,'Mort de Staline (La)'),
(20,'Cachalots, à la rencontre des géants')
;
------------------------------------------------------------------------------------
INSERT INTO recompense (nom_festival,titre_film,prix) VALUES
('L’ACID à Cannes','Cold war','{""}'),
('L’ACID à Cannes','Amanda','{"prix de la presse"}'),
('L’ACID à Cannes','Collier rouge (Le)','{"grand prix"}'),
('L’ACID à Cannes','Jewell stone','{"meilleur realisateur"}'),
('L’ACID à Cannes','Mort de Staline (La)','{""}'),
('L’ACID à Cannes','Cachalots, à la rencontre des géants','{"meilleur film"}'),
('L’ACID à Cannes','Belle et la belle (La)','{""}'),
('L’ACID à Cannes','Fils de Garches','{""}'),
('L’ACID à Cannes','Maya','{"prix du public"}'),


('Champs Elysées Film Festival','Belle et la belle (La)','{"meilleur film","grand prix"}'),
('Champs Elysées Film Festival','Neuilly sa mère, sa mère','{""}'),
('Champs Elysées Film Festival','Fils de Garches','{""}'),
('Champs Elysées Film Festival','A 2 heures de Paris','{""}'),
('Champs Elysées Film Festival','Maya','{"prix du public"}'),
('Champs Elysées Film Festival','Fahim','{""}'),


('Traverse Vidéo - Toulouse','Editeur','{""}'),
('Traverse Vidéo - Toulouse','Fahim','{"prix du jury"}'),
('Traverse Vidéo - Toulouse','Maya','{"meilleur film"}'),
('Traverse Vidéo - Toulouse','Monsieur','{"meilleur realisateur"}'),
('Traverse Vidéo - Toulouse','Territoires','{""}'),
('Traverse Vidéo - Toulouse','Amanda','{"meilleur interpretation féminine"}'),
('Traverse Vidéo - Toulouse','Fils de Garches','{""}'),
('Traverse Vidéo - Toulouse','Mort de Staline (La)','{""}'),


('Festival International du Film de comédie de l’Alpe d’Huez','Cold war','{"prix de la presse"}'),
('Festival International du Film de comédie de l’Alpe d’Huez','Positive school','{""}'),
('Festival International du Film de comédie de l’Alpe d’Huez','A 2 heures de Paris','{""}'),
('Festival International du Film de comédie de l’Alpe d’Huez','Jewell stone','{"meilleur film"}'),
('Festival International du Film de comédie de l’Alpe d’Huez','Mort de Staline (La)','{""}'),
('Festival International du Film de comédie de l’Alpe d’Huez','Cachalots, à la rencontre des géants','{"meilleur realisateur"}'),
('Festival International du Film de comédie de l’Alpe d’Huez','Territoires','{""}'),

('Panorama des cinémas du Maghreb','Positive school','{"meilleur realisateur"}'),
('Panorama des cinémas du Maghreb','Amanda','{""}'),
('Panorama des cinémas du Maghreb','Monsieur','{"meilleur film"}'),
('Panorama des cinémas du Maghreb','C''est ça l''amour','{""}'),
('Panorama des cinémas du Maghreb','Fahim','{""}'),
('Panorama des cinémas du Maghreb','Territoires','{""}'),
('Panorama des cinémas du Maghreb','Neuilly sa mère, sa mère','{"coup de coeur féminin"}'),
('Panorama des cinémas du Maghreb','Maya','{""}'),
('Panorama des cinémas du Maghreb','Fils de Garches','{""}'),



('Festival international du film d''animation d''Annecy','A 2 heures de Paris','{""}'),
('Festival international du film d''animation d''Annecy','Cold war','{""}'),
('Festival international du film d''animation d''Annecy','Amanda','{""}'),
('Festival international du film d''animation d''Annecy','Jewell stone','{"prix du public","prix de la presse"}'),
('Festival international du film d''animation d''Annecy','Cachalots, à la rencontre des géants','{""}'),
('Festival international du film d''animation d''Annecy','Positive school','{"meilleur realisateur","meilleur interpretation masculine"}'),
('Festival international du film d''animation d''Annecy','Territoires','{"meilleur film"}')
;
------------------------------------------------------------------------------------
insert into Salle (num_salle,nom_cinema,code_salle,capacite) values
('4','Jeanne d''Arc','1j1','21'),
('2','Le Cinéparadis','2j2','25'),
('3','Le Cinéparadis','3j3','30'),
('1','Cravlor','1e1','21'),
('2','Cravlor','2e2','30'),
('3','Cravlor','3e3','40'),
('4','Cravlor','4e4','30'),
('1','Le Cinéparadis','1c1','21'),
('4','Le Cinéparadis','2c2','25'),
('5','Le Cinéparadis','3c3','30'),
('1','Arlequin','1a1','21'),
('2','Arlequin','2a2','30'),
('3','Arlequin','3a3','40'),
('4','Espace Daniel Sorano','4a4','30'),
('1','Gérard Philipe','1g1','21'),
('2','Espace Daniel Sorano','2g2','25'),
('3','Espace Daniel Sorano','3g3','30'),
('1','Rencontres','1r1','21'),
('2','Salle Paul Eluard','2r2','30'),
('3','Rex','3r3','40');
------------------------------seance-----------------------------------------------------
insert into Seance (date_seance,heure,durée_seance,titre_film,code_salle)values
	('20/04/2010','14:00:00','02:00:00','Cold war','1j1'),
    
	('19/04/2020','16:00:00','02:00:00','Editeur','2j2'),

	('14/05/2020','20:00:00','02:00:00','Editeur','3j3'),

	('25/05/2020','14:00:00','02:00:00','Monsieur','1e1'),
	
	('25/04/2020','14:00:00','02:00:00','Cold war','2e2'),

	('21/04/2020','16:00:00','02:00:00','Editeur','3e3'),

	('16/05/2020','20:00:00','02:00:00','Editeur','4a4'),

	('18/05/2020','14:00:00','02:00:00','Monsieur','1g1'),
	
	('14/04/2010','14:00:00','02:00:00','Cold war','1e1'),

	('09/04/2020','16:00:00','02:00:00','Editeur','2e2'),

	('10/05/2020','20:00:00','02:00:00','Editeur','3g3'),

	('09/06/2020','14:00:00','02:00:00','Monsieur','1e1'),
	
	('14/06/2020','14:00:00','02:00:00','Cold war','2e2'),

	('09/04/2020','16:00:00','02:00:00','Editeur','3e3'),

	('09/05/2020','20:00:00','02:00:00','Editeur','4a4'),

	('30/05/2020','14:00:00','02:00:00','Monsieur','1g1');
	
------------------------------------------------------------------
INSERT INTO Billet(heure_achat,num_seance,num_utilisateur)VALUES
	('12:00:00',1,1),
    ('13:00:00',1,2),
	('09:00:00',1,3),
	('10:00:00',1,4),
	('12:00:00',1,5),
	('12:00:00',1,6),
    ('14:00:00',1,7),
	('15:00:00',1,8),
    ('13:00:00',1,9),
    ('10:00:00',1,10),
    ('12:00:00',1,11),
    ('10:00:00',1,12),
    ('09:00:00',4,13),
    ('12:00:00',5,14),
    ('12:30:00',5,15),
    ('12:00:00',1,17),
    ('12:30:00',1,18),
    ('12:00:00',1,20),
    ('12:30:00',1,21),
    ('12:00:00',1,22),
    ('12:30:00',1,23),
    ('12:00:00',1,24),
    ('12:30:00',1,25);
---------------------------------------------------------------------------------
INSERT INTO Sponsor (nom_sponsor,montant,grade,titre_film) VALUES
	('RATP',10500,'Novice','Cold war'),
	('BNP Paribas',100500,'Expert','Cold war'),
    ('Ecran noir',100500,'Expert','Cold war'),
	('Cahiers de cinéma',100000,'Expert','Editeur'),
	('BNP Paribas',100500,'Expert','Maya'),
    ('Addidas',100500,'Novice','Maya'),
    ('Titratvs',100500,'Débutant','Maya'),
	('ART Cinéma',10500,'Novice','Kat people'),
	('Ecran noir',120500,'Expert','Monsieur'),
	('Titratvs',8000,'Débutant','Territoires');

	