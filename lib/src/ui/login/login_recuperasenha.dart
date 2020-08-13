import 'package:cha_de_lingerie/core/utils.dart';
import 'package:cha_de_lingerie/src/public/style.dart';
import 'package:cha_de_lingerie/src/ui/login/login.dart';
import 'package:flutter/material.dart';

class LoginRecuperaSenha extends StatefulWidget {
  @override
  _LoginRecuperaSenhaState createState() => _LoginRecuperaSenhaState();
}

class _LoginRecuperaSenhaState extends State<LoginRecuperaSenha> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formkey = new GlobalKey<FormState>();
  final _emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getUrlServidor();
  }

  Widget build(BuildContext context) {
    final email = new TextFormField(
      decoration: const InputDecoration(
        labelText: 'E-mail',
        labelStyle: TextStyle(color: Colors.red),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      keyboardType: TextInputType.text,
      controller: _emailController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    void recuperar() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }

    final recuperarSenha = SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      height: 40,
      child: RaisedButton(
        child: Text('Recuperar Senha',
            textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0)),
        onPressed: recuperar,
        color: Colors.red,
        textColor: Colors.white,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          backgroundColor: Colors.red,
          title: Text("Chá de lingerie",
              style: TextStyle(color: Colors.white, fontSize: 30)),
        ),
        body: Form(
          key: _formkey,
          child: Container(
            padding: EdgeInsets.only(left: 50, right: 50),
            decoration: boxFundo,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 40),
                        Center(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 150,
                                height: 150,
                                child: Image.asset('assets/images/cadeado.jpg'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Esqueceu sua Senha?',
                                style:
                                    TextStyle(fontSize: 25, color: Colors.red),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Digite seu e-mail que enviaremos um link para redefinição de sua senha!!!',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              email,
                              SizedBox(
                                height: 20,
                              ),
                              recuperarSenha,
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
