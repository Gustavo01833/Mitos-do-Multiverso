var database = require("../database/config");

function buscarSalas() {

  var instrucaoSql = `
  SELECT 
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
count(par.pkUsuario) >0`;

  

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(empresaId, descricao) {
  
  var instrucaoSql = `INSERT INTO (descricao, fk_empresa) aquario VALUES (${descricao}, ${empresaId})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarSalas,
  cadastrar
}
