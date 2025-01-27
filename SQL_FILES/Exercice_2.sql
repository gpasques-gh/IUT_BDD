-- EXERCICE 21 VERSION FETCH

DECLARE

    type film_rec is record(
        v_idfilm FILM.IDFILM%TYPE,
        v_titre FILM.TITRE%TYPE,
        v_moyenne NOTATION.NOTE%TYPE,
        v_nb_pers NUMBER(4,0),
        v_entree FILM.ENTREE%TYPE);

    v_film film_rec;

    CURSOR curs_film IS
    SELECT FILM.IDFILM, TITRE, AVG(NOTE), COUNT(EMAIL), ENTREE
    FROM FILM INNER JOIN NOTATION ON FILM.IDFILM = NOTATION.IDFILM
    GROUP BY FILM.IDFILM, TITRE, ENTREE;

BEGIN

    OPEN curs_film;
    LOOP
        FETCH curs_film INTO v_film;
        EXIT WHEN curs_film%notfound;

        DBMS_OUTPUT.PUT_LINE('Titre : ' || v_film.v_titre);
        DBMS_OUTPUT.PUT_LINE('Note moyenne : ' || v_film.v_moyenne);
        DBMS_OUTPUT.PUT_LINE('Nombre de personne ayant noté le film : ' || v_film.v_nb_pers);

        IF v_film.v_entree > 1000000 THEN
            DBMS_OUTPUT.PUT_LINE('Entrées : Succès');
        elsif v_film.v_entree > 500000 and v_film.v_entree < 1000000 then
            DBMS_OUTPUT.PUT_LINE('Entrées : Très bon');
        else
            DBMS_OUTPUT.PUT_LINE('Entrées : Honorable');
        end if;

    end loop;
    CLOSE curs_film;

end;

-- EXERCICE 21 VERSION FOREACH
DECLARE

    CURSOR curs_film IS
    SELECT FILM.IDFILM id, TITRE, TRUNC(AVG(NOTE), 2) moyenne, COUNT(EMAIL) notes, ENTREE
    FROM FILM INNER JOIN NOTATION ON FILM.IDFILM = NOTATION.IDFILM
    GROUP BY FILM.IDFILM, TITRE, ENTREE;

BEGIN
    FOR curs IN curs_film LOOP

        DBMS_OUTPUT.PUT_LINE('Titre : ' || curs.id);
        DBMS_OUTPUT.PUT_LINE('Note moyenne : ' || curs.titre);
        DBMS_OUTPUT.PUT_LINE('Nombre de personne ayant noté le film : ' || curs.moyenne);

        IF curs.ENTREE > 1000000 THEN
            DBMS_OUTPUT.PUT_LINE('Entrées : Succès');
        elsif curs.ENTREE > 500000 and curs.ENTREE < 1000000 then
            DBMS_OUTPUT.PUT_LINE('Entrées : Très bon');
        else
            DBMS_OUTPUT.PUT_LINE('Entrées : Honorable');
        end if;

    end loop;

end;

-- EXERCICE 22

ALTER TABLE FILM ADD NOTE_MOYENNE NUMBER(4,2);

DECLARE
    v_note_moyenne FILM.NOTE_MOYENNE%TYPE;

    CURSOR note_curs IS
    SELECT * FROM FILM
    FOR UPDATE OF NOTE_MOYENNE;

BEGIN
    FOR curs IN note_curs LOOP
        UPDATE FILM set NOTE_MOYENNE = (SELECT TRUNC(AVG(NOTE), 2)
                                        FROM NOTATION
                                        WHERE NOTATION.IDFILM = curs.IDFILM
                                        GROUP BY IDFILM)
        WHERE current of note_curs;
    end loop;
end;

-- EXERCICE 23

ALTER TABLE INTERNAUTE ADD TAUX NUMBER(3,2);

DECLARE
    v_taux NUMBER(3,2);
    v_total NUMBER(4,0);
    v_total_int NUMBER(4,0);
    CURSOR curs_taux IS
    SELECT note, internaute.EMAIL, idfilm
    FROM internaute inner join notation on notation.email = internaute.email
    FOR UPDATE OF taux;

BEGIN

    SELECT COUNT(NOTE) INTO v_total
    FROM NOTATION
    GROUP BY EMAIL
    HAVING COUNT(NOTE) >= ALL(SELECT COUNT(NOTE) FROM NOTATION GROUP BY EMAIL);

    FOR curs IN curs_taux LOOP
        SELECT COUNT(NOTE) / v_total INTO v_taux FROM NOTATION
        WHERE curs.email = notation.email;

        update internaute set taux = v_taux
        where internaute.email = curs.email;
    end loop;
end;