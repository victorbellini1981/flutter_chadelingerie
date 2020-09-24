import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cha_de_lingerie/core/utils.dart';
import 'package:cha_de_lingerie/src/public/globals.dart';
import 'package:cha_de_lingerie/src/ui/home/principal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<bool> opcao = new List<bool>();
  List imagens; // album de fotos
  var _image; //foto do perfil
  bool albumServidor =
      false; //verifica se fotos do album estão vindo do servidor

  @override
  void initState() {
    super.initState();
    txtnome.text = nomeNoiva;
    txtemail.text = emailNoiva;
    getUrlServidor();
  }

  TextEditingController txtnome = new TextEditingController();
  TextEditingController txtemail = new TextEditingController();
  TextEditingController txttelefone = new TextEditingController();
  TextEditingController txtcpf = new TextEditingController();
  TextEditingController txtdata = new TextEditingController();
  TextEditingController txtnumero = new TextEditingController();
  TextEditingController txthora = new TextEditingController();
  TextEditingController txtcep = new TextEditingController();
  TextEditingController txtlogradouro = new TextEditingController();
  TextEditingController txtcidade = new TextEditingController();
  TextEditingController txtbairro = new TextEditingController();
  TextEditingController txtcomplemento = new TextEditingController();
  TextEditingController txtestado = new TextEditingController();
  TextEditingController txtmensagem = new TextEditingController();

/*chamar função que trás todos os dados da pessoa e do evento onde idnoiva = 
  idNoiva, se já tiver cadastrado aparecerão 
  as informações nos campos e variavel albumServidor = true, se não campos ficam vazios.
*/

//função que busca dadosdo endereço através de um CEP fornecido pelo usuário
  consultaCep() async {
    String cep = txtcep.text;

    // ignore: unnecessary_brace_in_string_interps
    String url = 'https://viacep.com.br/ws/${cep}/json/';

    http.Response response;

    response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);

    String logradouro = retorno["logradouro"];
    String cidade = retorno["localidade"];
    String bairro = retorno["bairro"];
    String complemento = retorno["complemento"];
    String estado = retorno["uf"];

    setState(() {
      txtlogradouro.text = logradouro;
      txtcidade.text = cidade;
      txtbairro.text = bairro;
      txtcomplemento.text = complemento;
      txtestado.text = estado;
    });
  }

//função que abre a câmera do celular para tirar uma foto para o perfil da noiva
  final picker = ImagePicker();
  final picher = ImagePicker();

  Future abreCamera() async {
    final picture = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(picture.path);
    });
  }

//função que abre a câmera do celular para tirar uma foto para o perfil da noiva
  Future abreGaleria() async {
    final gallery = await picher.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(gallery.path);
    });
  }

// que verifica se deu certo a conexão com a camera e galeria do celular
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

// função que adiciona imagens no álbum (no máximo 30 fotos)

  Future adicionaFotos() async {
    albumServidor = false;
    final albumFotos = await MultiImagePicker.pickImages(
      maxImages: 30,
    );
    setState(() {
      imagens = albumFotos;
    });
  }

// variável do tipo carrossel slider para mostrar fotos selecionadas na galeria do cel
  CarouselSlider instance;
// verifica se usuário já cadastrou sua foto, caso sim aparece a foto cadastrada senão
// aparece Texto 'Nenhuma imagem selecionada'
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
    // mascaras dos campos cpf,tel, data, hr e cep
    var cpfFormatter = new MaskTextInputFormatter(
        mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
    var telFormatter = new MaskTextInputFormatter(
        mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
    var dtFormatter = new MaskTextInputFormatter(
        mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
    var hrFormatter = new MaskTextInputFormatter(
        mask: '##:##', filter: {"#": RegExp(r'[0-9]')});
    var cepFormatter = new MaskTextInputFormatter(
        mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});

    final album = imagens == null
        ? Text("Nenhuma foto Selecionada")
        : albumServidor == false
            ? instance = CarouselSlider(
                options: CarouselOptions(),
                items: imagens
                    .map((item) => Container(
                        child:
                            AssetThumb(asset: item, width: 300, height: 300)))
                    .toList(),
              )
            : instance = CarouselSlider(
                options: CarouselOptions(),
                items: imagens
                    .map((item) => Container(
                          width: 300,
                          height: 300,
                          child: Image.network(
                              'https://sistemaagely.com.br:8345/' + item),
                        ))
                    .toList(),
              );

    final nome = TextFormField(
      decoration: const InputDecoration(
          labelText: 'Nome',
          labelStyle: TextStyle(color: Colors.red),
          hintText: 'Nome Completo',
          hintStyle: TextStyle(color: Colors.red),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          )),
      keyboardType: TextInputType.text,
      controller: txtnome,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final email = TextFormField(
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
      controller: txtemail,
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
          labelStyle: TextStyle(color: Colors.red),
          hintText: 'Somente números',
          hintStyle: TextStyle(color: Colors.red),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          )),
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
          labelText: 'Telefone',
          labelStyle: TextStyle(color: Colors.red),
          hintText: 'Celular com DDD e 9 nafrente',
          hintStyle: TextStyle(color: Colors.red),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          )),
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

    final mensagem = TextFormField(
      maxLines: 5,
      maxLength: 200,
      decoration: InputDecoration(
        labelText: 'Mensagem de Boas Vindas',
        labelStyle: TextStyle(color: Colors.red),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      keyboardType: TextInputType.text,
      controller: txtmensagem,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final logradouro = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Logradouro',
        labelStyle: TextStyle(color: Colors.red),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      keyboardType: TextInputType.text,
      controller: txtlogradouro,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final numero = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Nº',
        labelStyle: TextStyle(color: Colors.red),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      keyboardType: TextInputType.number,
      controller: txtnumero,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final complemento = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Complemento',
        labelStyle: TextStyle(color: Colors.red),
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      keyboardType: TextInputType.text,
      controller: txtcomplemento,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final cep = TextFormField(
      decoration: const InputDecoration(
        labelText: 'CEP',
        hintText: 'Somente números',
        hintStyle: TextStyle(color: Colors.red),
        labelStyle: TextStyle(color: Colors.red),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      keyboardType: TextInputType.number,
      controller: txtcep,
      inputFormatters: [cepFormatter],
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final uf = TextFormField(
      decoration: const InputDecoration(
        labelText: 'UF',
        hintText: 'Ex.: MG',
        hintStyle: TextStyle(color: Colors.red),
        labelStyle: TextStyle(color: Colors.red),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      keyboardType: TextInputType.text,
      controller: txtestado,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final bairro = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Bairro',
        labelStyle: TextStyle(color: Colors.red),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      keyboardType: TextInputType.text,
      controller: txtbairro,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final cidade = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Cidade',
        labelStyle: TextStyle(color: Colors.red),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      keyboardType: TextInputType.text,
      controller: txtcidade,
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final data = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Data',
        hintText: 'XX/XX/XXXX',
        hintStyle: TextStyle(color: Colors.red),
        labelStyle: TextStyle(color: Colors.red),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      keyboardType: TextInputType.number,
      controller: txtdata,
      inputFormatters: [dtFormatter],
      validator: (value) {
        if (value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );

    final hora = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Horário',
        hintText: 'XX:XX',
        hintStyle: TextStyle(color: Colors.red),
        labelStyle: TextStyle(color: Colors.red),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      keyboardType: TextInputType.number,
      controller: txthora,
      inputFormatters: [hrFormatter],
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

    final btnSalvar = SizedBox(
        width: 150,
        child: RaisedButton(
          color: Colors.red,
          child: Center(
            child: Text(
              "Salvar",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          onPressed: () {
            selectedIndex = 0;
            // verificações de campos preenchidos, caso todos estejam os dados são salvos, se não
            // dá msgde erro
            /*if (_image == null && fotoNoiva == null) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Tirar ou selecionar a foto do perfil!'),
                duration: Duration(seconds: 3),
              ));
            } else if (imagens == null) {
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
              if (txtmensagem.text.isEmpty) {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('Deixe uma mensagem para suas amigas!'),
                  duration: Duration(seconds: 3),
                ));
              } else if (txtdata.text.isEmpty || txtdata.text.length < 10) {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('Prencha a data corretamente!'),
                  duration: Duration(seconds: 3),
                ));
              } else if (txthora.text.isEmpty) {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('Preencha o horário!'),
                  duration: Duration(seconds: 3),
                ));
              } else if (txtestado.text.isEmpty) {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('Preencha o Estado!'),
                  duration: Duration(seconds: 3),
                ));
              } else if (txtcidade.text.isEmpty) {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('Preencha a cidade!'),
                  duration: Duration(seconds: 3),
                ));
              } else if (txtlogradouro.text.isEmpty) {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('Preencha a rua ou avenida!'),
                  duration: Duration(seconds: 3),
                ));
              } else if (txtnumero.text.isEmpty) {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('Preencha o número do endereço!'),
                  duration: Duration(seconds: 3),
                ));
              } else if (txtbairro.text.isEmpty) {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('Preencha o bairro!'),
                  duration: Duration(seconds: 3),
                ));
              }
              if (fotoPerfilN != null &&
                  entre == true &&
                  imagens != null &&
                  txtbairro.text.isNotEmpty) {
                Pessoa noiva = Pessoa();
                noiva.fotoPerfil = fotoPerfilN.toString();
                noiva.fotoAlbum = imagens;
                noiva.nome = txtnome.text;
                noiva.cpf = txtcpf.text;
                noiva.telefone = txttelefone.text;
                
                Evento evento = Evento();
                evento.msg = txtmensagem.text;
                evento.data = txtdata.text;
                evento.hora = txthora.text;
                evento.cep = txtcep.text;
                evento.uf = txtestado.text;
                evento.logradouro = txtlogradouro.text;
                evento.numero = txtnumero.text;
                evento.complemento = txtcomplemento.text;
                evento.bairro = txtbairro.text;
                evento.cidade = txtcidade.text;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Principal()));
              }
            }*/
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Principal()));
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
                    email,
                    SizedBox(height: 10),
                    cpf,
                    SizedBox(height: 10),
                    telefone,
                    SizedBox(
                      height: 20,
                    ),
                    Text("Dados do Evento:",
                        style: TextStyle(color: Colors.red, fontSize: 20)),
                    SizedBox(
                      height: 20,
                    ),
                    mensagem,
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 8,
                              child: data,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(" "),
                            ),
                            Expanded(
                              flex: 6,
                              child: hora,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 8,
                              child: cep,
                            ),
                            Expanded(
                              flex: 2,
                              child: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: consultaCep,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: uf,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    cidade,
                    SizedBox(height: 10),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 9,
                              child: logradouro,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(" "),
                            ),
                            Expanded(
                              flex: 3,
                              child: numero,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 7,
                              child: complemento,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(" "),
                            ),
                            Expanded(
                              flex: 6,
                              child: bairro,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    btnSalvar,
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
