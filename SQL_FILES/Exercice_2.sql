-- EXERCICE 21

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

end;

