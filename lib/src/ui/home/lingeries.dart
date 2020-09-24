import 'package:carousel_slider/carousel_slider.dart';
import 'package:cha_de_lingerie/core/utils.dart';
import 'package:cha_de_lingerie/src/models/Produtos.dart';
//import 'package:cha_de_lingerie/src/models/Usuario.dart';
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
    tamanhosElinks();
    tamanhosLin();
    getUrlServidor();
  }

  List tamEscolhido = new List();
  bool selectprod = false;
  bool comp = false;
  int indexP = 0;
  var referenciaP = '';
  var linkP = '';
  List linkProd = List();
  List links = List();
  var descricaoProd = '';
  var referenciaProd = '';
  var marcaProd = '';
  var tamanhosP = '';
  List tam = List();
  List tamanhosProd = List();
  // ignore: non_constant_identifier_names
  var preco_tabelaProd = 0.0;
  AlertDialog prod = AlertDialog();

  void tamanhosLin() {
    if (listaProdutos.length != 0) {
      for (int i = 0; i < listaProdutos.length; i++) {
        tamEscolhido.add('T');
      }
    } else {
      tamEscolhido = [];
    }
  }

  void tamanhosElinks() {
    for (var i = 0; i < listaProdutos.length; i++) {
      linkProd = [];
      linkP = '${listaProdutos[i].link}';
      linkP = linkP.replaceAll("{", "");
      linkP = linkP.replaceAll("}", "");
      linkProd = linkP.split(',');
      links.add(linkProd);
      tam = [];
      tamanhosProd = [];
      tamanhosP = '${listaProdutos[i].tamanhos}';
      tamanhosP = tamanhosP.replaceAll('{', '');
      tamanhosP = tamanhosP.replaceAll('}', '');
      tam = tamanhosP.split(',');
      tamanhosProd.add(tam[0]);
      for (int h = 0; h < tam.length; h++) {
        comp = false;
        for (int j = 0; j < tamanhosProd.length; j++) {
          if (tam[h] == tamanhosProd[j]) {
            comp = true;
            break;
          }
        }
        if (comp == false) {
          tamanhosProd.add(tam[h]);
        }
      }
    }
  }

  // função que detalha a lingerie escolhida
  detalhesP() async {
    Map retorno = await promessaB(_scaffoldKey, "GetProduto", referenciaP);
    if (retorno["situacao"] == "sucesso") {
      linkProd = [];
      linkP = retorno['obj']['link'];
      linkP = linkP.replaceAll("{", "");
      linkP = linkP.replaceAll("}", "");
      linkProd = linkP.split(',');
      descricaoProd = retorno['obj']['descricao'];
      referenciaProd = retorno['obj']['referencia'];
      marcaProd = retorno['obj']['marca'];
      tam = [];
      tamanhosProd = [];
      tamanhosP = retorno['obj']['tamanhos'];
      tamanhosP = tamanhosP.replaceAll("{", "");
      tamanhosP = tamanhosP.replaceAll("}", "");
      tam = tamanhosP.split(',');
      tamanhosProd.add(tam[0]);
      for (int i = 0; i < tam.length; i++) {
        comp = false;
        for (int j = 0; j < tamanhosProd.length; j++) {
          if (tam[i] == tamanhosProd[j]) {
            comp = true;
            break;
          }
        }
        if (comp == false) {
          tamanhosProd.add(tam[i]);
        }
      }
      for (int i = 0; i < tamanhosProd.length; i++) {
        if (tamanhosProd[i] == 'PP') {
          tamanhosProd[i] = 1;
        } else if (tamanhosProd[i] == 'P') {
          tamanhosProd[i] = 2;
        } else if (tamanhosProd[i] == 'M') {
          tamanhosProd[i] = 3;
        } else if (tamanhosProd[i] == 'G') {
          tamanhosProd[i] = 4;
        } else if (tamanhosProd[i] == 'GG') {
          tamanhosProd[i] = 5;
        } else if (tamanhosProd[i] == 'EG') {
          tamanhosProd[i] = 6;
        } else if (tamanhosProd[i] == 'XG') {
          tamanhosProd[i] = 7;
        } else if (tamanhosProd[i] == 'XXG') {
          tamanhosProd[i] = 8;
        }
      }
      tamanhosProd.sort();
      for (int i = 0; i < tamanhosProd.length; i++) {
        if (tamanhosProd[i] == 1) {
          tamanhosProd[i] = 'PP';
        } else if (tamanhosProd[i] == 2) {
          tamanhosProd[i] = 'P';
        } else if (tamanhosProd[i] == 3) {
          tamanhosProd[i] = 'M';
        } else if (tamanhosProd[i] == 4) {
          tamanhosProd[i] = 'G';
        } else if (tamanhosProd[i] == 5) {
          tamanhosProd[i] = 'GG';
        } else if (tamanhosProd[i] == 6) {
          tamanhosProd[i] = 'EG';
        } else if (tamanhosProd[i] == 7) {
          tamanhosProd[i] = 'XG';
        } else if (tamanhosProd[i] == 8) {
          tamanhosProd[i] = 'XXG';
        }
      }
      preco_tabelaProd = retorno['obj']['preco_tabela'];
      prod = AlertDialog(
          content: InkWell(
        onTap: () {},
        child: Wrap(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 4),
              child: Column(
                children: <Widget>[
                  retorno['obj']['link'] == '{NULL}'
                      ? InkWell(
                          child: Image.asset('assets/images/semfoto.jpeg'),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        )
                      : CarouselSlider(
                          options: CarouselOptions(/*aspectRatio: 44 / 44*/),
                          items: linkProd
                              .map((item) => InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    child: Image.network(
                                        'https://sistemaagely.com.br:8345/' +
                                            item),
                                  )))
                              .toList(),
                        ),
                  Text('Descrição: ' + descricaoProd,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      )),
                  Text(
                    'Ref: ' + referenciaProd,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  Text(
                    'Marca: ' + marcaProd,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  selecttam == 'T'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tamanhos: ',
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            ),
                            Container(
                                height: 30,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis
                                      .horizontal, // Axis.horizontal for horizontal list view.
                                  itemCount: tamanhosProd.length,
                                  itemBuilder: (ctx, index) {
                                    return Align(
                                        child: Row(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              tamEscolhido[indexP] =
                                                  tamanhosProd[index];
                                              Navigator.of(context).pop();
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        prod,
                                              );
                                            },
                                            child: tamEscolhido[indexP] !=
                                                    tamanhosProd[index]
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all()),
                                                    child: Text(
                                                      '${tamanhosProd[index]}',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 20),
                                                    ),
                                                  )
                                                : Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        border: Border.all()),
                                                    child: Text(
                                                      '${tamanhosProd[index]}',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 20),
                                                    ),
                                                  )),
                                        SizedBox(
                                          width: 10,
                                        )
                                      ],
                                    ));
                                  },
                                )),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tam. Selecionado: ' + selecttam,
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            ),
                          ],
                        ),
                  Text(
                    'Valor: ' + preco_tabelaProd.toStringAsFixed(2),
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      child: RaisedButton(
                        color: Colors.red,
                        child: Center(
                          child: Text(
                            "Adicionar à Lista",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        onPressed: () {
                          if (selecttam == 'T') {
                            if (tamEscolhido[indexP] == 'T') {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: Text(
                                    'selecione o tamanho',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ));
                                },
                              );
                            } else {
                              opcao[indexP] = true;
                              Navigator.of(context).pop();
                            }
                          } else {
                            tamEscolhido[indexP] = selecttam;
                            opcao[indexP] = true;
                            Navigator.of(context).pop();
                          }
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
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
    final btnRetornar = SizedBox(
        width: 120,
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
            listaProdutos = normal;
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Principal()));
          },
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ));

    final listaLingeries = listaProdutos.length == 0
        ? Center(
            child: Text('Nenhum ítem disponível'),
          )
        : Container(
            width: 300,
            height: 300,
            child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (250 / 500),
                children: List.generate(listaProdutos.length, (index) {
                  return Container(
                    padding: EdgeInsets.only(left: 4),
                    child: Column(
                      children: <Widget>[
                        listaProdutos[index].link == null ||
                                listaProdutos[index].link == '{NULL}'
                            ? InkWell(
                                child:
                                    Image.asset('assets/images/semfoto.jpeg'),
                                onTap: () {
                                  indexP = index;
                                  referenciaP =
                                      '${listaProdutos[index].referencia}';
                                  opcao[index] == false
                                      ? showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              _buildAboutDialog(context),
                                        )
                                      : _scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                              duration: Duration(seconds: 2),
                                              content: new Text(
                                                  'Produto já selecionado')));
                                },
                              )
                            : InkWell(
                                child: Image.network(
                                    'https://sistemaagely.com.br:8345/' +
                                        '${links[index][0]}'),
                                onTap: () {
                                  indexP = index;
                                  referenciaP =
                                      '${listaProdutos[index].referencia}';
                                  opcao[index] == false
                                      ? showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              _buildAboutDialog(context),
                                        )
                                      : _scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                              duration: Duration(seconds: 2),
                                              content: new Text(
                                                  'Produto já selecionado')));
                                },
                              ),
                        opcao[index] == true
                            ? Text('Ítem selecionado',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  backgroundColor: Colors.black,
                                  fontSize: 15,
                                ))
                            : SizedBox(
                                height: 0,
                              ),
                        Text('${listaProdutos[index].descricao}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                            )),
                        Text(
                            'Valor: '
                            '${listaProdutos[index].preco_tabela.toStringAsFixed(2)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                            )),
                        SizedBox(
                            child: RaisedButton(
                          color: Colors.red,
                          child: Center(
                            child: Text(
                              "+ Detalhes",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          onPressed: () {
                            indexP = index;
                            referenciaP = '${listaProdutos[index].referencia}';
                            opcao[index] == false
                                ? showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildAboutDialog(context),
                                  )
                                : _scaffoldKey.currentState.showSnackBar(
                                    new SnackBar(
                                        duration: Duration(seconds: 2),
                                        content: new Text(
                                            'Produto já selecionado')));
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ))
                      ],
                    ),
                  );
                })),
          );

    final btnSalvar = SizedBox(
        width: 120,
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
            // insere os produtos escolhidos pela noiva da lista de produtos disponíveis
            //  para a lista de presentes da noiva
            if (presentesSel.length == 0) {
              for (int i = 0; i < listaProdutos.length; i++) {
                if (opcao[i] == true) {
                  Produtos prod = Produtos();
                  prod.link = '${listaProdutos[i].link}';
                  prod.referencia = '${listaProdutos[i].referencia}';
                  prod.descricao = '${listaProdutos[i].descricao}';
                  prod.tamanhos = '${tamEscolhido[i]}';
                  prod.marca = '${listaProdutos[i].marca}';
                  prod.preco_tabela =
                      double.parse('${listaProdutos[i].preco_tabela}');
                  presentesSel.add(prod);
                }
              }
            } else {
              // se já tiver sido escolhida a lista de presentes, ele percorre essa lista,
              // e ve se algum produto foi escolhido novamente, caso tenha sido ele não é
              // adicionado novamente
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
                    prod.referencia = '${listaProdutos[i].referencia}';
                    prod.descricao = '${listaProdutos[i].descricao}';
                    prod.tamanhos = '${tamEscolhido[i]}';
                    prod.marca = '${listaProdutos[i].marca}';
                    prod.preco_tabela =
                        double.parse('${listaProdutos[i].preco_tabela}');
                    presentesSel.add(prod);
                  }
                }
              }
            }
            //ListaProdutos lista = ListaProdutos();
            //lista.listadepresentes = presentesSel;

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        btnSalvar,
                        SizedBox(
                          width: 5,
                        ),
                        btnRetornar
                      ],
                    )
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
