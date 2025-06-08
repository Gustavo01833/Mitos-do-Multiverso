var express = require("express");
var router = express.Router();

var usuarioController = require("../controllers/usuarioController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrar", function (req, res) {
    usuarioController.cadastrar(req, res);
})

router.post("/cadastrarTodosSistemas", function (req, res) {
    usuarioController.cadastrarTodosSistemas(req, res);
})

router.post("/autenticar", function (req, res) {
    usuarioController.autenticar(req, res);
});

router.post("/favoritar", function (req, res) {
    usuarioController.favoritar(req, res);
});

router.get("/buscarSistemas", function (req, res) {
    
  usuarioController.buscarSistemas(req, res);
});

router.get("/irParaSistema", function (req, res) {
    
  usuarioController.irParaSistema(req, res);
});






module.exports = router;