# ------------------  LISTA DE EXRCICIOS 1 -----------------
#Criar banco de dados
CREATE DATABASE exercicio;

#Selecionar o banco de dados: exercicio
USE exercicio;

#Comando para poder habilitar a exclusao/atualizacao de dados
SET SQL_SAFE_UPDATES=0; 

#Criar tabela desconto
CREATE TABLE desconto (
	ID_NF INT(10),
    ID_ITEM INT(10),
    COD_PRO	INT(10),
    VALOR_UNIT FLOAT(10),
    QUANTIDADE INT(10),
    DESCONTO INT(10) DEFAULT NULL
);

#Inserindo valores na tabela desconto
INSERT INTO desconto VALUES 
(1,4,4,10.00,1, NULL),
(1,5,5,30.00,1, NULL),
(2, 1, 3, 15.00, 4, NULL),
(2, 2, 4, 10.00, 5, NULL),
(2, 3, 5, 30.00, 8, NULL),
(3, 1, 1, 25.00, 5, NULL),
(3, 2, 4, 10.00, 4, NULL),
(3, 3, 5, 30.00, 5, NULL),
(3, 4, 2, 13.50, 7, NULL),
(4, 1, 5, 30.00, 10, 15),
(4, 2, 4, 10.00, 12, 5),
(4, 3, 1, 25.00, 13, 5),
(4, 4, 2, 13.50, 15, 5),
(5, 1, 3, 15.00, 3, NULL),
(5, 2, 5, 30.00, 6, NULL),
(6, 1, 1, 25.00, 22, 15),
(6, 2, 3, 15.00, 25, 20),
(7, 1, 1, 25.00, 10, 3),
(7, 2, 2, 13.50, 10, 4),
(7, 3, 3, 15.00, 10, 4),
(7, 4, 5, 30.00, 10, 1)
;

# ---------------------------- Respondendo a lista de exercicios 1 ----------------------------
/* a)Pesquise os itens que foram vendidos sem desconto. 
As colunas presentes no resultado da consulta são: ID_NF, ID_ITEM, COD_PROD E VALOR_UNIT. */
SELECT 
ID_NF, ID_ITEM, COD_PRO, VALOR_UNIT
FROM desconto
WHERE DESCONTO > 0;

/*b)Pesquise os itens que foram vendidos com desconto. 
As colunas presentes no resultado da consulta são: ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT E O VALOR VENDIDO.
 OBS: O valor vendido é igual ao VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)).*/
SELECT
ID_NF, ID_ITEM, COD_PRO, VALOR_UNIT, 
#Caso o valor de desconso seja nulo, o resultado será o VALOR_UNIT
CASE 
	WHEN (VALOR_UNIT - (VALOR_UNIT * (DESCONTO/100))) IS NULL THEN VALOR_UNIT
	ELSE (VALOR_UNIT - (VALOR_UNIT * (DESCONTO/100))) END AS VALOR_VENDIDO
FROM desconto;

/*c)Altere o valor do desconto (para zero) de todos os registros onde este campo é nulo.*/
UPDATE desconto
SET DESCONTO = 0
WHERE DESCONTO is NULL;

/*d) Pesquise os itens que foram vendidos. As colunas presentes no resultado da consulta são: 
ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, VALOR_TOTAL, DESCONTO, VALOR_VENDIDO. 
OBS: O VALOR_TOTAL é obtido pela fórmula: QUANTIDADE * VALOR_UNIT. 
O VALOR_VENDIDO é igual a VALOR_UNIT -(VALOR_UNIT*(DESCONTO/100)).*/
SELECT
ID_NF, ID_ITEM, COD_PRO, VALOR_UNIT, 
(QUANTIDADE * VALOR_UNIT ) AS VALOR_TOTAL, 
(VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100))) AS VALOR_VENDIDO
FROM desconto;

/*e)Pesquise o valor total das NF e ordene o resultado do maior valor para o menor. As
colunas presentes no resultado da consulta são: ID_NF, VALOR_TOTAL. 
OBS: O VALOR_TOTAL é obtido pela fórmula: ∑ QUANTIDADE * VALOR_UNIT. Agrupe o
resultado da consulta por ID_NF.*/
SELECT
ID_NF, SUM(QUANTIDADE * VALOR_UNIT) AS VALOR_TOTAL
FROM desconto
GROUP BY ID_NF
ORDER BY 2 DESC;

#f) Pesquise o valor vendido das NF e ordene o resultado do maior valor para o menor. Agrupe o resultado da consulta por ID_NF.
SELECT
ID_NF,
SUM(VALOR_UNIT - (VALOR_UNIT * (DESCONTO/100))) AS VALOR_VENDIDO
FROM desconto
GROUP BY ID_NF
ORDER BY 2 DESC;

#g) Consulte o produto que mais vendeu no geral. Agrupe o resultado da consulta por COD_PROD.
SELECT
COD_PRO, SUM(QUANTIDADE)
FROM desconto
GROUP BY COD_PRO;

/*h) Consulte as NF que foram vendidas mais de 10 unidades de pelo menos um produto. 
Agrupe o resultado da consulta por ID_NF, COD_PROD.*/
SELECT
ID_NF, COD_PRO, SUM(QUANTIDADE) AS SOMA_QUANTIDADE
FROM desconto
GROUP BY ID_NF, COD_PRO
HAVING SUM(QUANTIDADE) > 10;

#i) Pesquise o valor total das NF, onde esse valor seja maior que 500, e ordene o resultado do maior valor para o menor.
SELECT
ID_NF, SUM(QUANTIDADE * VALOR_UNIT) AS VALOR_TOTAL
FROM desconto
GROUP BY ID_NF
ORDER BY 2 DESC;

#j) Qual o valor médio dos descontos dados por produto.
SELECT
COD_PRO, AVG(VALOR_UNIT) AS MEDIA
FROM desconto
GROUP BY COD_PRO;

#k) Qual o menor, maior e o valor médio dos descontos dados por produto.
SELECT
COD_PRO,
MIN(VALOR_UNIT) AS MENOR,
MAX(VALOR_UNIT) AS MAIOR,
AVG(VALOR_UNIT) AS MEDIA
FROM desconto
GROUP BY COD_PRO;


#l) Quais as NF que possuem mais de 3 itens vendidos.
SELECT
ID_NF, COUNT(ID_ITEM) AS QTD_ITENS
FROM desconto
GROUP BY ID_NF
HAVING COUNT(ID_ITEM) > 3;


# ------------------  LISTA DE EXRCICIOS 2 -----------------

#CRIAR BASE DE DADOS Universidade
#Criando banco
CREATE DATABASE Universidade;
USE Universidade; #Usar o banco Universidade

#Criar tabela Alunos
CREATE TABLE Alunos(
	MAT INT(10),
	nome CHAR(50),
    endereco VARCHAR(50),
    cidade CHAR(50)
);

#Criar tabela Disciplinas
CREATE TABLE Disciplinas(
	COD_DISC CHAR(5),
    nome_disc VARCHAR(60),
    carga_hor INT
    
);

#Criar tabela professores
CREATE TABLE Professores(
	COD_PROF CHAR(10),
    nome VARCHAR(50),
    endereco VARCHAR (60),
    cidade VARCHAR (50)
);

#Criar tabela Turma
CREATE TABLE Turma(
	COD_DISC CHAR(5),
    COD_TURMA CHAR(5),
    COD_PROF CHAR(10),
    ANO DATE,
    horario CHAR(10)
);

#Criar tabela Historico
CREATE TABLE Historico(
	MAT INT(10),
	COD_DISC CHAR(5),
    COD_TURMA CHAR(5),
    COD_PROF CHAR(10),
    ANO DATE,
    frequencia VARCHAR(20),
    nota INT
);

#OBS:
#Como até o momento não tinha estudado CONSTRAINT, não defini quem seria chave primária ou estrangeira
#Os comandos abaixo irão definir essas chaves com base no exercício proposto

#Definindo MAT como chave primaria da tabela Alunos
ALTER TABLE Alunos
ADD PRIMARY KEY (MAT);

#Definindo COD_DISC como chave primaria da tabela Disciplinas
ALTER TABLE Disciplinas
ADD PRIMARY KEY (COD_DISC);

#Definindo COD_PROF como chave primaria da tabela Professores
ALTER TABLE Professores
ADD PRIMARY KEY (COD_PROF);

#Definindo COD_TURMA como chave primaria da tabela Turma
ALTER TABLE Turma
ADD PRIMARY KEY (COD_TURMA);

#Definindo COD_DISC como chave estrangeira da tabela Disciplina
ALTER TABLE Turma
ADD FOREIGN KEY (COD_DISC) REFERENCES Disciplinas(COD_DISC);

#Definindo COD_PROF como chave estrangeira da tabela Professores
ALTER TABLE Turma
ADD FOREIGN KEY (COD_PROF) REFERENCES Professores(COD_PROF);

#Definindo MAT como chave estrangeira da tabela Alunos
ALTER TABLE Historico
ADD FOREIGN KEY (MAT) REFERENCES Alunos(MAT);

#Definindo COD_DISC, COD_TURMA, COD_PROF e ANO como chave estrangeira da tabela Turma
ALTER TABLE Historico
ADD FOREIGN KEY (COD_DISC) REFERENCES Turma(COD_DISC);

ALTER TABLE Historico
ADD FOREIGN KEY (COD_TURMA) REFERENCES Turma(COD_TURMA);

ALTER TABLE Historico
ADD FOREIGN KEY (COD_PROF) REFERENCES Turma(COD_PROF);

ALTER TABLE Historico
ADD FOREIGN KEY (ANO) REFERENCES Turma(ANO);

#-------------- INSERINDO VALORES NAS TABELAS -----------------

#Tabela Alunos
INSERT INTO Alunos VALUES
(2015010101, 'JOSE DE ALENCAR',' RUA DAS ALMAS', 'NATAL'),
(2015010102, 'JOÃO JOSÉ',' AVENIDA RUY CARNEIRO', 'JOÃO PESSOA'),
(2015010103, 'MARIA JOAQUINA', 'RUA CARROSSEL', 'RECIFE'),
(2015010104, 'MARIA DAS DORES', 'RUA DAS LADEIRAS', 'FORTALEZA'),
(2015010105, 'JOSUÉ CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL'),
(2015010106, 'JOSUÉLISSON CLAUDINO DOS SANTOS', 'CENTRO', 'NATAL');

#Tabela Disciplinas
INSERT INTO Disciplinas VALUES
('BD', 'BANCO DE DADOS', 100),
('POO', 'PROGRAMAÇÃO COM ACESSO A BANCO DE DADOS', 100),
('WEB', 'AUTORIA WEB', 50),
('ENG', 'ENGENHARIA DE SOFTWARE', 80);

#Tabela professores
INSERT INTO Professores VALUES
(212131, 'NICKERSON FERREIRA', 'RUA MANAÍRA', 'JOÃO PESSOA'),
(122135, 'ADORILSON BEZERRA', 'AVENIDA SALGADO FILHO', 'NATAL'),
(192011, 'DIEGO OLIVEIRA', 'AVENIDA ROBERTO FREIRE', 'NATAL');

#Alterar tipo de dado da coluna ANO
ALTER TABLE Turma
MODIFY COLUMN ANO INT;

ALTER TABLE Historico
MODIFY COLUMN ANO INT;

ALTER TABLE Historico
MODIFY COLUMN nota DECIMAL(4,2);

#Tabela Turma. OBS: Como COD_TURMA é PK, não poderia ter valores repetidos
INSERT INTO Turma VALUES
('BD', 1, '212131', 2015, '11H-12H'),
('BD', 2, '212131', 2015, '13H-14H'),
('POO', 3, '192011', 2015, '08H-09H'),
('WEB', 4, '192011', 2015, '07H-08H'),
('ENG', 5, '122135', 2015, '10H-11H');


    
INSERT INTO historico  VALUES
	(2015010101, 'ENG', 3, 122135, 2015, 8, 3),
    (2015010102, 'POO', 1, 192011, 2015, 7, 9),
    (2015010103, 'WEB', 4, 212131, 2015, 5, 7),
    (2015010104, 'BD', 2, 212131, 2015, 4, 3),
    (2015010105, 'WEB', 1, 192011, 2015, 8,9),
    (2015010106, 'ENG',4, 122135, 2015, 5, 5),
    
    (2015010101, 'POO', 4, 122135, 2015, 2, 1),
    (2015010102, 'WEB', 2, 192011, 2015, 5, 6),
    (2015010103, 'BD', 1, 212131, 2015, 7, 7),
    (2015010104, 'ENG', 2, 212131, 2015, 6, 2),
    (2015010105, 'WEB', 1, 122135, 2015, 3,8),
    (2015010106, 'ENG',4, 122135, 2015, 8, 8),
    
    (2015010101, 'WEB', 2, 122135, 2015, 8, 0),
    (2015010102, 'ENG', 1, 192011, 2015, 7, 0),
    (2015010103, 'WEB', 4, 212131, 2015, 5, 9),
    (2015010104, 'BD', 1, 212131, 2015, 4, 0),
    (2015010105, 'POO', 3, 192011, 2015, 8,7),
    (2015010106, 'ENG',2, 122135, 2015, 5, 1);


# ---------------------------- Respondendo a lista de exercicios 2 ----------------------------
#a) Encontre a MAT dos alunos com nota em BD em 2015 menor que 5 (obs: BD = código da disciplinas)
SELECT
DISTINCT MAT
FROM historico
WHERE 
COD_DISC = 'BD' AND
ANO = 2015 AND
NOTA < 5;

#b) Encontre a MAT e calcule a média das notas dos alunos na disciplina de POO em 2015.
SELECT
MAT, AVG(NOTA) AS 'MEDIA'
FROM historico
WHERE 
COD_DISC = 'POO'AND
ANO = 2015
GROUP BY MAT;

/* c) Encontre a MAT e calcule a média das notas dos alunos na disciplina de POO
em 2015 e que esta média seja superior a 6.*/
SELECT
MAT, AVG(NOTA) AS MEDIA
FROM historico
WHERE 
COD_DISC = 'POO'AND
ANO = 2015
GROUP BY MAT
HAVING MEDIA > 6;

#d) Encontre quantos alunos não são de Natal.
SELECT
COUNT(*) AS QUANTIDADE
FROM Alunos
WHERE cidade <> 'NATAL';

