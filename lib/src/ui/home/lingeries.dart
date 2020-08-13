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
                                  print('ok');
                                },
                              )
                            : InkWell(
                                child: Image.network(
                                    'https://sistemaagely.com.br:8345/' +
                                        '${listaProdutos[index].link}'),
                                onTap: () {
                                  print('ok');
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
}
