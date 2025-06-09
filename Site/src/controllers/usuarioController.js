var usuarioModel = require("../models/usuarioModel");
//var aquarioModel = require("../models/aquarioModel");

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {

        usuarioModel.autenticar(email, senha)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

                 
                            
                    if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else if (resultadoAutenticar.length != 1){
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                    else{
                        res.status(200).json(resultadoAutenticar);
                    }
                                
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    // Faça as validações dos valores
    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    } 
    else {

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioModel.cadastrar(email, senha)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    
                    //Aqui eu faço a validação de qual erro foi recebido para enviar
                    //A mensagem de erro para o HTML exibir
                    if (erro.code === 'ER_DUP_ENTRY') {
                        res.status(409).json("E-mail já cadastrado!");
                    } else {

                       res.status(500).json(erro.sqlMessage);
                    }
                 

                }
            );
    }
}

function cadastrarTodosSistemas(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    const idUsuario = req.body.idUsuarioServer;

    // Faça as validações dos valores

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioModel.cadastrarTodosSistemas(idUsuario)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    
}



function buscarSistemas(req, res) {

    const idUsuario = req.query.idUsuario;
    console.log("ID do usuário recebido:", req.query.idUsuario);

    // var idUsuario = sessionStorage.ID_USUARIO;
    // console.log('Session storage de ID USUARIO AQUI', idUsuario);

  usuarioModel
    .buscarSistemas(idUsuario)
    .then(function (resultado) {
      if (resultado.length > 0) {
        res.status(200).json(resultado);
      } else {
        res.status(204).send("Nenhum resultado encontrado!");
      }
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "Houve um erro ao buscar sistemas.",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}


function irParaSistema(req, res) {

    const idSistema = req.query.idSistema;
    console.log("ID do usuário recebido:", req.query.idUsuario);

    // var idUsuario = sessionStorage.ID_USUARIO;
    // console.log('Session storage de ID USUARIO AQUI', idUsuario);

  usuarioModel
    .irParaSistema(idSistema)
    .then(function (resultado) {
      if (resultado.length > 0) {
        res.status(200).json(resultado);
      } else {
        res.status(204).send("Nenhum resultado encontrado!");
      }
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "Houve um erro ao buscar sistemas.",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}

function favoritar(req, res){

    const idSistema = req.body.idSistemaServer;
    console.log('O ID Do sissssss', idSistema);

    const favoritado = req.body.favoritadoServer;
    const idUsuario = req.body.idUsuarioServer;


    usuarioModel.favoritar( favoritado, idUsuario , idSistema)
            .then(
                
                function (resultado) {

                    res.json(resultado);
                }
                
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    
}


module.exports = {
    autenticar,
    cadastrar,
    cadastrarTodosSistemas,
    buscarSistemas,
    irParaSistema,
    favoritar

}