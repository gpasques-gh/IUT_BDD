-- EXERCICE 11

DECLARE
    v_titre FILM.TITRE%TYPE;
    v_nbEntree FILM.ENTREE%TYPE;

BEGIN
    SELECT TITRE, ROUND(ENTREE, -2) INTO v_titre, v_nbEntree FROM FILM
    WHERE ENTREE = (SELECT MAX(ENTREE) FROM FILM);
    DBMS_OUTPUT.PUT_LINE('Titre : ' || v_titre);
    DBMS_OUTPUT.PUT_LINE('Nombre d entrées : ' || v_nbEntree);
END;

-- EXERCICE 12

DECLARE
    v_idFilm FILM.IDFILM%TYPE := :idfilm;
    v_noteMoyenne NOTATION.NOTE%TYPE;
    v_titre FILM.TITRE%TYPE;
    v_countFilm NUMBER(3,0);

BEGIN
    SELECT COUNT(IDFILM) INTO v_countFilm FROM FILM
    WHERE IDFILM = v_idFilm;

    IF v_countFilm = 1 THEN
        SELECT TITRE, AVG(NOTE) INTO v_titre, v_noteMoyenne
        FROM FILM INNER JOIN NOTATION ON FILM.IDFILM = NOTATION.IDFILM
        WHERE FILM.IDFILM = v_idfilm
        GROUP BY TITRE, FILM.IDFILM;


        IF v_noteMoyenne >= 8 AND v_noteMoyenne <= 10 THEN
            DBMS_OUTPUT.PUT_LINE(v_titre || ' : Très bon.');
        ELSIF v_noteMoyenne >= 5 AND v_noteMoyenne < 8 THEN
            DBMS_OUTPUT.PUT_LINE(v_titre || ' : Bon.');
        ELSE
            DBMS_OUTPUT.PUT_LINE(v_titre || ' : Moyen.');
        END IF;
    ELSE
       DBMS_OUTPUT.PUT_LINE('ID de film invalide.');
    END IF;
END;

-- EXERCICE 13

DECLARE
    v_email INTERNAUTE.EMAIL%TYPE := :Email;
    v_nomInt INTERNAUTE.NOMINT%TYPE := :Nom;
    v_prenomInt INTERNAUTE.PRENOMINT%TYPE := :Prenom;
    v_paysInt INTERNAUTE.PAYSINT%TYPE := :Pays;
    v_count NUMBER(3,0);

BEGIN
    SELECT COUNT(EMAIL) INTO v_count FROM INTERNAUTE
    WHERE EMAIL = v_email;

    IF v_count = 0
    AND v_email IS NOT NULL
    AND v_nomInt IS NOT NULL
    AND v_prenomInt IS NOT NULL
    AND v_paysInt IS NOT NULL THEN
        INSERT INTO INTERNAUTE VALUES (v_email, v_nomInt, v_prenomInt, v_paysInt);
        DBMS_OUTPUT.PUT_LINE('Internaute créé : EMAIL = ' || v_email || ', NOMINT = ' || v_nomInt || ', PRENOMINT = ' || v_prenomInt || ', PAYSINT = ' || v_paysInt);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Internaute déjà existant ou invalide.');
    END IF;

END;