DROP TABLE RECENZIE CASCADE CONSTRAINTS;
DROP TABLE COLET CASCADE CONSTRAINTS;
DROP TABLE LIVRARE CASCADE CONSTRAINTS;
DROP TABLE CURIER CASCADE CONSTRAINTS;
DROP TABLE AGENT_POINT CASCADE CONSTRAINTS;
DROP TABLE ANGAJAT_DEPOZIT CASCADE CONSTRAINTS;
DROP TABLE CLIENT CASCADE CONSTRAINTS;
DROP TABLE DEPOZIT CASCADE CONSTRAINTS;
DROP TABLE ANGAJAT CASCADE CONSTRAINTS;

DROP SEQUENCE CLIENT_SEQ;
DROP SEQUENCE LIVRARE_SEQ;
DROP SEQUENCE COLET_SEQ;
DROP SEQUENCE DEPOZIT_SEQ;
DROP SEQUENCE RECENZIE_SEQ;
DROP SEQUENCE ANGAJAT_SEQ;


CREATE SEQUENCE CLIENT_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE LIVRARE_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE COLET_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE DEPOZIT_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE RECENZIE_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE ANGAJAT_SEQ START WITH 1 INCREMENT BY 1;

CREATE TABLE CLIENT
(id_client NUMBER DEFAULT CLIENT_SEQ.NEXTVAL PRIMARY KEY,
nume VARCHAR2(100) NOT NULL,
email VARCHAR2(100) NOT NULL UNIQUE
);

CREATE TABLE ANGAJAT
( id_angajat NUMBER DEFAULT ANGAJAT_SEQ.NEXTVAL PRIMARY KEY,
  nume VARCHAR2(100) NOT NULL
  );
  
CREATE TABLE CURIER
(id_angajat NUMBER PRIMARY KEY,
CONSTRAINT fk_curier_angajat
    FOREIGN KEY (id_angajat)
        REFERENCES ANGAJAT(id_angajat)
);

CREATE TABLE AGENT_POINT
(id_angajat NUMBER PRIMARY KEY,
CONSTRAINT fk_agent_point_angajat
    FOREIGN KEY (id_angajat)
        REFERENCES ANGAJAT(id_angajat)
);

CREATE TABLE ANGAJAT_DEPOZIT
(id_angajat NUMBER PRIMARY KEY,
CONSTRAINT fk_angajat_depozit_angajat
    FOREIGN KEY (id_angajat)
        REFERENCES ANGAJAT(id_angajat)
);

CREATE TABLE DEPOZIT
( id_depozit NUMBER DEFAULT DEPOZIT_SEQ.NEXTVAL PRIMARY KEY,
oras VARCHAR2(100) NOT NULL
);

CREATE TABLE LIVRARE
( id_livrare NUMBER DEFAULT LIVRARE_SEQ.NEXTVAL PRIMARY KEY,
id_client NUMBER NOT NULL,
id_curier NUMBER,

CONSTRAINT fk_livrare_client
    FOREIGN KEY (id_client)
        REFERENCES CLIENT(id_client),
        
CONSTRAINT fk_livrare_curier
    FOREIGN KEY (id_curier)
        REFERENCES CURIER(id_angajat)
);

CREATE TABLE COLET
(id_colet NUMBER DEFAULT COLET_SEQ.NEXTVAL PRIMARY KEY,
id_livrare NUMBER NOT NULL,
id_depozit NUMBER,

CONSTRAINT fk_colet_livrare
    FOREIGN KEY (id_livrare)
        REFERENCES LIVRARE(id_livrare),
        
CONSTRAINT fk_colet_depozit
    FOREIGN KEY (id_depozit)
        REFERENCES DEPOZIT(id_depozit)        
);

CREATE TABLE RECENZIE
(id_recenzie NUMBER DEFAULT RECENZIE_SEQ.NEXTVAL PRIMARY KEY,
id_client NUMBER NOT NULL,
id_livrare NUMBER UNIQUE,

CONSTRAINT fk_recenzie_client
    FOREIGN KEY (id_client)
        REFERENCES CLIENT(id_client),
        
CONSTRAINT fk_recenzie_livrare
    FOREIGN KEY (id_livrare)
        REFERENCES LIVRARE(id_livrare)        
);

INSERT INTO CLIENT (nume, email)
VALUES ('Andrei Popescu', 'andrei.popescu@email.com');
INSERT INTO CLIENT (nume, email)
VALUES ('Maria Ionescu', 'maria.ionescu@email.com');
INSERT INTO CLIENT (nume, email)
VALUES ('Alex Dumitru', 'alex.dumitru@email.com');
INSERT INTO CLIENT (nume, email)
VALUES ('Ioana Marin', 'ioana.marin@email.com');
INSERT INTO CLIENT (nume, email)
VALUES ('Radu Georgescu', 'radu.georgescu@email.com');

INSERT INTO ANGAJAT (nume)
VALUES ('Mihai Ionescu');
INSERT INTO ANGAJAT (nume)
VALUES ('Elena Popescu');
INSERT INTO ANGAJAT (nume)
VALUES ('Cristian Pavel');
INSERT INTO ANGAJAT (nume)
VALUES ('Adrian Matei');
INSERT INTO ANGAJAT (nume)
VALUES ('Bianca Tudor');
INSERT INTO ANGAJAT (nume)
VALUES ('George Marin');
INSERT INTO ANGAJAT (nume)
VALUES ('Larisa Ene');
INSERT INTO ANGAJAT (nume)
VALUES ('Robert Dinu');
INSERT INTO ANGAJAT (nume)
VALUES ('Simona Radu');
INSERT INTO ANGAJAT (nume)
VALUES ('Victor Ilie');

INSERT INTO CURIER (id_angajat)
VALUES (1);
INSERT INTO CURIER (id_angajat)
VALUES (2);
INSERT INTO CURIER (id_angajat)
VALUES (3);
INSERT INTO CURIER (id_angajat)
VALUES (4);
INSERT INTO CURIER (id_angajat)
VALUES (5);

INSERT INTO AGENT_POINT (id_angajat)
VALUES (6);
INSERT INTO AGENT_POINT (id_angajat)
VALUES (7);
INSERT INTO AGENT_POINT (id_angajat)
VALUES (8);
        
INSERT INTO ANGAJAT_DEPOZIT (id_angajat)
VALUES (9);
INSERT INTO ANGAJAT_DEPOZIT (id_angajat)
VALUES (10);       
        
INSERT INTO DEPOZIT (oras)
VALUES ('Bucuresti');
INSERT INTO DEPOZIT (oras)
VALUES ('Cluj');
INSERT INTO DEPOZIT (oras)
VALUES ('Iasi');
INSERT INTO DEPOZIT (oras)
VALUES ('Timisoara');
INSERT INTO DEPOZIT (oras)
VALUES ('Constanta');        
        
        
INSERT INTO LIVRARE (id_client, id_curier)
VALUES (1, 1);
INSERT INTO LIVRARE (id_client, id_curier)
VALUES (2, 2);
INSERT INTO LIVRARE (id_client, id_curier)
VALUES (3, 1);
INSERT INTO LIVRARE (id_client, id_curier)
VALUES (4, 3);
INSERT INTO LIVRARE (id_client, id_curier)
VALUES (5, 2);        
INSERT INTO LIVRARE (id_client, id_curier)
VALUES (1, 5);
INSERT INTO LIVRARE (id_client, id_curier)
VALUES (2, 4);
INSERT INTO LIVRARE (id_client, id_curier)
VALUES (3, 4);
INSERT INTO LIVRARE (id_client, id_curier)
VALUES (4, 4);
INSERT INTO LIVRARE (id_client, id_curier)
VALUES (5, 3);        
        
INSERT INTO COLET (id_livrare, id_depozit)
VALUES (1, 1);
INSERT INTO COLET (id_livrare, id_depozit)
VALUES (1, 2);
INSERT INTO COLET (id_livrare, id_depozit)
VALUES (2, 3);
INSERT INTO COLET (id_livrare, id_depozit)
VALUES (3, 1);
INSERT INTO COLET (id_livrare, id_depozit)
VALUES (4, 4);
INSERT INTO COLET (id_livrare, id_depozit)
VALUES (5, 5);       
INSERT INTO COLET (id_livrare, id_depozit)
VALUES (6, 2);
INSERT INTO COLET (id_livrare, id_depozit)
VALUES (7, 3);
INSERT INTO COLET (id_livrare, id_depozit)
VALUES (8, 4);
INSERT INTO COLET (id_livrare, id_depozit)
VALUES (9, 5);
INSERT INTO COLET (id_livrare, id_depozit)
VALUES (10, 1);
      
        
INSERT INTO RECENZIE (id_client, id_livrare)
VALUES (1, 1);
INSERT INTO RECENZIE (id_client, id_livrare)
VALUES (2, 2);
INSERT INTO RECENZIE (id_client, id_livrare)
VALUES (3, 3);
INSERT INTO RECENZIE (id_client, id_livrare)
VALUES (4, 4);
INSERT INTO RECENZIE (id_client, id_livrare)
VALUES (5, 5);       
INSERT INTO RECENZIE (id_client, id_livrare)
VALUES (1, 6);
INSERT INTO RECENZIE (id_client, id_livrare)
VALUES (2, 7);
INSERT INTO RECENZIE (id_client, id_livrare)
VALUES (3, 8);
INSERT INTO RECENZIE (id_client, id_livrare)
VALUES (4, 9);
INSERT INTO RECENZIE (id_client, id_livrare)
VALUES (5, 10);      
        

        
        
        