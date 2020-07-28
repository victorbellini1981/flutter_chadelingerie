import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cha_de_lingerie/core/utils.dart';
import 'package:cha_de_lingerie/src/public/globals.dart';
import 'package:cha_de_lingerie/src/ui/home/lingeries.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<bool> opcao = new List<bool>();

  @override
  void initState() {
    super.initState();
    txtnome.text = nomeNoiva;
    getUrlServidor();
  }

  TextEditingController txtnome = new TextEditingController();
  TextEditingController txttelefone = new TextEditingController();
  TextEditingController txtcpf = new TextEditingController();

  final picker = ImagePicker();
  final picher = ImagePicker();
  var _image;

  Future abreCamera() async {
    final picture = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(picture.path);
    });
  }

  Future abreGaleria() async {
    final gallery = await picher.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(gallery.path);
    });
  }

  void _handleVideo(PickedFile file) {}

  void _handleImage(PickedFile file) {}

  void _handleError(PlatformException exception) {}

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response == null) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.type == RetrieveType.video) {
          _handleVideo(response.file);
        } else {
          _handleImage(response.file);
        }
      });
    } else {
      _handleError(response.exception);
    }
  }

  List imagens;

  Future adicionaFotos() async {
    final albumFotos = await MultiImagePicker.pickImages(
      maxImages: 30,
    );
    setState(() {
      imagens = albumFotos;
    });
  }

  CarouselSlider instance;

  _fotoDoPerfil(profileData) {
    if (fotoNoiva == null) {
      return Text('Nenhuma imagem selecionada');
    } else {
      return Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
              fotoNoiva,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var cpfFormatter = new MaskTextInputFormatter(
        mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
    var telFormatter = new MaskTextInputFormatter(
        mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

    final album = imagens == null
        ? Text("Nenhuma foto Selecionada")
        : instance = CarouselSlider(
            options: CarouselOptions(),
            items: imagens
                .map((item) => Container(
                    child: AssetThumb(asset: item, width: 300, height: 300)))
                .toList(),
          );

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

    final cpf = TextFormField(
      decoration: const InputDecoration(
        labelText: 'CPF',
        hintText: 'Somente números',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      controller: txtcpf,
      inputFormatters: [cpfFormatter],
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final telefone = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Celular com DDD e 9 na frente',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      controller: txttelefone,
      inputFormatters: [telFormatter],
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final fotoPerfil = Column(
      children: <Widget>[
        Text("Foto do Perfil:",
            style: TextStyle(color: Colors.red, fontSize: 20)),
        SizedBox(height: 10),
        Center(
            child: _image == null
                ? _fotoDoPerfil(fotoDaNoiva)
                : Container(
                    height: 300,
                    width: 300,
                    child: Image.file(_image),
                  )),
        Row(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Text("Tirar foto:",
                  style: TextStyle(color: Colors.red, fontSize: 20)),
            ),
            Expanded(
              flex: 2,
              child: Text(" "),
            ),
            Expanded(
              flex: 6,
              child: IconButton(
                icon: Image.asset('assets/images/camera.png'),
                onPressed: abreCamera,
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Text("Selecionar foto:",
                  style: TextStyle(color: Colors.red, fontSize: 20)),
            ),
            Expanded(
              flex: 2,
              child: Text(" "),
            ),
            Expanded(
              flex: 6,
              child: IconButton(
                icon: Image.asset('assets/images/galeria.png'),
                onPressed: abreGaleria,
              ),
            )
          ],
        ),
      ],
    );

    final albumFotos = Column(
      children: <Widget>[
        Text("Álbum de Fotos:",
            style: TextStyle(color: Colors.red, fontSize: 20)),
        SizedBox(height: 10),
        album,
        Row(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Text("Selecionar fotos:",
                  style: TextStyle(color: Colors.red, fontSize: 20)),
            ),
            Expanded(
              flex: 2,
              child: Text(" "),
            ),
            Expanded(
              flex: 6,
              child: IconButton(
                icon: Image.asset('assets/images/galeria.png'),
                onPressed: adicionaFotos,
              ),
            )
          ],
        ),
      ],
    );

    final btnProximo = SizedBox(
        width: 200,
        child: RaisedButton(
          color: Colors.red,
          child: Center(
            child: Text(
              "Lista de Presentes",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          onPressed: () {
            if (_image == null && fotoNoiva == null) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Tirar ou selecionar a foto do perfil!'),
                duration: Duration(seconds: 3),
              ));
            }
            if (imagens == null) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Escolha as fotos do álbum!'),
                duration: Duration(seconds: 3),
              ));
            } else if (txtnome.text == ' ') {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Digite o nome completo!'),
                duration: Duration(seconds: 3),
              ));
            } else if (txtcpf.text.length < 14) {
              print(txtnome.text);
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Cpf precisa ter 11 números digitados!'),
                duration: Duration(seconds: 3),
              ));
            } else if (txtcpf.text.length == 14) {
              var cpf = txtcpf.text.replaceAll('.', '');
              cpf = cpf.replaceAll('-', '');
              var soma = 0;
              var soma2 = 0;
              var resto;
              var resto2;
              for (int i = 1; i <= 9; i++) {
                soma = soma + int.parse(cpf[i - 1]) * (11 - i);
              }
              resto = (soma * 10) % 11;
              if (resto == 10 || resto == 11) {
                resto = 0;
              }
              for (int i = 1; i <= 10; i++) {
                soma2 = soma2 + int.parse(cpf[i - 1]) * (12 - i);
              }
              resto2 = (soma2 * 10) % 11;
              if (resto2 == 10 || resto2 == 11) {
                resto2 = 0;
              }
              var entre = true;
              if (cpf == '00000000000' ||
                  cpf == '11111111111' ||
                  cpf == '22222222222' ||
                  cpf == '33333333333' ||
                  cpf == '44444444444' ||
                  cpf == '55555555555' ||
                  cpf == '66666666666' ||
                  cpf == '77777777777' ||
                  cpf == '88888888888' ||
                  cpf == '99999999999' ||
                  resto != int.parse(cpf[9]) ||
                  resto2 != int.parse(cpf[10])) {
                entre = false;
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('CPF inválido!'),
                  duration: Duration(seconds: 3),
                ));
              } else if (txttelefone.text.length < 15) {
                entre = false;
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('Celular precisa ter 11 números digitados!'),
                  duration: Duration(seconds: 3),
                ));
              } else if (_image != null) {
                fotoPerfilN = _image;
              } else if (_image == null) {
                fotoPerfilN = fotoNoiva;
              }
              if (fotoPerfilN != null && entre == true) {
                fotoAlbumN = imagens;
                nomeN = txtnome.text;
                cpfN = txtcpf.text;
                telN = txttelefone.text;

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Lingeries()));
              }
            }
          },
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
                    SizedBox(height: 20),
                    fotoPerfil,
                    SizedBox(height: 40),
                    albumFotos,
                    SizedBox(height: 20),
                    Text("Dados Pessoais:",
                        style: TextStyle(color: Colors.red, fontSize: 20)),
                    SizedBox(height: 10),
                    nome,
                    SizedBox(height: 10),
                    cpf,
                    SizedBox(height: 10),
                    telefone,
                    SizedBox(height: 20),
                    btnProximo,
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
