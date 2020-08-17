import 'package:cha_de_lingerie/core/utils.dart';
import 'package:cha_de_lingerie/src/models/Produtos.dart';
import 'package:cha_de_lingerie/src/public/globals.dart';
import 'package:cha_de_lingerie/src/ui/home/principal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  bool selectprod = false;
  bool comp = false;
  int indexP = 0;
  var referenciaP = '';
  var linkP = '';
  List linkProd = List();
  var descricaoProd = '';
  var tamanhosP = '';
  List tamanhosProd = List();
  // ignore: non_constant_identifier_names
  var preco_tabelaProd = 0.0;
  AlertDialog prod = AlertDialog();

  detalhesP() async {
    Map retorno = await promessaB(_scaffoldKey, "GetProduto", referenciaP);
    if (retorno["situacao"] == "sucesso") {
      linkP = retorno['obj']['link'];
      linkP = linkP.replaceAll("{", "");
      linkP = linkP.replaceAll("}", "");
      linkProd = linkP.split(',');
      descricaoProd = retorno['obj']['descricao'];
      tamanhosP = retorno['obj']['tamanhos'];
      tamanhosP = tamanhosP.replaceAll("{", "");
      tamanhosP = tamanhosP.replaceAll("}", "");
      List tam = List();
      tam = tamanhosP.split(',');
      tamanhosProd.add(tam[0]);
      for (int i = 0; i < tam.length; i++) {
        comp = false;
        for (int j = 0; j < tamanhosProd.length; i++) {
          if (tam[i] == tamanhosProd[j]) {
            comp = true;
            break;
          }
        }
        if (comp == false) {
          tamanhosProd.add(tam[i]);
        }
      }
      preco_tabelaProd = retorno['obj']['preco_tabela'];
      prod = AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          content: Wrap(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 4),
                child: Column(
                  children: <Widget>[
                    listaProdutos[indexP].link == null ||
                            listaProdutos[indexP].link == 'null'
                        ? InkWell(
                            child: Image.asset('assets/images/semfoto.jpeg'),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          )
                        : InkWell(
                            child: Image.network(
                                'https://sistemaagely.com.br:8345/' +
                                    linkProd[0]),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      descricaoProd,
                      style: TextStyle(color: Colors.red),
                    ),
                    Text(
                      'Tamanhos: ' + tamanhosP,
                      style: TextStyle(color: Colors.red),
                    ),
                    Text(
                      'Valor: ' + preco_tabelaProd.toString(),
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              )
            ],
          ));
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) => prod,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < listaProdutos.length; i++) {
      opcao.add(false);
    }
    void itemChange(bool val, int index) {
      setState(() {
        opcao[index] = val;
      });
    }

    final btnSair = SizedBox(
        width: 200,
        child: RaisedButton(
          color: Colors.red,
          child: Center(
            child: Text(
              "Retornar",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          onPressed: () {
            selectedIndex = 0;
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Principal()));
          },
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ));

    final listaLingeries = listaProdutos.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            width: 300,
            height: 300,
            child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (300 / 500),
                children: List.generate(listaProdutos.length, (index) {
                  return Container(
                    padding: EdgeInsets.only(left: 4),
                    child: Column(
                      children: <Widget>[
                        listaProdutos[index].link == null ||
                                listaProdutos[index].link == 'null'
                            ? InkWell(
                                child:
                                    Image.asset('assets/images/semfoto.jpeg'),
                                onTap: () {
                                  indexP = index;
                                  referenciaP =
                                      '${listaProdutos[index].referencia}';
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildAboutDialog(context),
                                  );
                                },
                              )
                            : InkWell(
                                child: Image.network(
                                    'https://sistemaagely.com.br:8345/' +
                                        '${listaProdutos[index].link}'),
                                onTap: () {
                                  indexP = index;
                                  referenciaP =
                                      '${listaProdutos[index].referencia}';
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildAboutDialog(context),
                                  );
                                },
                              ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '${listaProdutos[index].descricao}',
                          style: TextStyle(color: Colors.red),
                        ),
                        CheckboxListTile(
                            activeColor: Colors.red,
                            value: opcao[index],
                            title: Text(
                              'Valor: ${listaProdutos[index].preco_tabela}',
                              style: TextStyle(color: Colors.red),
                            ),
                            onChanged: (bool val) {
                              selectprod = true;
                              itemChange(val, index);
                            }),
                      ],
                    ),
                  );
                })),
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
            if (presentesSel.length == 0) {
              for (int i = 0; i < listaProdutos.length; i++) {
                if (opcao[i] == true) {
                  Produtos prod = Produtos();
                  prod.link = '${listaProdutos[i].link}';
                  prod.descricao = '${listaProdutos[i].descricao}';
                  prod.preco_tabela =
                      double.parse('${listaProdutos[i].preco_tabela}');
                  presentesSel.add(prod);
                }
              }
            } else {
              for (int i = 0; i < listaProdutos.length; i++) {
                comp = false;
                if (opcao[i] == true) {
                  for (int j = 0; j < presentesSel.length; j++) {
                    if (listaProdutos[i].descricao ==
                        presentesSel[j].descricao) {
                      comp = true;
                      break;
                    }
                  }
                  if (comp == false) {
                    Produtos prod = Produtos();
                    prod.link = '${listaProdutos[i].link}';
                    prod.descricao = '${listaProdutos[i].descricao}';
                    prod.preco_tabela =
                        double.parse('${listaProdutos[i].preco_tabela}');
                    presentesSel.add(prod);
                  }
                }
              }
            }
            /*ListaProdutos lista = ListaProdutos();
            lista.listadepresentes = presentesSel;*/
            selectedIndex = 1;
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
                    /*Text("Tam. da Lingerie:",
                        style: TextStyle(color: Colors.red, fontSize: 16)),
                    SizedBox(height: 10),
                    tamLin,
                    SizedBox(height: 30),*/
                    Text("Escolha as lingeries:",
                        style: TextStyle(color: Colors.red, fontSize: 16)),
                    SizedBox(height: 10),
                    listaLingeries,
                    SizedBox(
                      height: 10,
                    ),
                    btnSalvar,
                    SizedBox(
                      height: 5,
                    ),
                    btnSair
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildAboutDialog(BuildContext context) {
    detalhesP();
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
