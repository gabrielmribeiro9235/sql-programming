CREATE TABLE livro(
	id				INTEGER GENERATED ALWAYS AS IDENTITY,
	titulo			VARCHAR(60) NOT NULL,
	ano				INTEGER,
	preco			NUMERIC(8, 2),
	quantidade		INTEGER DEFAULT 1,
	preco_promo		NUMERIC(8, 2) GENERATED ALWAYS AS (preco * 0.9) STORED,
	valor_acervo	NUMERIC(10, 2) GENERATED ALWAYS AS (preco * quantidade) VIRTUAL
);

ALTER TABLE livro ADD CONSTRAINT livro_pk PRIMARY KEY(id);

ALTER TABLE livro ADD CONSTRAINT livro_preco_ck CHECK(preco >= 0);