CREATE DATABASE bibliotheque;
USE bibliotheque;

-- Livre

CREATE TABLE LIVRE (
       id_livre INT AUTO_INCREMENT PRIMARY KEY,
       titre VARCHAR(100) NOT NULL,
       isbn VARCHAR(20) UNIQUE NOT NULL,
       anne_publication YEAR,
       nombre_examplaire INTEGER,
);

-- Auteur

CREATE TABLE AUTEUR (
       id_auteur PRIMARY KEY AUTOINCREMT,
       nom VARCHAR(50),
       prenom VARCHAR(100),
       nationalite VARCHAR(100),
);

-- Emprunt

CREATE TABLE EMPRUNT (
       id_emprunt PRIMARY KEY AUTOINCREMT,
       id_livre PRIMARY KEY,
       id_membre PRIMARY KEY,
       date_emprunt DATE,
       date_retoir_prevue DATE,
);

-- Membre

CREATE TABLE MEMBRE (
       id_memnre PRIMARY KEY AUTOINCREMT,
       nom VARCHAR(30),
       prénom VARCHAR(100),
       email TEXT,
       date_inscription DATE,
);
