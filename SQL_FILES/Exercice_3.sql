-- EXERCICE 31

declare

    v_titre_entree film.titre%type;
    v_titre_final film.titre%type;
    v_idfilm film.idfilm%type;
    v_count number(1,0);

    cursor casting (id_f film.idfilm%type) is
    select nom, prenom
    from acteur inner join jouer on acteur.idacteur = jouer.idacteur
    where id_f = idfilm;

begin

    v_titre_entree := :entree_titre;
    select count(idfilm) into v_count
    from FILM
    where lower(titre) like '%' || lower(v_titre_entree) || '%';



    if v_count = 1 then
        select count(idfilm), titre, idfilm into v_count, v_titre_final, v_idfilm
        from film
        where lower(titre) like '%' || lower(v_titre_entree) || '%'
        group by idfilm, titre;
        DBMS_OUTPUT.PUT_LINE('Casting du film ' || v_titre_final);
        for curs_acteur in casting(v_idfilm) loop
            DBMS_OUTPUT.PUT_LINE(curs_acteur.prenom || ' ' || curs_acteur.nom);
        end loop;
    elsif v_count = 0 then
        DBMS_OUTPUT.PUT_LINE('Aucun film avec ce titre.');
    else
        DBMS_OUTPUT.PUT_LINE('Plusieurs films avec ce titre.');
    end if;

end;

-- EXERCICE 32

declare


    v_email internaute.email%type := :email_entree;
    v_count number(1,0);
    v_nom internaute.nomint%type;
    v_prenom internaute.nomint%type;
    v_moy number(4,2) := 0;
    v_sum number(4,0) := 0;

    cursor interns (p_email internaute.email%type) is
    select note, titre
    from notation inner join film on notation.IDFILM = film.IDFILM
    where p_email = notation.email;

begin

    select count(email) into v_count
    from INTERNAUTE
    where email = v_email;

    if v_count = 1 then

        select nomint, prenomint into v_nom, v_prenom
        from internaute
        where email = v_email;

        DBMS_OUTPUT.PUT_LINE('Notes de ' || v_prenom || ' ' || v_nom || ' (' || v_email || ') : ');

        for note in interns(v_email) loop
                DBMS_OUTPUT.PUT_LINE(' - ' || note.titre || ' : ' || note.NOTE);
        end loop;

        select trunc(avg(note), 2) into v_moy
        from notation
        where email = v_email;

        DBMS_OUTPUT.PUT_LINE('Moyenne des de ' || v_prenom || ' ' || v_nom || ' (' || v_email || ') : ' || v_moy);
    elsif v_count = 0 then
        DBMS_OUTPUT.PUT_LINE('Email non présent dans la base de données');
    end if;
end;

-- EXERCICE 33

declare


    cursor c_film is
        select titre, datesortie, idfilm
        from film;

    cursor c_acteur (id_f film.idfilm%type) is
        select nom, prenom
        from acteur inner join jouer on acteur.idacteur = jouer.idacteur
        where id_f = idfilm
        order by nom;

begin

    for r_film in c_film loop
        DBMS_OUTPUT.PUT_LINE('Acteurs ayant joué dans ' || r_film.TITRE || ' sorti le ' || r_film.DATESORTIE);
        for r_acteur in c_acteur(r_film.IDFILM) loop
            DBMS_OUTPUT.PUT_LINE(' - ' || r_acteur.PRENOM || ' ' || r_acteur.NOM);
        end loop;
    end loop;

end;








