var express = require("express");
var router = express.Router();

var salasController = require("../controllers/salasController");

router.get("/", function (req, res) {
  salasController.buscarSalas(req, res);
});


module.exports = router;