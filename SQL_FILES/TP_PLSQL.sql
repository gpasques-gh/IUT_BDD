-- QUESTION 1.1

-- CLE ETRANGERES
-- Table PHOTO : NumAuteur, NumSerie
-- Table SERIE : Rien
-- Table MOTCLE : Rien
-- TABLE CORRESPOND : NumPhoto, NumMot
-- Table AUTEUR : Rien
-- Table AGENCE : Rien
-- Table CONTRAT : NumAuteur, NumAgence
-- Table CLIENT : Rien
-- Table ACHETE : NumCli, NumPhoto
-- Table FACTURE : NumCli

-- QUESTION 1.2

CREATE TABLE SERIE (
    NumSerie NUMBER(3,0) CONSTRAINT CPrimSER PRIMARY KEY,
    NomSerie VARCHAR2(50),
    Commentaire VARCHAR2(100)
);

CREATE TABLE MOTCLE (
    NumMot NUMBER(3,0) CONSTRAINT CPrimMC PRIMARY KEY,
    LibMot VARCHAR2(30)
);

CREATE TABLE AUTEUR (
    NumAuteur VARCHAR2(10) CONSTRAINT CPrimAUT PRIMARY KEY,
    NomAut VARCHAR2(30),
    PrenomAut VARCHAR2(30),
    Email VARCHAR2(50),
    Statut VARCHAR2(40)
);

CREATE TABLE AGENCE (
    NomAgence VARCHAR2(50) CONSTRAINT CPrimAG PRIMARY KEY,
    Adresse VARCHAR2(150),
    Site VARCHAR2(60)
);

CREATE TABLE CLIENT (
    NumCli VARCHAR2(10) CONSTRAINT CPrimCLI PRIMARY KEY,
    Nom VARCHAR2(30),
    Prenom VARCHAR2(30),
    Ident VARCHAR2(30),
    MDP VARCHAR2(50),
    Adresse VARCHAR2(150),
    CP VARCHAR2(50),
    Ville VARCHAR2(50),
    RIB VARCHAR2(50)
);

CREATE TABLE FACTURE (
    NumFact NUMBER(3,0) CONSTRAINT CPrimFACT PRIMARY KEY,
    NumCli VARCHAR2(10) CONSTRAINT CEtrFACT REFERENCES CLIENT(NumCli),
    Montant NUMBER(7,2),
    Statut VARCHAR2(15),
    DateFact DATE
);

CREATE TABLE PHOTO (
    NumPhoto VARCHAR2(15) CONSTRAINT CPrimPH PRIMARY KEY,
    Poids NUMBER(5,2),
    Titre VARCHAR2(40),
    DatePrise DATE,
    Prix NUMBER(10,2),
    Pays VARCHAR2(50),
    NumAuteur VARCHAR2(10) CONSTRAINT CEtrPH_AUT REFERENCES AUTEUR(NumAuteur),
    NbConsult NUMBER(5,0),
    NomFich VARCHAR2(50),
    NumSerie NUMBER(3,0) CONSTRAINT CEtrPH_SER REFERENCES SERIE(NumSerie),
    NumDansSerie NUMBER(3,0)
);

CREATE TABLE CORRESPOND (
    NumPhoto VARCHAR2(15) CONSTRAINT CEtrCOR_PH REFERENCES PHOTO(NumPhoto),
    NumMot NUMBER(3,0) CONSTRAINT CEtrCOR_MOT REFERENCES MOTCLE(NumMot),
    CONSTRAINT CPrimCOR PRIMARY KEY (NumPhoto, NumMot)
);

CREATE TABLE CONTRAT (
    NumAuteur VARCHAR2(10) CONSTRAINT CEtrCONTRAT_AUT REFERENCES AUTEUR(NumAuteur),
    NomAgence VARCHAR2(50) CONSTRAINT CEtrCONTRAT_AG REFERENCES AGENCE(NomAgence),
    CONSTRAINT CPrimCONTRAT PRIMARY KEY (NumAuteur, NomAgence)
);

CREATE TABLE ACHETE (
    NumCli VARCHAR2(10) CONSTRAINT CEtrACH_CLI REFERENCES CLIENT(NumCli),
    NumPhoto VARCHAR2(15) CONSTRAINT CEtrACH_PH REFERENCES PHOTO(NumPhoto),
    DateAchat DATE,
    CONSTRAINT CPrimACH PRIMARY KEY (NumCli, NumPhoto)
);

-- 1.3

-- CLIENTS
INSERT INTO client values ('CL0001', 'Piroux', 'Samy', 'samy', 'A32Z', '12 RUE DE LA COLLINE', '54000', 'NANCY', '42667177534412');
INSERT INTO client values ('CL0002', 'Fanier', 'Gabriel', 'gabriel', 'AZDFE', '43 RUE DES LILAS', '69000', 'LYON', '3333544577322');
INSERT INTO client values ('CL0003', 'Vigor', 'Denis', 'denis', 'HR33', '65 RUE DE LA CONVENTION', '75015', 'PARIS', '6353952214482');
INSERT INTO client values ('CL0004', 'Duponoy', 'Guillaume', 'guillaum', 'AQS13', '234 RUE EMILE ZOLA', '59000', 'LILLES', '6424656674118');
INSERT INTO client values ('CL0005', 'Abel', 'Claire', 'claire', 'HT453', '34 RUE DE CROIX NIVERT', '66000', 'PERPIGNAN', '5436485522563');
INSERT INTO client values ('CL0006', 'Finiet', 'Lise', 'lise', 'T8212', '123 RUE CAMBRONNE', '11000', 'MONTPELLIER', '3355627545335');
INSERT INTO client values ('CL0007', 'Michalo', 'Charlotte', 'charlott', 'OEG35', '74 RUE DES ACACIAS', '88000', 'EPINAL', '3758582222444');
INSERT INTO client values ('CL0008', 'Ribeira', 'Madeleine', 'madelein', '53GSF', '85 RUE BARTHOLDI', '45100', 'ORLEANS', '6648285674836');
INSERT INTO client values ('CL0009', 'Rouva', 'Lena', 'lena', 'TR5F4', '153 RUE DE LA REINE', '37100', 'TOURS', '733463542826535');
INSERT INTO client values ('CL0010', 'Boulard', 'Laure', 'laure', '1SR38', '232 BD DES ARMEES', '29200', 'BREST', '5475879984331');

-- AUTEURS
INSERT INTO auteur values ('A0001', 'Martin', 'Denis', 'Denis.Martin@free.fr', 'contractuel');
INSERT INTO auteur values ('A0002', 'Rivanau', 'Clotilde', 'Clotilde.Rivanau@free.fr', 'contractuel');
INSERT INTO auteur values ('A0003', 'Vigard', 'Mathilde', 'Mathilde.Vigard@free.fr', 'indépendant');
INSERT INTO auteur values ('A0004', 'Picard', 'Daniel', 'Daniel.Picard@wanadoo.fr', 'contractuel');
INSERT INTO auteur values ('A0005', 'Vanier', 'Jean', 'Jean.Vanier@orange.fr', 'contractuel');
INSERT INTO auteur values ('A0006', 'Dupars', 'Isabelle', 'Isabelle.Dupars@gmail.fr', 'indépendant');
INSERT INTO auteur values ('A0007', 'Decours', 'Hélène', 'Helene.Decours@free.fr', 'indépendant');
INSERT INTO auteur values ('A0012', 'Ledoux', 'Richard', 'Richard.Ledoux@gmail.fr', 'contractuel');
INSERT INTO auteur values ('A0014', 'Davilow', 'Patrick', 'Patrick.Davilow@free.fr', 'indépendant');

-- AGENCES
INSERT INTO agence values ('Ballery Elisabeth', '58 rue Victor Hugo 69002 LYON', 'balleryArt.com');
INSERT INTO agence values ('Biosphoto', '8 rue de la convention 75015 PARIS', 'biosphoto.com');
INSERT INTO agence values ('OBJECTIF UNE', '172 rue Duguesclin 69003 LYON', 'objectif.com');
INSERT INTO agence values ('Presse Magazine', '60 rue Caumartin 75009 PARIS', 'siliPress.fr');
INSERT INTO agence values ('Synthèse et Médias', '5 rue Roussin 75015 PARIS', 'synthesemedias.com');

-- SERIES
INSERT INTO serie values (1, 'Les transports en Espagne', 'modernité');
INSERT INTO serie values(2, 'Au coeur de l''Italie', 'Pour la presse de voyage');

-- MOT CLES
INSERT INTO motcle values (1, 'voyage');
INSERT INTO motcle values(2, 'artiste');
INSERT INTO motcle values(3, 'mer');
INSERT INTO motcle values(4, 'planète');
INSERT INTO motcle values(5, 'nature');
INSERT INTO motcle values(6, 'technologie');
INSERT INTO motcle values(7, 'astronomie');
INSERT INTO motcle values(8, 'écologie');
INSERT INTO motcle values(9, 'richesse');
INSERT INTO motcle values(10, 'mine');
INSERT INTO motcle values(11, 'culture');
INSERT INTO motcle values(12, 'politique');
INSERT INTO motcle values(13, 'or');
INSERT INTO motcle values(14, 'montagne');
INSERT INTO motcle values(15, 'peinture');
INSERT INTO motcle values(16, 'animal');
INSERT INTO motcle values(17, 'zoo');
INSERT INTO motcle values(18, 'cyclisme');
INSERT INTO motcle values(19, 'sport');

-- PHOTOS
INSERT INTO photo values ('P001', 1.32,  'Le palais ducal', '12/01/2020', 14, 'Italie', 'A0014', 12, 'genial.jpg', 2, 1);
INSERT INTO photo values ('P002',1.24,  'Voyage au Palais Pitti', '13/01/2020', 34, 'Italie', 'A0014', 14, 'voyage.jpg', 2, 2);
INSERT INTO photo values ('P003', 0.95,  'Les gondoles venitiennes', '14/01/2020', 64, 'Italie', 'A0014', 23, 'venise.jpg', 2, 3);
INSERT INTO photo values ('P004',  1.56,  'Piazza San Marco', '15/01/2020', 123, 'Italie', 'A0014', 12, 'territoire.jpg', 2, 4);
INSERT INTO photo values ('P005',  1.00,  'planete', '22/11/2021', 3, 'Canada', 'A0005', 5, 'planete.jpg', null, 0);
INSERT INTO photo values ('P006',  1.45,  'transport', '23/11/2021', 64, 'USA', 'A0006', 7, 'transport.jpg', null, 0);
INSERT INTO photo values ('P007',  1.55, 'pêche', '03/05/2022', 76, 'Japon', 'A0002', 4, 'peche.jpg', null, 0);
INSERT INTO photo values ('P008',  1.88,  'tradition', '04/05/2022', 98, 'Portugal', 'A0003', 6, 'tradition.jpg', null, 0);
INSERT INTO photo values ('P009',  1.22,  'pacifiste', '05/05/2020', 13, 'Danemark', 'A0007', 12, 'pacifiste.jpg', null, 0);
INSERT INTO photo values ('P0010', 1.23,  'bibliothèque', '14/04/2022', 87, 'Egypte', 'A0001', 4, 'bibliotheque.jpg', null, 0);
INSERT INTO photo values ('P0011', 0.76,  'monument', '23/10/2020', 76, 'Maroc', 'A0004', 23, 'batiment.jpg', null, 0);
INSERT INTO photo values ('P0012',  1.84,  'bureau', '16/08/2020', 71, 'Espagne', 'A0012', 9, 'bureau.jpg', 1, 1);
INSERT INTO photo values ('P0013',  1.89,  'avion', '17/08/2019', 453, 'Espagne', 'A0012', 14, 'avion.jpg', 1, 2);
INSERT INTO photo values ('P0014',  1.87,  'route', '18/08/2019', 5, 'Espagne', 'A0005', 55, 'route.jpg', 1, 3);
INSERT INTO photo values ('P0015',  0.96,  'voiture', '19/08/2021', 74, 'Espagne', 'A0006', 15, 'voiture.jpg', 1, 4);
INSERT INTO photo values ('P0016',  1.54, 'ordinateur', '17/09/2022', 9, 'France', 'A0002', 164, 'ordinateur.jpg', null, 0);
INSERT INTO photo values ('P0017',  1.84, 'telephone', '18/09/2022', 74, 'USA', 'A0003', 13, 'telephone.jpg', null, 0);
INSERT INTO photo values ('P0018',  1.44,  'collection', '15/05/2022', 56, 'Japon', 'A0007', 35, 'collection.jpg', null, 0);
INSERT INTO photo values ('P0019',  1.76,  'mer', '16/05/2020', 55, 'chine', 'A0003', 13, 'mer.jpg', null, 0);
INSERT INTO photo values ('P0020',  1.66,  'volcan', '17/05/2019', 22, 'Hawaii', 'A0007', 4, 'volcan.jpg', null, 0);

-- CORRESPOND
INSERT INTO correspond values ('P001', 1);
INSERT INTO correspond values('P001', 2);
INSERT INTO correspond values('P002', 3);
INSERT INTO correspond values('P002', 4);
INSERT INTO correspond values('P003', 5);
INSERT INTO correspond values('P003', 14);
INSERT INTO correspond values('P004', 2);
INSERT INTO correspond values('P004', 11);
INSERT INTO correspond values('P005', 5);
INSERT INTO correspond values('P005', 8);
INSERT INTO correspond values('P006', 18);
INSERT INTO correspond values('P006', 19);
INSERT INTO correspond values('P007', 3);
INSERT INTO correspond values('P007', 5);
INSERT INTO correspond values('P008', 2);
INSERT INTO correspond values('P008', 11);
INSERT INTO correspond values('P009', 11);
INSERT INTO correspond values('P009', 12);
INSERT INTO correspond values('P0010', 9);
INSERT INTO correspond values('P0010', 11);
INSERT INTO correspond values('P0011', 1);
INSERT INTO correspond values('P0011', 11);
INSERT INTO correspond values('P0012', 1);
INSERT INTO correspond values('P0012', 12);
INSERT INTO correspond values('P0013', 8);
INSERT INTO correspond values('P0013', 19);
INSERT INTO correspond values('P0014', 8);
INSERT INTO correspond values('P0014', 19);
INSERT INTO correspond values('P0015', 8);
INSERT INTO correspond values('P0015', 19);
INSERT INTO correspond values('P0016', 6);
INSERT INTO correspond values('P0017', 6);
INSERT INTO correspond values('P0017', 11);
INSERT INTO correspond values('P0018', 2);
INSERT INTO correspond values('P0018', 9);
INSERT INTO correspond values('P0019', 4);
INSERT INTO correspond values('P0019', 5);
INSERT INTO correspond values('P0020', 4);
INSERT INTO correspond values('P0020', 14);

-- CONTRATS
INSERT INTO contrat values ('A0001', 'Biosphoto');
INSERT INTO contrat values ('A0002', 'OBJECTIF UNE');
INSERT INTO contrat values ('A0004', 'Presse Magazine');
INSERT INTO contrat values ('A0005', 'Biosphoto');
INSERT INTO contrat values ('A0012', 'Synthèse et Médias');

-- ACHATS
INSERT INTO achete values ('CL0001', 'P001', '13/01/2023');
INSERT INTO achete values ('CL0001', 'P007', '10/08/2023');
INSERT INTO achete values ('CL0001', 'P0012', '19/08/2023');
INSERT INTO achete values ('CL0001', 'P0013', '06/09/2023');
INSERT INTO achete values ('CL0001', 'P0015', '24/08/2023');
INSERT INTO achete values ('CL0002', 'P002', '14/01/2023');
INSERT INTO achete values ('CL0002', 'P003', '23/03/2024');
INSERT INTO achete values ('CL0002', 'P006', '24/11/2022');
INSERT INTO achete values ('CL0002', 'P007', '10/03/2023');
INSERT INTO achete values ('CL0002', 'P008', '11/08/2023');
INSERT INTO achete values ('CL0002', 'P009', '10/01/2022');
INSERT INTO achete values ('CL0002', 'P0012', '21/08/2023');
INSERT INTO achete values ('CL0002', 'P0013', '21/08/2023');
INSERT INTO achete values ('CL0002', 'P0016', '22/09/2023');
INSERT INTO achete values ('CL0002', 'P0017', '22/09/2023');
INSERT INTO achete values ('CL0003', 'P004', '16/01/2023');
INSERT INTO achete values ('CL0003', 'P005', '16/03/2024');
INSERT INTO achete values ('CL0003', 'P006', '11/03/2024');
INSERT INTO achete values ('CL0003', 'P0012', '12/03/2024');
INSERT INTO achete values ('CL0003', 'P0013', '22/03/2024');
INSERT INTO achete values ('CL0003', 'P0014', '22/09/2023');
INSERT INTO achete values ('CL0003', 'P0015', '12/03/2024');
INSERT INTO achete values ('CL0003', 'P0016', '22/09/2023');
INSERT INTO achete values ('CL0003', 'P0017', '09/03/2024');
INSERT INTO achete values ('CL0003', 'P0018', '22/09/2023');
INSERT INTO achete values ('CL0003', 'P0020', '11/08/2023');
INSERT INTO achete values ('CL0004', 'P003', '16/03/2024');
INSERT INTO achete values ('CL0004', 'P004', '16/11/2023');
INSERT INTO achete values ('CL0004', 'P005', '23/11/2023');
INSERT INTO achete values ('CL0004', 'P0015', '23/08/2023');
INSERT INTO achete values ('CL0005', 'P006', '24/11/2022');
INSERT INTO achete values ('CL0005', 'P009', '06/04/2023');
INSERT INTO achete values ('CL0005', 'P0012', '19/03/2023');
INSERT INTO achete values ('CL0005', 'P0014', '22/12/2023');
INSERT INTO achete values ('CL0005', 'P0016', '21/09/2023');
INSERT INTO achete values ('CL0005', 'P0017', '21/10/2023');
INSERT INTO achete values ('CL0006', 'P007', '06/05/2023');
INSERT INTO achete values ('CL0006', 'P0010', '17/04/2022');
INSERT INTO achete values ('CL0006', 'P0016', '22/12/2023');
INSERT INTO achete values ('CL0007', 'P002', '14/06/2023');
INSERT INTO achete values ('CL0007', 'P007', '03/05/2023');
INSERT INTO achete values ('CL0007', 'P008', '03/06/2023');
INSERT INTO achete values ('CL0007', 'P009', '07/03/2023');
INSERT INTO achete values ('CL0007', 'P0010', '07/05/2023');
INSERT INTO achete values ('CL0007', 'P0015', '24/05/2023');
INSERT INTO achete values ('CL0007', 'P0017', '22/02/2023');
INSERT INTO achete values ('CL0007', 'P0018', '19/05/2022');
INSERT INTO achete values ('CL0007', 'P0019', '19/05/2022');
INSERT INTO achete values ('CL0007', 'P0013', '20/05/2022');
INSERT INTO achete values ('CL0008', 'P002', '16/08/2023');
INSERT INTO achete values ('CL0008', 'P006', '23/11/2022');
INSERT INTO achete values ('CL0008', 'P008', '04/05/2022');
INSERT INTO achete values ('CL0008', 'P009', '08/05/2023');
INSERT INTO achete values ('CL0008', 'P0010', '08/05/2023');
INSERT INTO achete values ('CL0008', 'P0013', '06/02/2023');
INSERT INTO achete values ('CL0008', 'P0017', '04/05/2022');
INSERT INTO achete values ('CL0008', 'P0018', '09/03/2024');
INSERT INTO achete values ('CL0008', 'P0019', '16/05/2023');
INSERT INTO achete values ('CL0008', 'P0020', '22/03/2024');
INSERT INTO achete values ('CL0009', 'P001', '13/01/2023');
INSERT INTO achete values ('CL0009', 'P005', '23/11/2023');
INSERT INTO achete values ('CL0009', 'P009', '10/05/2022');
INSERT INTO achete values ('CL0009', 'P0010', '17/04/2022');
INSERT INTO achete values ('CL0009', 'P0014', '03/04/2024');
INSERT INTO achete values ('CL0009', 'P0019', '17/05/2022');
INSERT INTO achete values ('CL0009', 'P0020', '17/05/2022');
INSERT INTO achete values ('CL0010', 'P003', '23/02/2023');
INSERT INTO achete values ('CL0010', 'P006', '23/11/2022');
INSERT INTO achete values ('CL0010', 'P008', '23/03/2024');
INSERT INTO achete values ('CL0010', 'P0010', '12/03/2024');
INSERT INTO achete values ('CL0010', 'P0011', '26/10/2022');
INSERT INTO achete values ('CL0010', 'P0012', '26/10/2022');
INSERT INTO achete values ('CL0010', 'P0013', '10/03/2024');
INSERT INTO achete values ('CL0010', 'P0014', '23/08/2023');
INSERT INTO achete values ('CL0010', 'P0015', '03/03/2024');
INSERT INTO achete values ('CL0010', 'P0016', '23/10/2023');

-- FACTURES
INSERT INTO facture values (1, 'CL0001', 14, 'solde', '31/01/2024');
INSERT INTO facture values (2, 'CL0001', 23, 'en cours', '31/08/2023');
INSERT INTO facture values (3, 'CL0002', 34, 'solde', '31/01/2024');
INSERT INTO facture values (4, 'CL0002', 453, 'solde', '31/03/2024');
INSERT INTO facture values (5, 'CL0002', 29, 'en cours', '31/08/2023');
INSERT INTO facture values (6, 'CL0003', 123, 'solde', '31/01/2024');

-- 2.0
SELECT Titre
FROM PHOTO
WHERE NumSerie = 2;

/* Résultats
TITRE

Le palais ducal
Voyage au Palais Pitti
Les gondoles venitiennes
Piazza San Marco
*/

-- 2.1
SELECT Titre, Prix, Pays, DatePrise, NomSerie
FROM PHOTO INNER JOIN AUTEUR ON PHOTO.NumAuteur = AUTEUR.NumAuteur
           INNER JOIN SERIE ON PHOTO.NumSerie = SERIE.NumSerie
WHERE NomAut = 'Davilow'
AND PrenomAut = 'Patrick';

/* Résultats
TITRE                           PRIX            PAYS        DATEPRISE       NOMSERIE

Le palais ducal                 14.00           Italie      2020-01-12      Au coeur de l'Italie
Voyage au Palais Pitti          34.00           Italie      2020-01-13      Au coeur de l'Italie
Les gondoles venitiennes        64.00           Italie      2020-01-14      Au coeur de l'Italie
Piazza San Marco                123.00          Italie      2020-01-15      Au coeur de l'Italie
*/

-- 2.2
SELECT Titre
FROM PHOTO INNER JOIN CORRESPOND on PHOTO.NumPhoto = CORRESPOND.NumPhoto
           INNER JOIN MOTCLE on CORRESPOND.NumMot = MOTCLE.NumMot
WHERE LOWER(Titre) LIKE '%nature%'
OR LOWER(LibMot) LIKE '%nature%';

/* Résultats
TITRE

Les gondoles venitiennes
planete
pêche
mer
*/

-- 2.3
SELECT LibMot, COUNT(NumPhoto) NbIndex
FROM MOTCLE LEFT JOIN CORRESPOND ON MOTCLE.NumMot = CORRESPOND.NumMot
GROUP BY LibMot, MOTCLE.NumMot
ORDER BY LibMot;

/* Résultats

LIBMOT          NBINDEX

animal          0
artiste         4
astronomie      0
culture         6
cyclisme        1
écologie        4
mer             2
mine            0
montagne        2
nature          4
or              0
peinture        0
planète,        3
politique       2
richesse        2
sport           4
technologie     2
voyage          3
zoo             0
*/

-- 2.4
SELECT NomSerie, SUM(Poids), TRUNC(AVG(Poids), 2)
FROM PHOTO INNER JOIN SERIE ON PHOTO.NumSerie = SERIE.NumSerie
GROUP BY SERIE.NumSerie, NomSerie;

/* Résultats
NOMSERIE                    POIDSTOTAL      POIDSMOYEN

Au coeur de l'Italie        5.07            1.26
Les transports en Espagne   6.56            1.64
 */

 -- 2.5
SELECT MOTCLE.LibMot
FROM CLIENT INNER JOIN ACHETE ON CLIENT.NumCli = ACHETE.NumCli
            INNER JOIN PHOTO ON ACHETE.NumPhoto = PHOTO.NumPhoto
            INNER JOIN CORRESPOND ON PHOTO.NumPhoto = CORRESPOND.NumPhoto
            INNER JOIN MOTCLE ON CORRESPOND.NumMot = MOTCLE.NumMot
WHERE Nom = 'Rouva'
GROUP BY MOTCLE.NumMot, MOTCLE.LibMot
ORDER BY COUNT(MOTCLE.NumMot), MOTCLE.LibMot;

/* Résultat
LIBMOT

artiste
montagne
politique
richesse
sport
voyage
culture
écologie
nature
planète
*/

-- 2.6
SELECT LibMot
FROM ACHETE INNER JOIN PHOTO ON ACHETE.NumPhoto = PHOTO.NumPhoto
            INNER JOIN CORRESPOND ON PHOTO.NumPhoto = CORRESPOND.NumPhoto
            INNER JOIN MOTCLE ON CORRESPOND.NumMot = MOTCLE.NumMot
GROUP BY MOTCLE.NumMot, LibMot
HAVING COUNT(ACHETE.NumPhoto) > 4
ORDER BY LibMot;

/* Résultats
LIBMOT

artiste
culture
cyclisme
écologie
mer
montagne
nature
planète
politique
richesse
sport
technologie
voyage
*/

-- 2.7
SELECT Nom
FROM CLIENT INNER JOIN ACHETE ON CLIENT.NumCli = ACHETE.NumCli
GROUP BY CLIENT.NumCli, Nom
HAVING COUNT(NumPhoto) >= ALL(SELECT COUNT(NumPhoto)
                              FROM CLIENT INNER JOIN ACHETE ON CLIENT.NumCli = ACHETE.NumCli
                              GROUP BY CLIENT.NumCli);

/* Résultats
NOM

Vigor
*/

-- 2.8
SELECT NumPhoto, Titre, TRUNC((SELECT COUNT(NumPhoto) FROM ACHETE WHERE NumPhoto = P2.NumPhoto)/NbConsult, 2) Ratio
FROM PHOTO P2;

/* Résultats

 P001,Le palais ducal,0.16
P002,Voyage au Palais Pitti,0.21
P003,Les gondoles venitiennes,0.13
P004,Piazza San Marco,0.16
P005,planete,0.6
P006,transport,0.71
P007,pêche,1
P008,tradition,0.66
P009,pacifiste,0.41
P0010,bibliothèque,1.25
P0011,monument,0.04
P0012,bureau,0.55
P0013,avion,0.42
P0014,route,0.07
P0015,voiture,0.33
P0016,ordinateur,0.03
P0017,telephone,0.38
P0018,collection,0.08
P0019,mer,0.23
P0020,volcan,0.75


 */

 -- 2.9
SELECT AGENCE.NomAgence
FROM AGENCE INNER JOIN CONTRAT ON AGENCE.NomAgence = CONTRAT.NomAgence
            INNER JOIN AUTEUR ON CONTRAT.NumAuteur = AUTEUR.NumAuteur
            INNER JOIN PHOTO ON AUTEUR.NumAuteur = PHOTO.NumAuteur
            INNER JOIN ACHETE ON PHOTO.NumPhoto = ACHETE.NumPhoto
GROUP BY PHOTO.NumPhoto, AGENCE.NomAgence
HAVING COUNT(ACHETE.NumPhoto) >= ALL (SELECT COUNT(ACHETE.NumPhoto)
                                      FROM ACHETE
                                      GROUP BY ACHETE.NumPhoto);

/* Résultats

NomAgence

Synthèse et Médias
*/

-- PL/SQL

-- 3.1

CREATE OR REPLACE FUNCTION GetMotCle(p_NumPhoto VARCHAR2)
RETURN VARCHAR2
IS
    v_Count NUMBER(1,0);
    v_MotsCles VARCHAR2(200);
    v_Erreur EXCEPTION;

    CURSOR v_CursMotsCles(p_NumPhotoCurs VARCHAR2) IS
        SELECT LibMot
        FROM MotCle INNER JOIN CORRESPOND ON MotCle.NumMot = CORRESPOND.NumMot
        WHERE NumPhoto = p_NumPhotoCurs;

BEGIN
    SELECT COUNT(NumPhoto) INTO v_Count
    FROM PHOTO
    WHERE NumPhoto = p_NumPhoto;

    IF v_Count = 0 THEN
        RAISE v_Erreur;
    END IF;

    FOR r_Mot IN v_CursMotsCles(p_NumPhoto) LOOP
        v_MotsCles := v_MotsCles || r_Mot.LibMot || ', ';
    END LOOP;
    v_MotsCles := RTRIM(v_MotsCles, ', ');

    RETURN v_MotsCles;

    EXCEPTION
    WHEN v_Erreur THEN
        DBMS_OUTPUT.PUT_LINE('Photo inexistante dans la base.');
        RETURN NULL;
END;

DECLARE
    v_MotsCles VARCHAR2(200);
BEGIN
    v_MotsCles := GetMotCle('P002');
    DBMS_OUTPUT.PUT_LINE(v_MotsCles);
END;

/* Résultats
Test avec 'P002' :

mer, planete

Test avec 'FAKE' :

Photo inexistante dans la base.
*/


-- 3.2

CREATE OR REPLACE FUNCTION GetAgence(p_NumAuteur VARCHAR2)
RETURN VARCHAR2
IS
    v_Count NUMBER(1,0);
    v_Erreur EXCEPTION;
    v_Agence VARCHAR2(250);
BEGIN

    SELECT COUNT(NumAuteur) INTO v_Count
    FROM AUTEUR
    WHERE NumAuteur = p_NumAuteur;

    IF v_Count = 0 THEN
        RAISE v_Erreur;
    END IF;

    SELECT COUNT(AGENCE.NomAgence) INTO v_Count
    FROM AGENCE INNER JOIN CONTRAT ON AGENCE.NomAgence = CONTRAT.NomAgence
    WHERE NumAuteur = p_NumAuteur;

    IF v_Count = 0 THEN
        v_Agence := 'Sans objet';
    ELSE
        SELECT 'NomAgence : ' || AGENCE.NomAgence || ' | Adresse : ' || Adresse INTO v_Agence
        FROM AGENCE INNER JOIN CONTRAT ON AGENCE.NomAgence = CONTRAT.NomAgence
        WHERE NumAuteur = p_NumAuteur;
    END IF;

    RETURN v_Agence;

    EXCEPTION
    WHEN v_Erreur THEN
        DBMS_OUTPUT.PUT_LINE('Auteur inexistant dans la base.');
        RETURN NULL;
END;

DECLARE
    v_Agence VARCHAR2(250);
BEGIN
    v_Agence := GetAgence('FAKE');
    DBMS_OUTPUT.PUT_LINE(v_Agence);
END;

/* Résultats
Test avec 'A0001' : NomAgence : Biosphoto | Adresse : 8 rue de la convention 75015 PARIS
Test avec 'A0006' : Sans objet
Test avec 'FAKE' : Auteur inexistant dans la base.
*/

-- 3.3

DECLARE
    CURSOR v_CursAuteur IS
    SELECT NomAut, PrenomAut, NumAuteur
    FROM AUTEUR;

    CURSOR v_CursPhotos(p_NumAuteur VARCHAR2) IS
    SELECT NumPhoto, Titre, DatePrise, Prix, Pays
    FROM PHOTO
    WHERE NumAuteur = p_NumAuteur;

    v_Agence VARCHAR2(250);
    v_MotsCles VARCHAR2(200);
    v_Count NUMBER(1,0);
BEGIN
    FOR r_Auteur in v_CursAuteur LOOP
        v_Agence := GetAgence(r_Auteur.NumAuteur);
        IF v_Agence = 'Sans objet' OR v_Agence IS NULL THEN
            DBMS_OUTPUT.PUT_LINE(r_Auteur.NomAut || ' ' || r_Auteur.PrenomAut);
        ELSE
            DBMS_OUTPUT.PUT_LINE(r_Auteur.NomAut || ' ' || r_Auteur.PrenomAut || ', ' || v_Agence);
        END IF;

        SELECT COUNT(NumPhoto) INTO v_Count
        FROM PHOTO
        WHERE NumAuteur = r_Auteur.NumAuteur;

        IF v_Count > 0 THEN
            FOR r_Photo in v_CursPhotos(r_Auteur.NumAuteur) LOOP
                DBMS_OUTPUT.PUT_LINE('  ' || r_Photo.NumPhoto || ', ' || r_Photo.Titre || ', ' || r_Photo.DatePrise || ', ' || r_Photo.Prix || '€, ' || r_Photo.Pays);
                v_MotsCles := GetMotCle(r_Photo.NumPhoto);
                DBMS_OUTPUT.PUT_LINE('      ' || v_MotsCles);
            END LOOP;
        ELSE
            DBMS_OUTPUT.PUT_LINE('  Cet auteur n a pas pris de photos.');
        END IF;
    END LOOP;
END;

/* Résultats

Martin Denis, NomAgence : Biosphoto | Adresse : 8 rue de la convention 75015 PARIS
  P0010, bibliothèque, 14/04/22, 87€, Egypte
      richesse, culture
Rivanau Clotilde, NomAgence : OBJECTIF UNE | Adresse : 172 rue Duguesclin 69003 LYON
  P007, pêche, 03/05/22, 76€, Japon
      mer, nature
  P0016, ordinateur, 17/09/22, 9€, France
      technologie
Vigard Mathilde
  P008, tradition, 04/05/22, 98€, Portugal
      artiste, culture
  P0017, telephone, 18/09/22, 74€, USA
      technologie, culture
  P0019, mer, 16/05/20, 55€, chine
      planète, nature
Picard Daniel, NomAgence : Presse Magazine | Adresse : 60 rue Caumartin 75009 PARIS
  P0011, monument, 23/10/20, 76€, Maroc
      voyage, culture
Vanier Jean, NomAgence : Biosphoto | Adresse : 8 rue de la convention 75015 PARIS
  P005, planete, 22/11/21, 3€, Canada
      nature, écologie
  P0014, route, 18/08/19, 5€, Espagne
      écologie, sport
Dupars Isabelle
  P006, transport, 23/11/21, 64€, USA
      cyclisme, sport
  P0015, voiture, 19/08/21, 74€, Espagne
      écologie, sport
Decours Hélène
  P009, pacifiste, 05/05/20, 13€, Danemark
      culture, politique
  P0018, collection, 15/05/22, 56€, Japon
      artiste, richesse
  P0020, volcan, 17/05/19, 22€, Hawaii
      planète, montagne
Ledoux Richard, NomAgence : Synthèse et Médias | Adresse : 5 rue Roussin 75015 PARIS
  P0012, bureau, 16/08/20, 71€, Espagne
      voyage, politique
  P0013, avion, 17/08/19, 453€, Espagne
      écologie, sport
Davilow Patrick
  P001, Le palais ducal, 12/01/20, 14€, Italie
      voyage, artiste
  P002, Voyage au Palais Pitti, 13/01/20, 34€, Italie
      mer, planète
  P003, Les gondoles venitiennes, 14/01/20, 64€, Italie
      nature, montagne
  P004, Piazza San Marco, 15/01/20, 123€, Italie
      artiste, culture
*/

-- 3.4

CREATE SEQUENCE SqSerie
START WITH 2
INCREMENT BY 1;

CREATE SEQUENCE SqPhoto
START WITH 20
INCREMENT BY 1;



CREATE OR REPLACE PROCEDURE AjoutPhoto(p_Poids NUMBER, p_Titre VARCHAR2, p_Date DATE, p_Prix NUMBER, p_Pays VARCHAR2, p_NumAuteur VARCHAR2, p_NomFich VARCHAR2, p_NumSerie NUMBER, p_Error OUT NUMBER)
IS
    v_Count NUMBER(1,0);
    v_ErreurAuteur EXCEPTION;
    v_ErreurSerie EXCEPTION;
    v_MaxDansSerie NUMBER(5,0);
BEGIN
    p_Error := 0;

    SELECT COUNT(NumAuteur) INTO v_Count
    FROM AUTEUR
    WHERE NumAuteur = p_NumAuteur;

    IF v_Count = 0 THEN
        RAISE v_ErreurAuteur;
    END IF;

    IF p_NumSerie = -1 THEN
        INSERT INTO SERIE VALUES (SqSerie.NEXTVAL, 'Nouvelle serie ' || SqSerie.CURRVAL, 'Commentaire');
        INSERT INTO PHOTO VALUES ('P00' || SqPhoto.NEXTVAL, p_Poids, p_Titre, p_Date, p_Prix, p_Pays, p_NumAuteur, 0, p_NomFich, SqSerie.CURRVAL, 1);
    ELSIF p_NumSerie = 0 THEN
        INSERT INTO PHOTO VALUES ('P00' || SqPhoto.NEXTVAL, p_Poids, p_Titre, p_Date, p_Prix, p_Pays, p_NumAuteur, 0, p_NomFich, NULL, 0);
    ELSE
        SELECT COUNT(NumSerie) INTO v_Count
        FROM SERIE
        WHERE NumSerie = p_NumSerie;

        IF v_Count = 0 THEN
            RAISE v_ErreurSerie;
        ELSE
            SELECT MAX(NumDansSerie) INTO v_MaxDansSerie
            FROM PHOTO
            WHERE NumSerie = p_NumSerie;
        END IF;

        INSERT INTO PHOTO VALUES ('P00' || SqPhoto.NEXTVAL, p_Poids, p_Titre, p_Date, p_Prix, p_Pays, p_NumAuteur, 0, p_NomFich, p_NumSerie, v_MaxDansSerie + 1);
    END IF;

    EXCEPTION
    WHEN v_ErreurAuteur THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : auteur inexistant dans la base.');
        p_Error := 1;
    WHEN v_ErreurSerie THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : série inexistante dans la base.');
        p_Error := 1;
    WHEN OTHERS THEN
        p_Error := 1;
END;

DECLARE
    v_Error NUMBER(1,0);
BEGIN
    AjoutPhoto(1.5, 'NouvellePhoto', sysdate, 50, 'France', 'A0001', 'NouvellePhoto.jpg', 1, v_Error);
    DBMS_OUTPUT.PUT_LINE(v_Error);
end;

/*
 P0022 1.50 NouvellePhoto 2025-03-04-15:42:58 50.00 France A0001 0 NouvellePhoto.jpg 1 5
 */

 DECLARE
    v_Error NUMBER(1,0);
BEGIN
    AjoutPhoto(1.5, 'NouvellePhoto2', sysdate, 50, 'France', 'FAKE', 'NouvellePhoto.jpg', 1, v_Error);
    DBMS_OUTPUT.PUT_LINE(v_Error);
end;

/*
 Erreur : auteur inexistant dans la base.
1
 */

DECLARE
    v_Error NUMBER(1,0);
BEGIN
    AjoutPhoto(1.5, 'NouvellePhoto3', sysdate, 50, 'France', 'A0001', 'NouvellePhoto.jpg', 0, v_Error);
    DBMS_OUTPUT.PUT_LINE(v_Error);
end;

/*
 P0023,1.50,NouvellePhoto3,2025-03-04 15:46:48,50.00,France,A0001,0,NouvellePhoto.jpg,,0
 */

 DECLARE
    v_Error NUMBER(1,0);
BEGIN
    AjoutPhoto(1.5, 'NouvellePhoto4', sysdate, 50, 'France', 'A0001', 'NouvellePhoto.jpg', -1, v_Error);
    DBMS_OUTPUT.PUT_LINE(v_Error);
end;

/*
  P0024,1.50,NouvellePhoto4,2025-03-04 15:49:01,50.00,France,A0001,0,NouvellePhoto.jpg,3,1
*/


DELETE FROM PHOTO WHERE TITRE = 'NouvellePhoto';
