var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
// router.post("/dashboard/pessoasCadastradas", function (req, res) {
//     usuarioController.cadastrar(req, res);
// })

router.get("/buscarSistemas", function (req, res) {
  dashboardController.buscarSistemas(req, res);
});

router.get("/pessoasCadastradas", function (req, res) {
  dashboardController.pegarCadastros6meses(req, res);
});
router.get("/pessoasCadastradasTodas", function (req, res) {
  dashboardController.pegarTodosCadastros(req, res);
});
router.get("/sistemasMaisFavoritados", function (req, res) {
  dashboardController.pegarSistemasMaisFavoritados(req, res);
});

module.exports = router;
