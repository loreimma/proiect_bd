--Cererea 1
--Afisati pentru fiecare client numarul total de livrari, numarul total de colete 
--si numarul de recenzii oferite. Afisati doar clientii care au cel putin o livrare.
--Elemente acoperite: a), d), e)

SELECT c.nume AS "Nume Client",
    LOWER(c.email) AS "Email",
    COUNT(DISTINCT l.id_livrare) AS "Numar Livrari",
    NVL((SELECT COUNT(*)
        FROM COLET co
                JOIN LIVRARE li ON co.id_livrare=li.id_livrare
        WHERE li.id_client=c.id_client),0) AS "Numar Colete",
    NVL((SELECT COUNT(*)
        FROM RECENZIE r
        WHERE r.id_client=c.id_client),0) AS "Numar Recenzii",
    DECODE(COUNT(DISTINCT l.id_livrare),
            1, 'Client Ocazional', 'Client Activ') AS "Tip Client"
FROM CLIENT c
        JOIN LIVRARE l ON c.id_client=l.id_client
GROUP BY c.id_client, c.nume, c.email
ORDER BY COUNT(DISTINCT l.id_livrare) DESC;

--Cererea 2
--Pentru fiecare livrare afisati numarul total de colete si 
--clasificati livrarea in functie de colete.
--Element acoperite: b), d), e)
SELECT info_livrare."ID Livrare",
       info_livrare."Nume Client",
       info_livrare."Numar Colete",
       info_livrare."Clasificare"
FROM(SELECT l.id_livrare AS "ID Livrare", 
     UPPER(c.nume) AS "Nume Client", 
     COUNT(co.id_colet) AS "Numar Colete",
    CASE
        WHEN COUNT(co.id_colet)>=3 THEN 'Livrare mare'
        WHEN COUNT(co.id_colet)=2 THEN 'Livrare medie'
        ELSE 'Livrare mica'
        END AS "Clasificare"
FROM LIVRARE l JOIN CLIENT c ON l.id_client=c.id_client
               LEFT JOIN COLET co ON l.id_livrare=co.id_livrare
GROUP BY l.id_livrare, c.nume) info_livrare ORDER BY info_livrare."Numar Colete" DESC;

--Cererea 3
--Afisati curierii care au efectuat un numar de livrari
--mai mare decat media tuturor curierilor.
--Elemente acoperite: b), c), e) f)

WITH livrari_curieri AS 
    (SELECT a.id_angajat, a.nume, COUNT(l.id_livrare) AS numar_livrari
     FROM ANGAJAT a JOIN CURIER c ON a.id_angajat=c.id_angajat
     LEFT JOIN LIVRARE l ON c.id_angajat=l.id_curier
     GROUP BY a.id_angajat, a.nume)
SELECT nume AS "Nume Curier", numar_livrari AS "Numar Livrari",
       CASE
            WHEN numar_livrari>=5 THEN 'Curier foarte activ'
            WHEN numar_livrari BETWEEN 2 AND 4 THEN 'Curier activ'
            ELSE 'Curier putin activ'
            END AS "Clasificare"
FROM livrari_curieri
WHERE numar_livrari>(SELECT AVG(numar_livrari)
            FROM(SELECT COUNT(id_livrare) AS numar_livrari
            FROM LIVRARE GROUP BY id_curier))
ORDER BY numar_livrari DESC;


--Cererea 4
--Afisati livrarile impreuna cu numele clientului,
--numele curierului si numarul total de colete din fiecare livrare.
--Elemente acoperite: a), d), e)

SELECT l.id_livrare AS "ID Livrare", INITCAP(cl.nume) AS "Client",
        NVL(a.nume, 'Fara Curier') AS "Curier",
        COUNT(c.id_colet) AS "Numar Colete",
        DECODE(COUNT(c.id_colet),1,'Livrare mica', 'Livrare mare') AS "Tip Livrare"
FROM LIVRARE l JOIN CLIENT cl ON l.id_client=cl.id_client
               LEFT JOIN CURIER cu ON l.id_curier=cu.id_angajat
               LEFT JOIN ANGAJAT a ON cu.id_angajat=a.id_angajat
               LEFT JOIN COLET c ON l.id_livrare=c.id_livrare
GROUP BY l.id_livrare, cl.nume, a.nume
ORDER BY COUNT(c.id_colet)DESC;

--Cererea 5
--Afisati pentru fiecare client numarul total de livrari,
--numarul total de recenzii si statusul activitatii clientului.
--Elemente acoperite a), d), e), f)

WITH statistica_client AS(
    SELECT c.id_client, c.nume, 
           COUNT(DISTINCT l.id_livrare) AS numar_livrari,
           COUNT(DISTINCT r.id_recenzie) AS numar_recenzii
    FROM CLIENT c
            LEFT JOIN LIVRARE l ON c.id_client=l.id_client
            LEFT JOIN RECENZIE r ON c.id_client=r.id_client
    GROUP BY c.id_client, c.nume)
SELECT nume AS "Nume Client",
       numar_livrari AS "Numar Livrari",
       numar_recenzii AS "Numar Recenzii",
       
       CASE
            WHEN numar_livrari>=5 THEN 'Client Fidel'
            WHEN numar_livrari BETWEEN 2 AND 4 THEN 'Client Activ'
            ELSE 'Client Nou'
            END AS "Categorie Client"
FROM statistica_client
ORDER BY numar_livrari DESC;
    