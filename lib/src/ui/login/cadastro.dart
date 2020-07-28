import 'package:cha_de_lingerie/core/utils.dart';
import 'package:cha_de_lingerie/src/models/Usuario.dart';
import 'package:cha_de_lingerie/src/ui/login/login.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getUrlServidor();
  }

  TextEditingController txtsenha = new TextEditingController();
  TextEditingController txtlogin = new TextEditingController();
  TextEditingController txtnome = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nome = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Nome Completo',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
      controller: txtnome,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final login = TextFormField(
      decoration: const InputDecoration(
          labelText: 'E-mail',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder()),
      keyboardType: TextInputType.text,
      controller: txtlogin,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final senha = TextFormField(
      decoration: const InputDecoration(
          labelText: 'Senha',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder()),
      keyboardType: TextInputType.text,
      controller: txtsenha,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    void cadastrar() async {
      /*if (txtlogin.text.contains('@') && txtlogin.text.contains('.com')) {
        if (txtsenha.text.length >= 6 && txtsenha.text.length <= 8) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('cadastro realizado com sucesso!'),
            duration: Duration(seconds: 5),
          ));*/

      Usuario usuario = Usuario();
      usuario.ativo = true;
      usuario.nome = txtnome.text;
      usuario.email = txtlogin.text;
      usuario.senha = txtsenha.text;

      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
      /*} else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Senha deve conter entre 6 e 8 dígitos.'),
            duration: Duration(seconds: 5),
          ));
        }
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('E-mail inválido.'),
          duration: Duration(seconds: 5),
        ));
      }*/
    }

    final btnCadastrar = SizedBox(
        width: 200,
        child: RaisedButton(
          color: Colors.red,
          child: Center(
            child: Text(
              "Cadastrar",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          onPressed: cadastrar,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ));

    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text("Chá de lingerie",
            style: TextStyle(color: Colors.white, fontSize: 30)),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 40),
                    Text('Cadastro',
                        style: TextStyle(fontSize: 30, color: Colors.red)),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    nome,
                    SizedBox(height: 10),
                    login,
                    SizedBox(height: 10),
                    senha,
                    SizedBox(height: 30),
                    btnCadastrar,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
