-- EXERCICE 51

create or replace function moy_film (p_idfilm film.idfilm%type)
    return number is v_moy number(4,2);
        begin
            select avg(note) into v_moy from NOTATION
            where idfilm = p_idfilm
            group by idfilm;
            return v_moy;

            EXCEPTION
            when no_data_found then
                DBMS_OUTPUT.PUT_LINE('Film inexistant ou non noté.');
                return null;
            when others then
                DBMS_OUTPUT.PUT_LINE('Erreur ' || sqlerrm);
                return null;
end moy_film;

SELECT idfilm, TITRE, moy_film(idfilm) moy
from FILM
where moy_film(IDFILM) > 7;

-- EXERCICE 52

create or replace
procedure maj_moy(p_idfilm film.idfilm%type) is
begin
    update film set NOTE_MOYENNE = moy_film(p_idfilm)
    where idfilm = p_idfilm;

    exception
    when no_data_found then
        DBMS_OUTPUT.PUT_LINE('Film non présent dans la base.');
    when others then
        DBMS_OUTPUT.PUT_LINE('Erreur ' || sqlerrm);
end;

declare
begin
    maj_moy(11);
end;


insert into notation values ('germain.pasques@gmail.com', 11, 10, sysdate);
insert into notation values ('germain.pasques@gmail.com', 12, 10, sysdate);

select * from notation;

-- 5.00
-- 5.50

-- 5.83
-- 7.00

select * from film where idfilm = 11 or IDFILM = 12;
select * from film where idfilm = 12;

-- EXERCICE 53

create or replace
procedure insert_note(p_email varchar2, p_idfilm number, p_note number, p_erreur OUT NUMBER)
is
    v_count NUMBER(1,0);
    erreur EXCEPTION;
begin

    p_erreur := 0;

    select count(email) into v_count
    from INTERNAUTE
    where email = p_email;

    if v_count = 0 then
        raise erreur;
    end if;

    select count(idfilm) into v_count
    from film
    where idfilm = p_idfilm;

    if v_count = 0 then
        raise erreur;
    end if;

    select count(email) into v_count
    from NOTATION
    where email = p_email and IDFILM = p_idfilm;

    if v_count = 1 then
        update notation set note = p_note
        where email = p_email and IDFILM = p_idfilm;
    else
        insert into notation values (p_email, p_idfilm, p_note, sysdate);
    end if;

    maj_moy(p_idfilm);

    exception
    when erreur then
        p_erreur := 1;
end;

declare
    v_erreur NUMBER(1,0);
begin
    insert_note('germain.pasques@gmail.com', 15, 8, v_erreur);
    DBMS_OUTPUT.PUT_LINE('Erreur : ' || v_erreur);
    insert_note('germain.pasques@gmail.com', 11, 8, v_erreur);
    DBMS_OUTPUT.PUT_LINE('Erreur : ' || v_erreur);
    insert_note('germain.feur@gmail.com', 15, 8, v_erreur);
    DBMS_OUTPUT.PUT_LINE('Erreur : ' || v_erreur);
    insert_note('germain.pasques@gmail.com', 54, 8, v_erreur);
    DBMS_OUTPUT.PUT_LINE('Erreur : ' || v_erreur);
end;

select * from notation where email = 'germain.pasques@gmail.com';

create or replace procedure insert_film(p_titre varchar2, p_date_sortie date, p_id_out OUT number)
is
    v_count number(1,0);
    v_error exception;
    v_id number(3,0);
begin
    p_id_out := 0;
    select count(idfilm) into v_count
    from film
    where titre = p_titre
    and to_char(DATESORTIE, 'DD/MM/YYYY') = to_char(p_date_sortie, 'DD/MM/YYYY');

    if v_count = 1 then
        raise v_error;
    end if;

    select max(idfilm) + 1 into v_id
    from film;
    insert into film values (v_id, p_titre, p_date_sortie, NULL, NULL, NULL, NULL, NULL);

    exception
    when v_error then
        select idfilm into p_id_out
        from film
        where titre = p_titre
        and to_char(DATESORTIE, 'DD/MM/YYYY') = to_char(p_date_sortie, 'DD/MM/YYYY');

end;

declare
v_id number(3,0);
begin
    insert_film('Le Parrain', '12/08/1987', v_id);
    DBMS_OUTPUT.PUT_LINE('Si id different de 0 alors erreur : ' || v_id);
    insert_film('Inception', '21/07/2010', v_id);
    DBMS_OUTPUT.PUT_LINE('Si id different de 0 alors erreur : ' || v_id);
end;

select * from film;

delete from film where titre = 'Le Parrain';

create or replace function test_acteur(p_nom varchar2, p_prenom varchar2)
return number
is
    v_count number(1,0);
    v_idacteur number(3,0);
begin
    select count(idacteur) into v_count
    from acteur
    where nom = p_nom and prenom = p_prenom;

    if v_count = 1 then
        select idacteur into v_idacteur
        from acteur
        where nom = p_nom and prenom = p_prenom;
        return v_idacteur;
    else
        return 0;
    end if;

end;

declare
    v_idacteur number(3,0);
begin
    v_idacteur := test_acteur('Depardieu', 'Gérard');
    DBMS_OUTPUT.PUT_LINE('ID : ' || v_idacteur);
end;

select * from acteur;

-- exercice 56

create sequence sq_acteur
start with 31
increment by 1;

create or replace procedure insert_casting(p_nom varchar2, p_prenom varchar2, p_idfilm number, p_error out number)
is
    v_count number(1,0);
    v_count_casting number(1,0);
    v_idacteur number(3,0);
    erreur exception;
begin
    p_error := 0;

    select count(idfilm) into v_count
    from film
    where IDFILM = p_idfilm;

    if v_count = 0 then
        raise erreur;
    end if;

    select count(idacteur) into v_count
    from ACTEUR
    where nom = p_nom and prenom = p_prenom;

    if v_count = 1 then

        select idacteur into v_idacteur
        from ACTEUR
        where nom = p_nom and prenom = p_prenom;

        select count(idacteur) into v_count_casting
        from ACTEUR
        where IDACTEUR in (select IDACTEUR
                           from jouer
                           where idfilm = p_idfilm)
        and idacteur = v_idacteur;

        if v_count_casting = 1 then
            raise erreur;
        else
            insert into jouer values (p_idfilm, v_idacteur);
        end if;
    else
        insert into ACTEUR values (sq_acteur.nextval, p_nom, p_prenom, null);
        insert into jouer values (p_idfilm, sq_acteur.currval);
    end if;

    exception
    when erreur then
        p_error := 1;

end;

declare
    v_error number(1,0);
begin
    insert_casting('Germain', 'Pasques', 3, v_error);
    DBMS_OUTPUT.PUT_LINE('Erreur : ' || v_error);
end;

select sq_acteur.currval from dual;

select * from jouer;



SELECT IDACTEUR FROM JOUER WHERE IDFILM = 3;

-- EXOS 57

create or replace procedure pays_affichage(p_pays varchar2, p_error out number)
is
    v_count number(3,0);
    erreur exception;

    cursor c_film (p_pays film.paysfilm%type) is
        select titre, datesortie, idfilm
        from film
        where paysfilm = p_pays;

    cursor c_acteur (id_f film.idfilm%type) is
        select nom, prenom
        from acteur inner join jouer on acteur.idacteur = jouer.idacteur
        where id_f = idfilm
        order by nom;
begin

    p_error := 0;

    select count(IDFILM) INTO v_count
    FROM FILM
    WHERE PAYSFILM = p_pays;

    if v_count < 0 then
        raise erreur;
    end if;

    DBMS_OUTPUT.PUT_LINE('Films de ' || p_pays || ' : ');
    for r_film in c_film(p_pays) loop
        DBMS_OUTPUT.PUT_LINE('Acteur(s) ayant joué dans ' || r_film.TITRE || ' (IDFILM : ' || r_film.IDFILM || ') : ');
            for r_acteur in c_acteur(r_film.IDFILM) loop
                DBMS_OUTPUT.PUT_LINE('Prénom : ' || r_acteur.PRENOM);
                DBMS_OUTPUT.PUT_LINE('Nom : ' || r_acteur.NOM);
            end loop;
    end loop;

    exception
    when erreur then
        p_error := 1;
        DBMS_OUTPUT.PUT_LINE('Pays invalide.');
end;

declare
    v_erreur number(1,0);
    cursor c_pays is
        select distinct paysfilm
        from FILM;
begin
    for r_pays in c_pays loop
        pays_affichage(r_pays.PAYSFILM, v_erreur);
    end loop;
end;