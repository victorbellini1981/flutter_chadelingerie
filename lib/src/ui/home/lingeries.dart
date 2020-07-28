import 'dart:convert';

import 'package:cha_de_lingerie/src/models/Produtos.dart';
import 'package:cha_de_lingerie/src/models/Usuario.dart';
import 'package:cha_de_lingerie/src/public/globals.dart';
import 'package:cha_de_lingerie/src/ui/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Lingeries extends StatefulWidget {
  @override
  _LingeriesState createState() => _LingeriesState();
}

class _LingeriesState extends State<Lingeries> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  List<bool> opcao = new List<bool>();
  var tam;
  var selecttam = 'T';
  bool selectprod = false;
  bool checked = false;

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

  @override
  Widget build(BuildContext context) {
    var dtFormatter = new MaskTextInputFormatter(
        mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
    var hrFormatter = new MaskTextInputFormatter(
        mask: '##:##', filter: {"#": RegExp(r'[0-9]')});
    var cepFormatter = new MaskTextInputFormatter(
        mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});

    final tamLin = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: <Widget>[
              Radio(
                  value: 'PP',
                  groupValue: tam,
                  onChanged: (alteraTam) {
                    selecttam = 'PP';
                    setState(() {
                      tam = alteraTam;
                    });
                  }),
              Text(
                'PP',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: <Widget>[
              Radio(
                  value: 'P',
                  groupValue: tam,
                  onChanged: (alteraTam) {
                    selecttam = 'P';
                    setState(() {
                      tam = alteraTam;
                    });
                  }),
              Text(
                'P',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: <Widget>[
              Radio(
                  value: 'M',
                  groupValue: tam,
                  onChanged: (alteraTam) {
                    selecttam = 'M';
                    setState(() {
                      tam = alteraTam;
                    });
                  }),
              Text(
                'M',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: <Widget>[
              Radio(
                  value: 'G',
                  groupValue: tam,
                  onChanged: (alteraTam) {
                    selecttam = 'G';
                    setState(() {
                      tam = alteraTam;
                    });
                  }),
              Text(
                'G',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: Column(
            children: <Widget>[
              Radio(
                  value: 'GG',
                  groupValue: tam,
                  onChanged: (alteraTam) {
                    selecttam = 'GG';
                    setState(() {
                      tam = alteraTam;
                    });
                  }),
              Text(
                'GG',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    );

    final mensagem = TextFormField(
      maxLines: 5,
      maxLength: 200,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Mensagem de Boas Vindas',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
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
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
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
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
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
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
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
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
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
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
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
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
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
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
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
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
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

    for (int i = 0; i < listaProduto.length; i++) {
      opcao.add(false);
    }
    void itemChange(bool val, int index) {
      setState(() {
        opcao[index] = val;
      });
    }

    final listaLingeries = listaProduto.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            width: 300,
            height: 300,
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              itemCount: listaProduto.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    children: <Widget>[
                      listaProduto[index].link == null
                          ? Image.asset('assets/images/semfoto.jpeg')
                          : Image.network('https://sistemaagely.com.br:8345/' +
                              '${listaProduto[index].link}'),
                      SizedBox(height: 5),
                      CheckboxListTile(
                          activeColor: Colors.red,
                          value: opcao[index],
                          title: Text(
                            '${listaProduto[index].descricao}',
                            style: TextStyle(fontSize: 20, color: Colors.red),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (bool val) {
                            selectprod = true;
                            itemChange(val, index);
                          }),
                      Text(
                        'Valor: ${listaProduto[index].preco_tabela}',
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 20,
              ),
            ),
          );

    final btnSalvar = SizedBox(
        width: 200,
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
            /*if (selecttam == 'T') {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Selecione o tamanho da lingerie!'),
                duration: Duration(seconds: 3),
              ));
            } else if (selectprod == false) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Escolha as lingeries!'),
                duration: Duration(seconds: 3),
              ));
            } else if (txtmensagem.text.isEmpty) {
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
            }
             else if (txtcidade.text.isEmpty) {
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
            } else {*/
            Noiva noiva = Noiva();
            noiva.fotoPerfil = fotoPerfilN;
            noiva.fotoAlbum = fotoAlbumN;
            noiva.nome = nomeN;
            noiva.cpf = cpfN;
            noiva.telefone = telN;
            noiva.tamLin = selecttam;
            noiva.vlrMeta = valorMeta;
            List presentes = List();
            double meta = 0.0;
            for (int i = 0; i < listaProduto.length; i++) {
              if (opcao[i] == true) {
                Produtos prod = Produtos();
                prod.idproduto = '${listaProduto[i].idproduto}';
                prod.referencia = '${listaProduto[i].referencia}';
                prod.descricao = '${listaProduto[i].descricao}';
                prod.preco_tabela =
                    double.parse('${listaProduto[i].preco_tabela}');
                meta = meta + prod.preco_tabela;
                prod.marca = '${listaProduto[i].marca}';
                prod.link = '${listaProduto[i].link}';
                presentes.add(prod);
              }
            }
            noiva.listaPresentes = presentes;
            noiva.meta = meta;
            /*for (int i = 0; i < listaProduto.length; i++) {
              if (opcao[i] == true) {
                ListaPresentes lingerie = ListaPresentes();
                lingerie.referencia = '${listaProduto[i].referencia}';
                lingerie.descricao = '${listaProduto[i].descricao}';
                lingerie.tamanho = selecttam;
                lingerie.preco_tabela =
                    double.parse('${listaProduto[i].preco_tabela}');
                lingerie.marca = '${listaProduto[i].marca}';
                lingerie.link = '${listaProduto[i].link}';
              }
            }*/
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
            print(noiva.meta);
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Dados salvos com sucesso!'),
              duration: Duration(seconds: 3),
            ));
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
            //}
          },
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ));

    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
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
                    Text("Lista de Presentes:",
                        style: TextStyle(color: Colors.red, fontSize: 20)),
                    SizedBox(height: 10),
                    Text("Tam. da Lingerie:",
                        style: TextStyle(color: Colors.red, fontSize: 16)),
                    SizedBox(height: 10),
                    tamLin,
                    SizedBox(height: 30),
                    Text("Escolha as lingeries:",
                        style: TextStyle(color: Colors.red, fontSize: 16)),
                    SizedBox(height: 10),
                    listaLingeries,
                    SizedBox(
                      height: 20,
                    ),
                    Text("Dados do Evento:",
                        style: TextStyle(color: Colors.red, fontSize: 20)),
                    SizedBox(
                      height: 20,
                    ),
                    mensagem,
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
                              flex: 6,
                              child: complemento,
                            ),
                            Expanded(
                              flex: 2,
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
                    SizedBox(height: 40),
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
