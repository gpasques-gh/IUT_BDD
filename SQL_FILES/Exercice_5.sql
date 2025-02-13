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


