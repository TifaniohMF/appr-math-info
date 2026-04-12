 CREATE TABLE CLIENT (
	id_client INT AUTO_INCREMENT ,
	nom VARCHAR (100) NOT NULL ,
	prenom VARCHAR (100) NOT NULL,
	email VARCHAR (150) UNIQUE ,
	telephone VARCHAR (20) ,
	adresse TEXT ,
	date_inscription DATE DEFAULT CURRENT_DATE ,
	carte_fidelite BOOLEAN DEFAULT FALSE ,
	points_fidelite INT DEFAULT 0,
	date_naissance DATE ,
	PRIMARY KEY ( id_client ) ,
	CONSTRAINT chk_points CHECK ( points_fidelite >= 0)
);


CREATE TABLE PRODUIT (
	id_produit INT AUTO_INCREMENT ,
	nom_produit VARCHAR (100) NOT NULL ,
	categorie TEXT ChECK( categorie IN ('Boisson chaude','Boisson froide', 'Viennoiserie','Patisserie', 'Plat')) NOT NULL ,
    prix_unitaire DECIMAL(6,2) NOT NULL ,
    stock_disponible INT DEFAULT 0,
    stock_min INT DEFAULT 10 ,
    description TEXT ,
    date_ajout DATE DEFAULT CURRENT_DATE ,
    actif BOOLEAN DEFAULT TRUE ,
    PRIMARY KEY ( id_produit ) ,
    CONSTRAINT chk_prix CHECK ( prix_unitaire > 0) ,
    CONSTRAINT chk_stock CHECK ( stock_disponible >= 0)
);


CREATE TABLE EMPLOYE (
    id_employe INT AUTO_INCREMENT ,
    nom VARCHAR (100) NOT NULL ,
    prenom VARCHAR (100) NOT NULL ,
    poste TEXT CHECK( poste IN ('manager', 'barista', 'serveur','serveuse', 'cuisinier', 'caissier')) NOT NULL ,
    date_embauche DATE NOT NULL ,
    salaire DECIMAL (8 ,2) ,
    telephone VARCHAR (20) ,
    email VARCHAR (150) UNIQUE ,
    adresse TEXT ,
    actif BOOLEAN DEFAULT TRUE ,
    PRIMARY KEY ( id_employe ) ,
   CONSTRAINT chk_salaire CHECK ( salaire > 0)
);


CREATE TABLE TABLE_RESTAURANT (
    id_table INT AUTO_INCREMENT ,
    numero_table INT NOT NULL UNIQUE ,
    capacite INT NOT NULL ,
    emplacement TEXT CHECK( emplacement IN ('interieur', 'terrasse', 'vip')) DEFAULT 'interieur',
    est_disponible BOOLEAN DEFAULT TRUE , PRIMARY KEY ( id_table ) ,
    CONSTRAINT chk_capacite CHECK ( capacite > 0 AND capacite <= 20)
);


CREATE TABLE COMMANDE (
	id_commande INT AUTO_INCREMENT ,
	numero_commande VARCHAR (20) UNIQUE NOT NULL ,
	date_commande DATETIME DEFAULT CURRENT_TIMESTAMP ,
	id_client INT ,
	id_table INT ,
	id_employe INT ,
	statut TEXT CHECK( statut IN ('en_cours', 'servie', 'payee', 'annulee')) DEFAULT 'en_cours',
	montant_total DECIMAL (8 ,2) ,
	mode_paiement TEXT CHECK( mode_paiement IN ('especes', 'carte ', 'cheque', 'mobile')) ,
	commentaire TEXT ,
	PRIMARY KEY ( id_commande ) ,
	FOREIGN KEY ( id_client ) REFERENCES CLIENT ( id_client )
	ON DELETE SET NULL ON UPDATE CASCADE ,
	FOREIGN KEY ( id_table ) REFERENCES TABLE_RESTAURANT ( id_table )
	ON DELETE SET NULL ON UPDATE CASCADE ,
	FOREIGN KEY ( id_employe ) REFERENCES EMPLOYE ( id_employe )
	ON DELETE SET NULL ON UPDATE CASCADE ,
	CONSTRAINT chk_montant CHECK ( montant_total >= 0)
);

CREATE TABLE DETAIL_COMMANDE (
	id_detail INT AUTO_INCREMENT ,
	id_commande INT NOT NULL ,
	id_produit INT NOT NULL ,
	quantite INT NOT NULL DEFAULT 1 ,
	prix_unitaire DECIMAL (5 ,2) NOT NULL ,
	commentaire VARCHAR (200) ,
	PRIMARY KEY ( id_detail ) ,
	FOREIGN KEY ( id_commande ) REFERENCES COMMANDE ( id_commande )
	ON DELETE CASCADE ON UPDATE CASCADE ,
	FOREIGN KEY ( id_produit ) REFERENCES PRODUIT ( id_produit )
	ON DELETE RESTRICT ON UPDATE CASCADE ,
	CONSTRAINT chk_quantite CHECK ( quantite > 0)
);

INSERT INTO PRODUIT ( nom_produit , categorie , prix_unitaire ,
stock_disponible , description ) VALUES

-- Boissons chaudes
('Espresso', 'Boisson chaude', 2.50 , 100 , 'Café court et cors') ,
('Cappuccino', 'Boisson chaude', 3.50 , 100 , 'Espresso avec mousse de lait') ,
('Latte', 'Boisson chaude', 3.80 , 100 , 'Café au lait onctueux') ,
('Americano', 'Boisson chaude', 2.80 , 100 , 'Espresso allong'),
('Café crème', 'Boisson chaude', 3.20 , 80 , 'Café avec crème') ,
('Thé vert', 'Boisson chaude', 2.20 , 80 , 'Thé vert nature') ,
('Thé à la menthe', 'Boisson chaude', 2.50 , 70 , 'Thé vert la menthe') ,
('Chocolat chaud', 'Boisson chaude', 3.50 , 60 , 'Chocolat onctueux') ,


-- Boissons froides
('Jus d orange', 'Boisson froide', 3.00 , 50 , 'Jus pressé 100%') ,
('Coca Cola', 'Boisson froide', 2.50 , 100 , 'Soda 33 cl') ,
('Eau minérale', 'Boisson froide', 1.50 , 150 , 'Eau 50 cl') ,
('Smoothie fraise', 'Boisson froide', 4.50 , 30 , 'Smoothie frais') ,
('Limonade maison', 'Boisson froide', 3.00 , 40 , 'Limonade artisanale') ,

-- Viennoiseries
('Croissant', 'Viennoiserie', 1.80 , 40 , 'Croissant pur beurre'),
('Pain au chocolat', 'Viennoiserie' , 2.00 , 35 , 'Pain au chocolat artisanal') ,
('Chausson aux pommes', 'Viennoiserie', 2.20 , 25 , 'Chausson fait maison') ,

-- P t i s s e r i e s
('Muffin chocolat', 'Patisserie', 2.80 , 25 , 'Muffin au chocolat') ,
('Cheesecake', 'Patisserie', 4.50 , 15 , 'Cheesecake New York style') ,
('Tarte citron', 'Patisserie', 3.80 , 20 , 'Tarte au citron meringue') ,
('clair café', 'Patisserie', 3.50 , 18 , 'clair au café') ,

-- Plats
('Salade C sar' , 'Plat', 8.50 , 20 , 'Salade C sar poulet') ,
('Sandwich jambon', 'Plat', 5.50 , 30 , 'Sandwich jambon beurre'),
('Quiche lorraine', 'Plat', 6.50 , 18 , 'Quiche maison') ,
('Croque monsieur', 'Plat', 6.00 , 25 , 'Croque monsieur gratine') ,
('Salade composée', 'Plat', 7.50 , 20 , 'Salade de saison') ;

INSERT INTO CLIENT ( nom , prenom , email , telephone , carte_fidelite ,
points_fidelite , date_naissance ) VALUES

('Alami', 'Fatima', 'f.alami@email.com', '0612345678', TRUE , 150 , '1985 -03 -15') ,
('Bennani', 'Youssef', 'y.bennani@email.com', '0623456789',TRUE , 220 , '1990 -07 -22') ,
('Chakir', 'Amina', 'a.chakir@email.com', '0634567890', FALSE , 0, '1995 -11 -08') ,
('Drissi', 'Mohamed', 'm.drissi@email.com', '0645678901', TRUE , 85 , '1988 -01 -30') ,
('El Fassi', 'Laila', 'l.elfassi@email.com', '0656789012', FALSE , 0 , '992 -05 -18') ,
('Filali', 'Rachid', 'r.filali@email.com', '0667890123', TRUE , 310 , '1983 -09 -25') ,
('Hamdi', 'Sanaa', 's.hamdi@email.com', '0678901234', TRUE , 125 , '1987 -12 -12') ,
('Idrissi', 'Karim', 'k.idrissi@email.com', '0689012345', FALSE, 0, '1998 -04 -05') ,
('Jabri', 'Nadia', 'n.jabri@email.com', '0690123456', TRUE ,180 , '1991 -08 -20') ,
('Kettani', 'Omar', 'o.kettani@email.com', '0601234567', FALSE ,0, '1996 -02 -14');

-- Tables du restaurant
INSERT INTO TABLE_RESTAURANT ( numero_table , capacite , emplacement ) VALUES
(1 , 2, 'interieur') , (2 , 2 , 'interieur') , (3 , 4, 'interieur') ,
(4 , 4, 'interieur') , (5 , 6 , 'interieur') , (6 , 2, 'terrasse') ,
(7 , 4, 'terrasse') , (8 , 4, 'terrasse') , (9 , 8 , 'vip') , (10 , 6,'vip');

-- Employés
INSERT INTO EMPLOYE ( nom , prenom , poste , date_embauche , salaire , telephone , email )  VALUES
('Tahiri', 'Hassan', 'manager', '2023 -01 -15', 8000.00 , '0661234567', 'h.tahiri@cafe.com') ,
('Mansouri', 'Sara', 'barista', '2023 -03 -20', 4500.00 , '0672345678', 's.mansouri@cafe.com') ,
('Kadiri', 'Omar', 'serveur', '2024 -01 -10', 4000.00 , '0683456789', 'o.kadiri@cafe.com') ,
('Benslimane', 'Nadia', 'serveuse', '2024 -02 -15', 4000.00 , '0694567890', 'n.benslimane@cafe.com') ,
('Zahraoui', 'Mehdi', 'cuisinier', '2023 -06 -01', 5500.00 , '0605678901', 'm.zahraoui@cafe.com') ,
('Amrani', 'Leila', 'serveuse', '2024 -03 -01', 4000.00 , '0616789012', 'l.amrani@cafe.com') ,
('Berrada', 'Youssef', 'barista', '2023 -09 -15', 4500.00 ,'0627890123', 'y.berrada@cafe.com') ,
('Chraibi', 'Samira', 'caissier', '2024 -04 -01', 4200.00 , '0638901234', 's.chraibi@cafe.com');