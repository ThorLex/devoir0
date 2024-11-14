-- Création de la base de données
CREATE DATABASE IF NOT EXISTS centre_formation;
USE centre_formation;

-- Table Etudiant
CREATE TABLE Etudiant (
    numCINEtu VARCHAR(25) PRIMARY KEY,
    nomEtu VARCHAR(45) NOT NULL,
    prenomEtu VARCHAR(45) NOT NULL,
    dateNaissance DATE NOT NULL,
    niveauEtu VARCHAR(45) NOT NULL
);

-- Table Adresse
CREATE TABLE Adresse (
    EtudiantnumCINEtu VARCHAR(25) PRIMARY KEY,
    nomVille VARCHAR(25) NOT NULL,
    nomQuartier VARCHAR(25) NOT NULL,
    FOREIGN KEY (EtudiantnumCINEtu) REFERENCES Etudiant(numCINEtu)
);

-- Table Formation
CREATE TABLE Formation (
    codeForm INTEGER(10) PRIMARY KEY,
    titreForm VARCHAR(45) NOT NULL,
    dureeForm VARCHAR(45) NOT NULL,
    prixForm VARCHAR(45) NOT NULL
);

-- Table Specialite
CREATE TABLE Specialite (
    codeSpec INTEGER(10) PRIMARY KEY,
    nomSpec VARCHAR(45) NOT NULL,
    descSpec VARCHAR(45),
    Active BOOLEAN DEFAULT FALSE
);

-- Table SPECIALITE_FORMATION (nouvelle table)
CREATE TABLE SPECIALITE_FORMATION (
    codeSpec INTEGER(10),
    codeForm INTEGER(10),
    PRIMARY KEY (codeSpec, codeForm),
    FOREIGN KEY (codeSpec) REFERENCES Specialite(codeSpec),
    FOREIGN KEY (codeForm) REFERENCES Formation(codeForm)
);

-- Table Inscription
CREATE TABLE Inscription (
    EtudiantnumCINEtu VARCHAR(25),
    FormationcodeForm INTEGER(10),
    dateInscription DATE NOT NULL,
    typeCours VARCHAR(45) NOT NULL,
    PRIMARY KEY (EtudiantnumCINEtu, FormationcodeForm),
    FOREIGN KEY (EtudiantnumCINEtu) REFERENCES Etudiant(numCINEtu),
    FOREIGN KEY (FormationcodeForm) REFERENCES Formation(codeForm)
);

-- Table Session
CREATE TABLE Session (
    FormationcodeForm INTEGER(10),
    codeSess VARCHAR(25),
    nomSess VARCHAR(25) NOT NULL,
    dateDebut DATE NOT NULL,
    dateFin DATE NOT NULL,
    PRIMARY KEY (FormationcodeForm, codeSess),
    FOREIGN KEY (FormationcodeForm) REFERENCES Formation(codeForm),
    CONSTRAINT CHK_Session_Dates CHECK (dateFin > dateDebut)
);

-- Table Paiement
CREATE TABLE Paiement (
    SessionFormationcodeForm INTEGER(10),
    SessioncodeSess VARCHAR(25),
    idPayement INTEGER(10),
    datePayement DATE NOT NULL,
    montantPayement FLOAT(45) NOT NULL,
    PRIMARY KEY (SessionFormationcodeForm, SessioncodeSess, idPayement),
    FOREIGN KEY (SessionFormationcodeForm, SessioncodeSess) 
        REFERENCES Session(FormationcodeForm, codeSess)
);

-- Modification de la table Inscription pour ajouter la contrainte NOT NULL sur typeCours
ALTER TABLE Inscription 
MODIFY COLUMN typeCours VARCHAR(45) NOT NULL;