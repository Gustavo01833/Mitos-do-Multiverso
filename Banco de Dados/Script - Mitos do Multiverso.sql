CREATE DATABASE IF NOT exists mitosMultiverso;
USE mitosMultiverso;

-- drop database mitosMultiverso;

CREATE TABLE IF NOT EXISTS usuario(
	idUsuario int primary key auto_increment,
    senha varchar(45) not null,
    email varchar(255) not null,
    dataCriacao timestamp not null default current_timestamp  
);

CREATE TABLE IF NOT EXISTS tematica(
	idTematica int primary key auto_increment,
    nome varchar(45)
);

CREATE TABLE IF NOT EXISTS sistemas(
	idSistemas int primary key auto_increment,
    nome varchar(45) not null,
    lancamento date not null,
    dadoPrincipal varchar(5) not null,
    historia text not null,
    contexto text not null,
    mecanicas text not null,
    fkTematica int not null,
    
    constraint SistemasTematica FOREIGN KEY (fkTematica) references tematica(idTematica)
);

CREATE TABLE IF NOT EXISTS  favorita(
	pkUsuario int,
    pkSistemas int,
    favoritado tinyint(1) default 0,
    dataFavorito timestamp null,
    constraint UsuarioFavorita FOREIGN KEY (pkUsuario) references usuario(idUsuario),
    constraint SistemasFavorita FOREIGN KEY (pkSistemas) references sistemas(idSistemas),
    CONSTRAINT pkComposta PRIMARY KEY (pkUsuario, pkSistemas)
);


INSERT INTO usuario (senha, email) VALUES
	('123456', 'bilt@gmail.com'),
	('123456', 'alf@gmail.com'),
    ('123456', 'colt@gmail.com');

INSERT INTO usuario (senha, email, dataCriacao) VALUES
	( '123456', 'kris@gmail.com', '2025-04-29'),
	( '123456', 'roberto@gmail.com', '2025-04-03'),
    ( '123456', 'nono@gmail.com', '2025-04-03'), 
	( '123456', 'carcar@gmail.com', '2024-04-29'),
	( '123456', 'minhoca@gmail.com', '2025-04-03'),
    ('123456', 'clideiro@gmail.com', '2025-04-03'),
	( '123456', 'math@gmail.com', '2025-04-03');


	SELECT * FROM usuario;

INSERT INTO tematica(nome) VALUES
	('Fantasia Medieval'),
    ('Horror Cósmico'),
    ('Fantasia Sombria'),
	('Horror moderno');

INSERT INTO sistemas (nome, lancamento, dadoPrincipal, historia, contexto, mecanicas, fkTematica) VALUES
	('D&D5E'
    , '2014-08-19'
    , 'd20'
    , " Teve sua primeira versão criada por Garry Gygax e Dave Arneson em 1974
    , onde estando sobre domínio da Wizards of the Coast, sua 5ª Edição foi públicada, trazendo regras mais
    acessíveis para jogadores novos e dando mais importância para a narrativa invés do combate. Se tornando atualmente 
    o sistema de RPG mais famoso no mundo." 
    , 'Se passa em um universo de fantasia medieval, habitado por criaturas fantásticas 
    como dragões, elfos, draconatos, ursos corujas e diversos outros tipos de criaturas fantásticas e mitológicas. 
    A história desse universo ocorre em diversos cenários, dimensões e mundos, cada um com sua própria mitologia, problemas a serem
    combatidos e/ou superados, seja em um lugar mais sombrio dominado por um vampiro e uma maldição, onde nem mesmo a luz do sol pode tocar, como em Ravenloft ou
    até mesmo em um mundo onde uma aventura heróica o aguarda, com conflitos entre reinos e deuses no cenário de Forgotten Realms.'
    , 'Sistemas de níveis, atributos e modificadores, testes de resistência, classes, raças, magias, combate tático com iniciativa e grid.'
    , 1
    ),
    ('Tormenta20'
    , '2020-12-10'
    , 'd20'
    ,'Tendo sua primeira versão criada no Brasil em 1999, públicado na Revista Dragão, sendo inspirado em D&D 3.5, como um dos cenários de campanha disponíveis para jogar,
    porém em 2020 foi totalmente redesenhado como um novo sistema, unificando o cenário e adaptando regras ao que chamaram de "estilo brasileiro de jogar RPG", 
    sendo algo mais ágil e cinematográfico. Atualmente é um dos sistemas mais populares no Brasil.'
    , 'Se passa no mundo de Arton, um mundo que sofre com a presença da Tormenta, uma tempestade vermelha e viva que corrompe tudo que toca, representando o puro caos.
     Além disso, é habitado por diversas criaturas inpiradas na cultura pop, mangás e mitologias, trazendo conteúdo para a construção de uma história de aventuras épicas
     entre os reinos e regiões controlados por diferentes raças e divindidades, seja pelo respeito entre os habitantes e frequentadores, ou pela força e magia dos tiranos.'
    ,'Sistema próprio baseado em d20, com classes, poderes, talentos, combate tático e magia com mana.'
    , 1
    ),
    
    ('Call of Cthulhu 7º ed.', '2014-10-01', 'd100', 'Teve sua primeira versão públicada em 1981, e com os anos tendo atualizações e mudanças 
    até que em 2014 teve sua 7ª edição publicada. Tem como sua origem as histórias do escritor H.P Lovecraft, o mais famoso escritor de histórias de Horror Cósmico,
    e após algumas décadas de seu falecimento, surge o RPG Call of Cthulhu, onde os adoradores de histórias de horror e mistério podem se aprofundar em uma experiência 
    mais imersiva dos terrores de entidades desconhecidas.'
    ,'A história se passa num mundo semelhante a realidade da época de 1920, porém habitado por entidades antigas e tão poderosas quanto deuses, que um dia habitaram a Terra 
    e pretendem recuperar seu império, através de seitas e cultos que buscam os despertar de seu sono milenar. Dessa forma, cabe aos jogadores, pessoas comuns, impedirem que 
    a influência terrível dessas entidades as façam despertar novamente, enquanto tentam não enlouquecer ou morrer para os horrores que habitam esse mundo.'
    , 'Sistema BRP (Basic Role-Playing), sistema de sanidade, combate letal, rolagens d% (d100).'
    , 2),
    
	('Vampiro a Máscara 5ª ed.', '2018-08-01', 'd10'
    ,'Teve sua primeira versão lançada em 1991, se tornando revolucionário na época ao focar na narrativa e no horror invés do combate e aventuras épicas.
    Se tornou um ícone da cultura gótica e urbana por volta dos anos 90 por conta de sua temática sombria e sua participação em World of Darkness, junto de 
    criaturas assustadoras como vampiros e lobisomens'
    , 'A história se passa em um universo chamado de World of Darkness, onde criaturas como vampiros e lobisomens existem junto de humanos. Porém, 
    devido aos humanos serem muito mais númerosos, essas criaturas se mantém escondidas por entre as civilizações, tentando manter a máscara da sua existência para os mortais 
    enquanto intrigas e conflitos políticos ocorrem entre as diferentes facções em que são divididos. Os jogadores se veem como parte desse conflito, sendo vampiros amaldiçoados 
    sofrendo com a sede de sangue, enquanto lutam para manter sua própria humanidade.'
    , 'Sistema narrativo, uso de Disciplinas (poderes), Fome, Humanidade e moralidade e intrigas políticas.'
    , 3),
    ('D&D', '1974-01-01', 'd20',
    'Criado em 1974 por Gary Gygax e Davve Arneson como uma derivação do jogo de guerra medieval Chainmail, Dungeon and Dragons se tornou o primeiro RPG 
    onde a ideia principal era a exploração de masmorras e o combate com criaturas fantásticas em busca de tesouros e itens mágicos'
    ,'A história se passa geralmente em masmorras, criadas pelo narrador com o objetivo de criar um desafio para os jogadores, não existia uma história fixa inicialmente,
	onde o primeiro cenário Greyhalk surgiu apenas alguns anos depois. Tinha a intenção de crir uma atmosfera de fantasia medieval tradicional, incentivando a liberdade criativa.
     Para isso, os jogadores podiam escolher entre algumas raças fantasiosas e classes como guerreiros e magos para criar seus personagens, cada um com suas qualidades e defeitos, 
     para que em grupo pudessem enfrentar os desafios letais que podiam encontrar.'
     , 'Classes limitadas, magias por dia, combate com tabelas, exploração letal'
     , 1),
    ('Ordem Paranormal', '2022-09-28', 'd20'
    , 'Teve como origem uma série de RPG transmitida ao vivo na Twitch e no Youtube, pelo criador de conteúdo Cellbit, onde inicialmente eram usadas regras caseiras e adaptadas 
    para um foco no suspense e horror investigativo. Porém, devido ao sucesso que a série estava tendo, as regras foram evoluindo e se consolidando até que um ano depois o sistema 
    teve sua primeira versão oficialmente lançada.'
    ,'A história se passa no Brasil moderno em um mundo semelhante a realidade, porém existe algo chamado de O Outro Lado, onde entidades paranormais perigosas habitam e buscam ir para o mundo real, 
    através do medo que as pessoas sentem que criam rupturas na divisão entre as realidades, chamada de Membrana, por onde as criaturas atravessam para realidade. Dessa forma, surgem cultos e seitas que 
    buscam o conhecimento paranormal com diversos objetivos, e para combater eles, existe um grupo chamado Ordo Realitas, uma organização com pessoas que investigam e enfrentam o paranormal em busca de manter
     a realidade intacta desse mal.'
     , 'Sistema de D20, atributos, teste habilidades, uso de rituais, classes, níveis, sanidade, combate tático.'
     ,4);
    

    SELECT * FROM sistemas;
    


INSERT INTO favorita(pkUsuario, pkSistemas, favoritado) VALUES
	(1,1, 0),
	(1,2, 0),
    (1,3, 1),
	(1,4, 0),
    (1,5, 1),
    (1,6, 0),
    
    (2,1, 1),
	(2,2, 1),
	(2,3, 1),
    (2,4, 1),
	(2,5, 1),
	(2,6, 1),


	(3,1, 1),
	(3,2, 0),
	(3,3, 1),
	(3,4, 1),
	(3,5, 0),
	(3,6, 1);
    
select * from favorita;



BEGIN; -- Listagem de Sistemas


show tables;
CREATE VIEW vw_usuarioFavoritaSistema  as
		SELECT u.idUsuario,
			   sis.nome,
			   fav.favoritado as Favoritado
		from sistemas sis JOIN favorita fav
		ON sis.idSistemas = fav.pkSistemas
		JOIN usuario u 
		ON u.idUsuario = fav.pkUsuario;


select * from vw_usuarioFavoritaSistema;

CREATE VIEW vw_sistemas as
	SELECT * FROM sistemas;

SELECT * FROM vw_sistemas;


-- SET SQL_MODE= '';

SELECT
	sis.idSistemas,
  CASE
    WHEN top4.nome IS NOT NULL THEN sis.nome
    ELSE 'Outros'
  END AS sistema,
  ROUND(COUNT(fav.favoritado) * 100.0 / (SELECT COUNT(fav.pkSistemas) FROM favorita fav where fav.favoritado = 1), 2) AS porcentagem_uso
FROM sistemas sis
JOIN favorita fav ON sis.idSistemas = fav.pkSistemas
LEFT JOIN (
  SELECT sis2.nome
  FROM sistemas sis2
  JOIN favorita fav2 ON sis2.idSistemas = fav2.pkSistemas
  where fav2.favoritado = 1
  GROUP BY fav2.pkSistemas
  ORDER BY COUNT(fav2.pkSistemas) DESC
  LIMIT 4
) AS top4 ON sis.nome = top4.nome 
JOIN usuario u
ON u.idUsuario = fav.pkUsuario
GROUP BY sistema
ORDER BY 
porcentagem_uso, sistema DESC;

CREATE VIEW vw_porcentagemFavoritos as
		SELECT
		  CASE
			WHEN top4.nome IS NOT NULL THEN sis.nome
			ELSE 'Outros'
		  END AS sistema,
		  ROUND(COUNT(fav.pkSistemas) * 100.0 / (
			SELECT COUNT(*) 
			FROM favorita 
			WHERE favoritado = 1
		  ), 2) AS porcentagem_uso
		FROM sistemas sis
		JOIN favorita fav ON sis.idSistemas = fav.pkSistemas
		LEFT JOIN (
		  SELECT sis2.nome
		  FROM sistemas sis2
		  JOIN favorita fav2 ON sis2.idSistemas = fav2.pkSistemas
		  WHERE fav2.favoritado = 1
		  GROUP BY sis2.nome
		  ORDER BY COUNT(sis2.idSistemas) DESC
		  LIMIT 4
		) AS top4 ON sis.nome = top4.nome
		WHERE fav.favoritado = 1
		GROUP BY sistema
		ORDER BY porcentagem_uso desc, sistema;

select * from vw_porcentagemFavoritos;

-- QUANTIDADE DE USUÁRIOS CADASTRADOS ENTRE O ÚLTIMO MÊS E O ATUAL
	SELECT count(u.idUsuario) as mesAtual, 
		   count(u.idUsuario) as mes1 
    FROM usuario u
    WHERE 
		CASE 
			WHEN mesAtual THEN dataCriacao between date_format(current_date() month, '%Y-%m-01') and last_day(current_date),
			WHEN mes1 THEN dataCriacao between date_format(current_date() - interval 1 month, '%Y-%m-01') and last_day(current_date)
		END;


create view vw_qtdCadastros6Mes as
		SELECT
		  CASE DATE_FORMAT(dataCriacao, '%m') -- Pega o mês da data para o case
			WHEN '01' THEN 'Janeiro'
			WHEN '02' THEN 'Fevereiro'
			WHEN '03' THEN 'Março'
			WHEN '04' THEN 'Abril'
			WHEN '05' THEN 'Maio'
			WHEN '06' THEN 'Junho'
			WHEN '07' THEN 'Julho'
			WHEN '08' THEN 'Agosto'
			WHEN '09' THEN 'Setembro'
			WHEN '10' THEN 'Outubro'
			WHEN '11' THEN 'Novembro'
			WHEN '12' THEN 'Dezembro'
		  END AS mes,
		  DATE_FORMAT(dataCriacao, '%Y') ano, -- Pega o ano da data
		  ifnull(COUNT(idUsuario), 0) AS cadastros 
		FROM usuario
		WHERE dataCriacao >= DATE_SUB(CURRENT_DATE(), interval 5 month) -- DATE SUB SERVE PARA FAZER SUBTRAÇÃO EM DATAS
		GROUP BY ano, mes
		ORDER BY ano, DATE_FORMAT(dataCriacao, '%m'); -- Ordenado pelo ano e pelo mês

select * from vw_qtdCadastros6Mes;
drop view vw_qtdCadastros6Mes;

select 
	fav.pkSistemas,
	count(fav.pkSistemas),
    count(fav.pkUsuario)
    from favorita fav
    where fav.favoritado = 1;

SELECT sis2.nome,
	count(fav2.pkUsuario)
  FROM sistemas sis2
  JOIN favorita fav2 ON sis2.idSistemas = fav2.pkSistemas
  where fav2.favoritado = 1
  GROUP BY fav2.pkSistemas
  ORDER BY COUNT(fav2.pkSistemas) DESC
  -- LIMIT 4
  ;

/*
CASE
    WHEN sis.nome IN ( -- RETORNA O NOME DOS 4 SISTEMAS MAIS UTILIZADOS COMO 'SISTEMA'
      SELECT sis2.nome
      
      FROM sistemas sis2
      JOIN sala s2 ON sis2.idSistemas = s2.fkSistema
      GROUP BY sis2.nome
      ORDER BY count(s2.fkSistema) DESC
	  
    ) THEN sis.nome
    ELSE 'Outros' -- SE NÃO FOR UM DOS 4 MAIS UTILIZADOS É EXIBIDO EM OUTROS
  END AS sistema, -- O RETORNO É FEITO NA COLUNA 'SISTEMA'

*/


select
  CONCAT(COUNT(par.pkUsuario), '/', s.MaxJogadores) AS MaximoJogadores,
  s.nome,
  s.frequencia,
  sis.nome AS sistema,
  s.visibilidade
FROM sala s
JOIN sistemas sis ON s.fkSistema = sis.idSistemas
LEFT JOIN participacao par ON s.idSala = par.pkSala
GROUP BY s.idSala, s.nome, s.frequencia, sis.nome, s.visibilidade, s.MaxJogadores
HAVING 
count(par.pkUsuario) > 0;



	-- LISTAGEM DE SALAS NO GERAL
SELECT concat((select count(par.pkUsuario) FROM 
             participacao JOIN usuario
			ON u.idUsuario = par.pkUsuario
            JOIN sala s
            ON par.pkSala = s.idSala group by s.idSala) ,'/',s.MaxJogadores) as MaximoJogadores,
		   s.nome,
           s.frequencia,
           sis.nome,
           s.visibilidade
           FROM sala s
           JOIN sistemas sis
           ON s.fkSistema = sis.idSistemas
           JOIN participacao par
           ON s.idSala = par.pkSala
           JOIN usuario u
           ON par.pkUsuario = u.idUsuario
           GROUP BY s.idSala;

	-- LISTAGEM DE SALA PÚBLICA
SELECT concat((select count(par.pkUsuario) FROM 
             participacao JOIN usuario
			ON u.idUsuario = par.pkUsuario
            JOIN sala s
            ON par.pkSala = s.idSala group by s.idSala) ,'/',s.MaxJogadores) as MaximoJogadores,
		   s.nome,
           s.frequencia,
           sis.nome,
           s.visibilidade
           FROM sala s
           JOIN sistemas sis
           ON s.fkSistema = sis.idSistemas
           JOIN participacao par
           ON s.idSala = par.pkSala
           JOIN usuario u
           ON par.pkUsuario = u.idUsuario
           GROUP BY s.idSala
           having
           s.visibilidade = 'Público';
           
	-- LISTAGEM DE SALA PRIVADA 
    
   SELECT concat((select count(par.pkUsuario) FROM 
             participacao JOIN usuario
			ON u.idUsuario = par.pkUsuario
            JOIN sala s
            ON par.pkSala = s.idSala group by s.idSala) ,'/',s.MaxJogadores) as MaximoJogadores,
		   s.nome,
           s.frequencia,
           sis.nome,
           s.visibilidade
           FROM sala s
           JOIN sistemas sis
           ON s.fkSistema = sis.idSistemas
           JOIN participacao par
           ON s.idSala = par.pkSala
           JOIN usuario u
           ON par.pkUsuario = u.idUsuario
           GROUP BY s.idSala
           HAVING 
           s.visibilidade = 'Privado';
           
         
-- LISTAGEM DE SALAS QUE O USUARIO ESPECÍFICO PARTICIPA
    
	SELECT concat(
			 (select count(par.pkUsuario) FROM 
             participacao JOIN usuario
			ON u.idUsuario = par.pkUsuario
            JOIN sala s
            ON par.pkSala = s.idSala group by s.idSala) ,'/',s.MaxJogadores) as MaximoJogadores,
		   s.nome,
           s.frequencia,
           sis.nome,
           s.visibilidade
           FROM sala s
           JOIN sistemas sis
           ON s.fkSistema = sis.idSistemas
           JOIN participacao par
           ON s.idSala = par.pkSala
           JOIN usuario u
           ON par.pkUsuario = u.idUsuario
           WHERE u.idUsuario = 1
           GROUP BY s.idSala;
           

-- LISTAGEM DA QUANTIDADE DE JOGADORES POR SALA
SELECT s.nome as NomeSala,
	   count(par.pkUsuario) quantidadeJogadores
       from 
       sala s JOIN participacao par
       ON par.pkSala = s.idSala 
       group by s.idSala;

END;
        
        
		
               
               
         
BEGIN; -- SELECT DE PERSONAGENS DE UMA SALA ESPECÍFICA
		SELECT s.idSala,
			   s.nome,
               u.nome as Usuario,
			   per.nome as Personagem
               FROM 
               usuario u JOIN participacao p
               ON u.idUsuario = p.pkUsuario
               JOIN sala s
               ON p.pkSala = s.idSala
               JOIN sistemas sis
               ON s.fkSistema = sis.idSistemas
               JOIN personagem per
               ON s.idSala = per.fkSala and per.fkUsuario = u.idUsuario 
               WHERE s.idSala = 1;
               
               
               
-- LISTAGEM DOS PERSONAGENS JÁ CRIADOS DE UMA SALA
			SELECT 
			personagem.nome
			FROM sala JOIN personagem 
			ON sala.idSala = personagem.fkSala 
			WHERE idSala = 1;
END;	

SELECT * from usuario;

BEGIN; -- Selects para a Dashboard

-- QUANTIDADE DE USUÁRIOS CADASTRADOS ENTRE O ÚLTIMO MÊS E O ATUAL
	SELECT count(u.idUsuario) as UsuariosCadastradosNoMes 
    FROM usuario u
    WHERE dataCriacao between date_format(current_date() - interval 1 month, '%Y-%m-01') and last_day(current_date);

-- SELECT DE USUÁRIOS CADASTRADOS ENTRE O ANTEPENULTIMO MÊS E O PENULTIMO
	SELECT count(u.idUsuario) as UsuariosCadastradosNoMes 
    FROM usuario u
    WHERE dataCriacao between date_format(current_date() - interval 2 month, '%Y-%m-01') and last_day(current_date() - interval 1 month);

-- SELECT DA MÉDIA DA QUANTIDADE DE USUÁRIOS CADASTRADOS POR MÊS

SELECT round(AVG(mensal.total_usuarios), 2) AS media_usuarios_por_mes
FROM (
    SELECT 
        YEAR(dataCriacao) AS ano,
        MONTH(dataCriacao) AS mes,
        COUNT(*) AS total_usuarios
    FROM usuario
    WHERE dataCriacao >= DATE_SUB(CURRENT_DATE(), interval 12 month) -- DATE_SUB subtrai datas e horarios
    GROUP BY 
    YEAR(dataCriacao), MONTH(dataCriacao)
) AS mensal;


-- SELECT DA QUANTIDADE DE USUÁRIOS ÚNICOS QUE SÃO DONOS DE UMA SALA
	SELECT count(distinct u.idUsuario) as 'Quantidade de usuários que criaram uma sala'
    FROM usuario u JOIN sala s
    ON u.idUsuario = s.fkDono;

-- SELECT DA PORCENTAGEM DE USUÁRIOS CADASTRADOS QUE JÁ CRIARAM/SÃO DONOS DE UMA SALA
	SELECT 
		round(
			(SELECT count(distinct u.idUsuario) as usuariosDonos
			FROM usuario u JOIN sala s
			ON u.idUsuario = s.fkDono) /
			
			(select count(distinct u.idUsuario) as totalUsuarios
			FROM usuario u) * 100
        , 2) as porcentagem_usuarios_donos_de_sala
        from usuario u
        LIMIT 1;


-- SELECT MÉDIA DE PESSOAS POR SALA REGISTRADA

	SELECT round(COUNT(*) / COUNT(distinct pkSala), 2) -- QUANTIDADE DE PARTICIPAÇÕES DIVIDIDO PELA QUANTIDADE DE SALAS
    -- EXEMPLO 10 PARTICIPAÇÕES E TOTAL DE 5 SALAS = 2 PESSOAS POR SALA 
    from participacao;
    
-- SELECT DO SISTEMA MAIS UTILIZADO 

SELECT sis.nome
	   from sistemas sis join sala s
	   on sis.idSistemas = s.fkSistema
	   group by sis.nome order by count(s.fkSistema) desc limit 1;
    
-- SELECT RETORNANDO A QUANTIDADE DE VEZES UTILIZADA
SELECT sis.nome,
	   count(s.fkSistema) quantidade_usada
	   from sistemas sis join sala s
	   on sis.idSistemas = s.fkSistema
	   group by sis.nome order by quantidade_usada desc limit 1;
 END;
 
 
BEGIN;-- SELECT DA PORCENTAGEM DE CADA SISTEMA UTILIZADO
SELECT
  CASE
    WHEN sis.nome IN ( -- RETORNA O NOME DOS 4 SISTEMAS MAIS UTILIZADOS COMO 'SISTEMA'
      SELECT sis2.nome
      
      FROM sistemas sis2
      JOIN sala s2 ON sis2.idSistemas = s2.fkSistema
      GROUP BY sis2.nome
      ORDER BY count(s2.fkSistema) DESC
	  
    ) THEN sis.nome
    ELSE 'Outros' -- SE NÃO FOR UM DOS 4 MAIS UTILIZADOS É EXIBIDO EM OUTROS
  END AS sistema, -- O RETORNO É FEITO NA COLUNA 'SISTEMA'
  ROUND(COUNT(s.fkSistema) * 100.0 / (SELECT COUNT(sala.idSala) FROM sala), 2) AS porcentagem_uso -- 
FROM sistemas sis
JOIN sala s ON sis.idSistemas = s.fkSistema
GROUP BY
sistema
ORDER BY porcentagem_uso DESC;


 -- Retorna o nome dos 4 sistemas mais utilizados
SELECT sis2.nome
      FROM sistemas sis2
      JOIN sala s2 ON sis2.idSistemas = s2.fkSistema
      GROUP BY sis2.nome
      ORDER BY count(s2.fkSistema) DESC
      LIMIT 4;
     

     
SELECT
  CASE
    WHEN top4.nome IS NOT NULL THEN sis.nome
    ELSE 'Outros'
  END AS sistema,
  ROUND(COUNT(s.fkSistema) * 100.0 / (SELECT COUNT(idSala) FROM sala), 2) AS porcentagem_uso
FROM sistemas sis
JOIN sala s ON sis.idSistemas = s.fkSistema
LEFT JOIN (
  SELECT sis2.nome
  FROM sistemas sis2
  JOIN sala s2 ON sis2.idSistemas = s2.fkSistema
  GROUP BY sis2.nome
  ORDER BY COUNT(s2.fkSistema) DESC
  LIMIT 4
) AS top4 ON sis.nome = top4.nome
GROUP BY sistema
ORDER BY 
porcentagem_uso, sistema DESC;

END;

select * from usuario; 

SELECT count(idUsuario) from usuario;