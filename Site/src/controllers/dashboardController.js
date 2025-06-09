var dashboardModel = require("../models/dashboardModel");

function pegarSistemasMaisFavoritados(req, res) {
  dashboardModel
    .sistemasMaisFavoritados()
    .then(function (resultadoBusca) {
      console.log(`\nResultados encontrados: ${resultadoBusca.length}`);

      console.log(`Resultados: ${JSON.stringify(resultadoBusca)}`); // transforma JSON em String

      res.status(200).json(resultadoBusca);
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "\nHouve um erro ao realizar a busca de favoritos! Erro: ",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}

function pegarCadastros6meses(req, res) {
  dashboardModel
    .cadastros6meses()
    .then(function (resultadoBusca) {
      console.log(`\nResultados encontrados: ${resultadoBusca.length}`);

      console.log(`Resultados: ${JSON.stringify(resultadoBusca)}`); // transforma JSON em String

      res.status(200).json(resultadoBusca);
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "\nHouve um erro ao realizar a busca de cadastro dos últimos meses! Erro: ",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}

function pegarTodosCadastros(req, res) {
  dashboardModel
    .todosCadastros()
    .then(function (resultadoBusca) {
      console.log(`\nResultados encontrados: ${resultadoBusca.length}`);

      console.log(`Resultados: ${JSON.stringify(resultadoBusca)}`); // transforma JSON em String

      res.status(200).json(resultadoBusca);
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "\nHouve um erro ao realizar a busca de cadastro dos últimos meses! Erro: ",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
  pegarSistemasMaisFavoritados,
  pegarCadastros6meses,
  pegarTodosCadastros
};
