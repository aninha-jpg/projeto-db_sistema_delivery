-- Nome: Ana Luiza de Lima da Rocha.
-- Curso: Análise e Desenvolvimento de Sistemas.


-- Crio a estrutura.

DROP SCHEMA IF EXISTS PUCS8;
CREATE SCHEMA IF NOT EXISTS PUCS8;

-- tabelas e drops, seguindo a lógica do modelo disponibilizado no AVA.

DROP TABLE IF EXISTS PUCS8.REGIAO; 
CREATE TABLE PUCS8.REGIAO(
codRegiao BIGINT PRIMARY KEY,
nomeRegiao VARCHAR(100),
descricaoRegiao TEXT
);

DROP TABLE IF EXISTS PUCS8.VINICOLA;
CREATE TABLE PUCS8.VINICOLA(
codVinicola BIGINT PRIMARY KEY,
nomeVinicola VARCHAR(100),
descricaoVinicola TEXT,
foneVinicola VARCHAR(15),
emailVinicola VARCHAR(15),
codRegiao BIGINT,
FOREIGN KEY (codRegiao) REFERENCES PUCS8.REGIAO(codRegiao)
);

DROP TABLE IF EXISTS PUCS8.VINHO; 
CREATE TABLE PUCS8.VINHO(
codVinho BIGINT PRIMARY KEY,
nomeVinho VARCHAR(50),
tipoVinho VARCHAR(30),
anoVinho INT,
descricaoVinho TEXT,
codVinicola BIGINT,
FOREIGN KEY (codVinicola) REFERENCES PUCS8.VINICOLA(codVinicola)
);


-- inserts
INSERT INTO PUCS8.REGIAO (codRegiao, nomeRegiao, descricaoRegiao)
VALUES
(1, 'MG', 'centro oeste'),
(2, 'SP', 'sudeste'),
(3, 'RJ', 'sudeste'),
(4, 'PR', 'sul'),
(5, 'RS', 'sul');

INSERT INTO PUCS8.VINICOLA (codVinicola, nomeVinicola, descricaoVinicola, foneVinicola, emailVinicola, codRegiao)
VALUES
(1, 'Vinicola de MG', 'especialidade em Merlot', '+5543991878685', 'vinmg@email.com', 1),
(2, 'Vinicola de SP', 'especialidade em Malbec', '+5543991345123', 'vinsp@email.com', 2),
(3, 'Vinicola de RJ', 'especialidade em Rioja', '+5543991219087', 'vinrj@email.com', 3),
(4, 'Vinicola de PR', 'especialidade em Bordeaux', '+5543991367898', 'vinpr@email.com', 4),
(5, 'Vinicola de RS', 'especialidade em Toscana', '+5543991436554', 'vinrs@email.com', 5);

INSERT INTO PUCS8.VINHO (codVinho, nomeVinho, tipoVinho, anoVinho, descricaoVinho, codVinicola)
VALUES
(1, 'Merlot', 'tinto', 1894,  'macios e acidez média', 1),
(2, 'Malbec', 'tinto', 1923, 'aromas de frutas vermelhas e negras', 2),
(3, 'Rioja', 'tinto', 1988, 'bastante marcado pelo carvalho', 3),
(4, 'Bordeaux', 'tinto', 1991, 'aromas de groselha preta, ameixas e um toque terroso', 4),
(5, 'Toscana', 'tinto', 2005, 'com um sabor equilibrado e acidez marcante', 5);



-- criando o user:

DROP USER IF EXISTS 'Somellier'@'localhost';
CREATE USER 'Somellier'@'localhost' IDENTIFIED BY 'senha12345';

GRANT SELECT ON PUCS8.VINHO TO 'Somellier'@'localhost';
GRANT SELECT (codVinicola, nomeVinicola) ON PUCS8.VINICOLA TO 'Somellier'@'localhost';

ALTER USER 'Somellier'@'localhost' WITH MAX_QUERIES_PER_HOUR 40;
FLUSH PRIVILEGES;

-- consultando, utilizando apelidos 

SELECT 
    v.nomeVinho, 
    v.anoVinho, 
    vin.nomeVinicola, 
    r.nomeRegiao
FROM 
    PUCS8.VINHO v
JOIN 
    PUCS8.VINICOLA vin ON v.codVinicola = vin.codVinicola
JOIN 
    PUCS8.REGIAO r ON vin.codRegiao = r.codRegiao;
    
    -- fim.