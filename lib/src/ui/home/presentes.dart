import 'package:cha_de_lingerie/core/utils.dart';
import 'package:cha_de_lingerie/src/ui/home/principal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cha_de_lingerie/src/public/globals.dart';

class Presentes extends StatefulWidget {
  @override
  _PresentesState createState() => _PresentesState();
}

class _PresentesState extends State<Presentes> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    tamanhosElinks();
    listaPresNoiva();
    getUrlServidor();
  }

  bool comp = false;
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

  void listaPresNoiva() {
    /* chamar função getlistapresnoiva, se retorno situação = sucesso
      list2 = retorno[obj], presentesSel = list.map (produto)...*/
    listaProdutos = normal;
    opcao = [];
    for (int i = 0; i < listaProdutos.length; i++) {
      opcao.add(false);
    }
    for (int i = 0; i < listaProdutos.length; i++) {
      for (int j = 0; j < presentesSel.length; j++) {
        if (listaProdutos[i].descricao == presentesSel[j].descricao) {
          opcao[i] = true;
        }
      }
    }
  }

  void tamanhosElinks() {
    for (var i = 0; i < presentesSel.length; i++) {
      linkProd = [];
      linkP = '${presentesSel[i].link}';
      linkP = linkP.replaceAll("{", "");
      linkP = linkP.replaceAll("}", "");
      linkProd = linkP.split(',');
      links.add(linkProd);
      tam = [];
      tamanhosProd = [];
      tamanhosP = '${presentesSel[i].tamanhos}';
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

  @override
  Widget build(BuildContext context) {
    final listaNoiva = presentesSel.length == 0
        ? Center(
            child: Text('Nenhum ítem foi selecionado.'),
          )
        : Container(
            width: 300,
            height: 300,
            child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (300 / 500),
                children: List.generate(presentesSel.length, (index) {
                  return Container(
                    padding: EdgeInsets.only(left: 4),
                    child: Column(
                      children: <Widget>[
                        presentesSel[index].link == '{NULL}'
                            ? Image.asset('assets/images/semfoto.jpeg')
                            : Image.network(
                                'https://sistemaagely.com.br:8345/' +
                                    '${links[index][0]}'),
                        Text('Descrição: ${presentesSel[index].descricao}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                            )),
                        Text('Tamanho: ${presentesSel[index].tamanhos}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                            )),
                        Text(
                            'Valor: ${presentesSel[index].preco_tabela.toStringAsFixed(2)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                            )),
                      ],
                    ),
                  );
                })),
          );

    final btnAdicionar = SizedBox(
        width: 250,
        child: RaisedButton(
          color: Colors.red,
          child: Center(
            child: Text(
              "Adicionar Lingeries",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          onPressed: () {
            listaProdutos = normal;
            selectedIndex = 2;

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Principal()));
          },
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ));

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

    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(height: 20),
                  Text("Lista de Presentes:",
                      style: TextStyle(color: Colors.red, fontSize: 20)),
                  SizedBox(height: 10),
                  listaNoiva,
                  SizedBox(
                    height: 10,
                  ),
                  btnAdicionar,
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
    ));
  }
}
