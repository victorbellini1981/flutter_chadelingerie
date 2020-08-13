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
    getUrlServidor();
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
                        presentesSel[index].link == 'null'
                            ? Image.asset('assets/images/semfoto.jpeg')
                            : Image.network(
                                'https://sistemaagely.com.br:8345/' +
                                    '${presentesSel[index].link}'),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '${presentesSel[index].descricao}',
                          style: TextStyle(color: Colors.red),
                        ),
                        Text(
                          'Valor: ${presentesSel[index].preco_tabela}',
                          style: TextStyle(color: Colors.red),
                        ),
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
