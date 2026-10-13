CREATE TABLE equipe(
	id			SMALLINT,
	nome		VARCHAR(30) NOT NULL,
	CONSTRAINT equipe_pk PRIMARY KEY(id)
);

CREATE TABLE jogador(
	id			INT,
	nome		VARCHAR(50) NOT NULL,
	cpf			VARCHAR(14),
	data_nasc	DATE,
	salario		NUMERIC(8, 2),
	id_equipe	SMALLINT,
	CONSTRAINT jogador_pk PRIMARY KEY(id),
	CONSTRAINT jogador_cpf_uk UNIQUE(cpf),
	CONSTRAINT jogador_salario_ck CHECK(salario > 0),
	CONSTRAINT jogador_equipe_fk FOREIGN KEY(id_equipe)
		REFERENCES equipe(id)
);

INSERT INTO equipe VALUES(10, 'São Paulo');
INSERT INTO equipe VALUES(20, 'Palmeiras');
INSERT INTO equipe VALUES(30, 'Corinthians');
INSERT INTO equipe VALUES(40, 'Santos');

INSERT INTO jogador VALUES(1, 'Gabriel', '123.456.789-00', '2000-10-20', 10000, 10);
INSERT INTO jogador VALUES(2, 'Carlos', '321.456.789-00', '1998-10-24', 25000, 20);
INSERT INTO jogador VALUES(3, 'Antônio', '123.491.789-00', '2000-08-28', 30000, 30);
INSERT INTO jogador VALUES(4, 'João', '445.456.789-00', '2004-01-08', 14000, 10);
INSERT INTO jogador VALUES(5, 'Jorge', '123.456.858-00', '2001-05-14', 100000, null);
INSERT INTO jogador VALUES(6, 'Guilherme', '123.863.789-00', '2003-04-30', 15000, null);

ALTER TABLE jogador ADD contato VARCHAR(30);

SELECT * FROM equipe;
SELECT * FROM jogador;

UPDATE jogador SET id_equipe = 20 WHERE id = 6;

UPDATE jogador SET contato = '(16) 99111-0000' WHERE id = 5;
UPDATE jogador SET contato = '(16) 99123-4444' WHERE id = 1;

UPDATE equipe SET nome = 'Bragantino' WHERE id = 40;

UPDATE jogador SET data_nasc = '2000-01-01' WHERE salario > 3000 AND id_equipe in (10, 20, 30);

DELETE FROM equipe WHERE id = 40;

DELETE FROM equipe WHERE id = 20;

ALTER TABLE jogador DROP CONSTRAINT jogador_equipe_fk;
ALTER TABLE jogador ADD CONSTRAINT jogador_equipe_fk FOREIGN KEY(id_equipe)
	REFERENCES equipe(id) ON DELETE CASCADE;

DELETE FROM equipe WHERE id = 20;

DELETE FROM jogador WHERE id = 1;

ALTER TABLE jogador DROP CONSTRAINT jogador_equipe_fk;
ALTER TABLE jogador ADD CONSTRAINT jogador_equipe_fk FOREIGN KEY(id_equipe)
	REFERENCES equipe(id);

DROP TABLE equipe;

DROP TABLE jogador;

DROP TABLE equipe;