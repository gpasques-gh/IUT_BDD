-- EXERCICE 41

DECLARE
    v_email INTERNAUTE.EMAIL%TYPE := :Email;
    v_nomInt INTERNAUTE.NOMINT%TYPE := :Nom;
    v_prenomInt INTERNAUTE.PRENOMINT%TYPE := :Prenom;
    v_paysInt INTERNAUTE.PAYSINT%TYPE := :Pays;

BEGIN
    IF v_email LIKE '%@%' THEN
        INSERT INTO INTERNAUTE VALUES (v_email, v_nomInt, v_prenomInt, v_paysInt, NULL);
        DBMS_OUTPUT.PUT_LINE('Internaute créé : EMAIL = ' || v_email || ', NOMINT = ' || v_nomInt || ', PRENOMINT = ' || v_prenomInt || ', PAYSINT = ' || v_paysInt);
    else
        DBMS_OUTPUT.PUT_LINE('Format de mail invalide.');
    end if;

    EXCEPTION
    WHEN dup_val_on_index then
        DBMS_OUTPUT.PUT_LINE('Internaute déjà existant ou invalide.');

END;

-- EXERCICE 42

declare

    v_email INTERNAUTE.EMAIL%TYPE := :Email;
    v_idfilm FILM.IDFILM%TYPE := :IDFilm;
    v_note NOTATION.NOTE%TYPE := :Note;
    v_count number(1,0);

    email_inexistant EXCEPTION;
    id_inexistant EXCEPTION;

begin

    select count(email) into v_count
    from INTERNAUTE
    where email = v_email;

    IF v_count != 1 then
        raise email_inexistant;
    end if;

    select count(idfilm) into v_count
    from film
    where idfilm = v_idfilm;

    if v_count != 1 then
        raise id_inexistant;
    end if;

    INSERT INTO NOTATION VALUES (v_email, v_idfilm, v_note, sysdate);
    DBMS_OUTPUT.PUT_LINE('Note insérée dans la base.');

    EXCEPTION
    WHEN email_inexistant then
        DBMS_OUTPUT.PUT_LINE('Email non présent dans la base.');
    WHEN id_inexistant then
        DBMS_OUTPUT.PUT_LINE('Film non présent dans la base.');
    WHEN dup_val_on_index then
        DBMS_OUTPUT.PUT_LINE('Film déjà noté par cet internaute.');

end;