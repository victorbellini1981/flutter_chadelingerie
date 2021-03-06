import 'dart:convert';

import 'package:cha_de_lingerie/src/models/Produtos.dart';
import 'package:cha_de_lingerie/src/models/Usuario.dart';
//import 'package:cha_de_lingerie/src/models/UsuarioLembrar.dart';
import 'package:cha_de_lingerie/src/public/globals.dart';
import 'package:cha_de_lingerie/src/ui/home/perfil.dart';
import 'package:cha_de_lingerie/src/ui/login/cadastro.dart';
import 'package:cha_de_lingerie/src/ui/login/login_recuperasenha.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cha_de_lingerie/core/utils.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  // controladores de texto do login e senha
  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();
  bool lembrar =
      false; // verifica se a noiva quer que lembre seu usuário e senha
  // variáveis de autenticação do google
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var list;
  var list2;
  var idUsuario;

  @override
  void initState() {
    super.initState();
    lista2();
    getUrlServidor();
  }

// função que retorna lista de produtos disponíveis para noiva escolher as lingeries
  void lista2() async {
    Map obj = Map();

    Map retorno = await promessa(_scaffoldKey, "GetProdutos", obj);
    if (retorno["situacao"] == "sucesso") {
      list = retorno["obj"];
      listaProdutos =
          list.map((produto) => Produtos.fromJson(produto)).toList();
      normal = list.map((produto) => Produtos.fromJson(produto)).toList();
      for (int i = 0; i < listaProdutos.length; i++) {
        opcao.add(false);
      }
      /* chamar função getlistapresnoiva, se retorno situação = sucesso
      list2 = retorno[obj], presentesSel = list2.map (produto)...*/
      for (int i = 0; i < listaProdutos.length; i++) {
        for (int j = 0; j < presentesSel.length; j++) {
          if (listaProdutos[i].descricao == presentesSel[j].descricao) {
            opcao[i] = true;
          }
        }
      }
      opcao2 = opcao;
    }
  }

// função para conectar no aplicativo com os dados de usuário do google
  Future<String> signInWithGoogle() async {
    lista2();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    Usuario usuario = Usuario();
    usuario.email = user.email;
    usuario.senha = "123456";

    nomeNoiva = user.displayName;
    fotoNoiva = user.photoUrl;
    emailNoiva = user.email;

    return 'Login com google ok: $user';
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    Navigator.push(context, MaterialPageRoute(builder: (context) => Perfil()));
  }

  bool isLoggedIn = false;
  var profileData;

  final FacebookLogin facebookLogin = new FacebookLogin();
// função que verifica se o acesso aos dados do face deu certo
  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

// função para conectar no aplicativo com os dados de usuário do facebook
  void initiateFacebookLogin() async {
    lista2();
    var facebookLoginResult =
        await facebookLogin.logInWithReadPermissions(['email']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        onLoginStatusChanged(false);
        facebookLogin.logOut();
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');

        var profile = json.decode(graphResponse.body);
        print(profile.toString());
        onLoginStatusChanged(true, profileData: profile);
        fotoDaNoiva = profileData;
        nomeNoiva = "${profileData['name']}";
        fotoNoiva = "${profileData['picture']['data']['url']}";
        emailNoiva = "${profileData['email']}";

        Usuario usuario = Usuario();
        usuario.email = emailNoiva;
        usuario.senha = "123456";

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Perfil()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final login = new TextFormField(
      decoration: const InputDecoration(
        labelText: 'E-mail',
        labelStyle: TextStyle(color: Colors.red),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.red,
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _loginController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final senha = new TextFormField(
      decoration: const InputDecoration(
        labelText: 'Senha',
        labelStyle: TextStyle(color: Colors.red),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        prefixIcon: Icon(Icons.lock, color: Colors.red),
      ),
      obscureText: true,
      keyboardType: TextInputType.text,
      controller: _senhaController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );
// switch que se true, noiva quer que lembre usuário e senha
    final chkLembrar = Row(
      children: <Widget>[
        SizedBox(width: 80),
        Switch(
          activeColor: Colors.red,
          value: lembrar,
          onChanged: (value) {
            setState(() {
              lembrar = value;
            });
          },
        ),
        Text(
          "Lembrar",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, color: Colors.red),
        )
      ],
    );
// função que verifica login e senha de usuario
    void entrar() async {
      selectedIndex =
          0; // variável que indica a tela que vai abrir no body da página principal
      // no caso, a Inicial()
      fotoNoiva =
          'https://scontent.fmoc5-1.fna.fbcdn.net/v/t1.0-9/118970883_3297674166986457_4508538385990977723_n.jpg?_nc_cat=103&_nc_sid=09cbfe&_nc_eui2=AeGbuDH8xTYVyat6_v8pMd_KIHBN6-mG9AMgcE3r6Yb0A0Oqv4gKZWceKYw303wVELwry3rr90gljh-MZ9SrojXk&_nc_ohc=IxBBZyFoXeQAX8XV6-w&_nc_ht=scontent.fmoc5-1.fna&oh=609048967840c17855d010876c01a10b&oe=5F7B500E';
      nomeNoiva = ' Marjorie Rafaela';
      emailNoiva = 'majurap@gmail.com';
      lista2();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Perfil()));
      /*if (_formKey.currentState.validate()) {
        Map obj = Map();
        obj["email"] = login.controller.text.trim();
        obj["senha"] =
            textToMd5("*${senha.controller.text.trim()}${configApp.nomeApp}");

        Map retorno = await promessa(_scaffoldKey, "GetLogin", obj);
        //print(json.encode(retorno["arrayObj"]));
        if (retorno["situacao"] == "ok") {
          if (lembrar) {
            usuarioLembrar = UsuarioLembrar();
            usuarioLembrar.email = obj["email"];
            usuarioLembrar.senha = obj["senha"];
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('usuarioLembrar', json.encode(usuarioLembrar));
          }
          
          emailNoiva = obj['email];
                    
          /*chama serviço que trás os dados da pessoa onde emailNoiva for igual 
          email da noiva logada, se já tiver cadastrados os dados 
          idNoiva = retorno['obj']["idnoiva"];
          nomeNoiva = retorno['obj']["nome"];
          fotoNoiva = retorno['obj']["fotoPerfil"];
          chama pagina principal se não
          idNoiva = retorno['obj']["idnoiva"];
          chama pagina perfil*/

          lista2();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Perfil()));
        } else {
          _scaffoldKey.currentState
              .showSnackBar(new SnackBar(content: new Text(retorno["msg"])));
        }
      }*/
    }

    final btnEntrar = SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: RaisedButton(
        child: Text('Entrar',
            textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0)),
        onPressed: entrar,
        color: Colors.red,
        textColor: Colors.white,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ),
    );

    final btnFacebook = SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: RaisedButton(
        child: Text('Entre com o Facebook',
            textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0)),
        onPressed: initiateFacebookLogin,
        color: Colors.red,
        textColor: Colors.white,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ),
    );

    final btnGoogle = SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: RaisedButton(
        child: Text('Entre com o Google',
            textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0)),
        onPressed: () {
          signInWithGoogle().whenComplete(() {
            signOutGoogle();
          });
        },
        color: Colors.red,
        textColor: Colors.white,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ),
    );
// botão esqueci minha senha
    final lnkEsqueci = GestureDetector(
        child: Text("Esqueci minha senha",
            style: TextStyle(color: Colors.red, fontSize: 16)),
        onTap: () {
          /*if (_loginController.text.isEmpty) {
            _scaffoldKey.currentState
                .showSnackBar(new SnackBar(content: new Text('Favor digitar seu e-mail')));
          } else {
            Map obj = Map();
            obj["email"] = login.controller.text.trim();
            
            Map retorno = await promessa(_scaffoldKey, "GetLogin", obj);
            //print(json.encode(retorno["arrayObj"]));
            if (retorno["situacao"] == "ok") {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginRecuperaSenha()));
            }
            else {
              _scaffoldKey.currentState
                .showSnackBar(new SnackBar(content: new Text('E-mail não encontrado')));  
            }  
          }*/
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginRecuperaSenha()));
        });

    final lnkCadastrar = GestureDetector(
        child: Text("Não tem cadastro? Cadastre-se",
            style: TextStyle(color: Colors.red, fontSize: 15)),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cadastro()));
        });

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
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(left: 50, right: 50),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 40),
                      login,
                      SizedBox(
                        height: 10,
                      ),
                      senha,
                      SizedBox(
                        height: 10,
                      ),
                      chkLembrar,
                      SizedBox(height: 20),
                      btnEntrar,
                      SizedBox(height: 20),
                      lnkCadastrar,
                      SizedBox(height: 10),
                      Text("ou",
                          style: TextStyle(color: Colors.red, fontSize: 15)),
                      SizedBox(height: 10),
                      btnFacebook,
                      SizedBox(height: 10),
                      Text("ou",
                          style: TextStyle(color: Colors.red, fontSize: 15)),
                      SizedBox(height: 10),
                      btnGoogle,
                      SizedBox(height: 20),
                      lnkEsqueci,
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
