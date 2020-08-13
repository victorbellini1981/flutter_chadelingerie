import 'package:cha_de_lingerie/core/utils.dart';
import 'package:cha_de_lingerie/src/public/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Inicial extends StatefulWidget {
  @override
  _InicialState createState() => _InicialState();
}

class _InicialState extends State<Inicial> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getUrlServidor();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> listaRecados = <String>[
      'João Victor Bellini',
      'Rafaela Pereira',
      'João Victor Bellini',
      'Rafaela Pereira'
    ];

    final List<String> listmensagens = <String>[
      'Muito obrigado pelo convite, estarei lá !!!',
      'Muito obrigado pelo convite, estarei lá !!!',
      'Muito obrigado pelo convite, estarei lá !!!',
      'Muito obrigado pelo convite, estarei lá !!!'
    ];

    final recados =
        /*listaRecados.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        :*/
        Container(
      height: 300,
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        itemCount: listaRecados.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      'https://scontent.fvag3-1.fna.fbcdn.net/v/t1.0-9/20727994_1401203359974779_7391463482417964687_n.jpg?_nc_cat=107&_nc_sid=85a577&_nc_eui2=AeGMPLkEQHbtyR46sckdkToqJ-DOa70fbWMn4M5rvR9tY7-bGVx2M2LFhbDFb6D4Q-AhrOD4-N1zhATvki0EeVNa&_nc_ohc=AT_srjnKhX4AX96c_RQ&_nc_ht=scontent.fvag3-1.fna&oh=9440de3679fab931944872e2036d03c0&oe=5F59DC9B',
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${listaRecados[index]}',
                        style: TextStyle(color: Colors.red, fontSize: 25)),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        '${listmensagens[index]}',
                        style: TextStyle(fontSize: 15),
                        maxLines: 4,
                      ),
                    ),
                  ],
                ),
              )),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 20,
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(height: 20),
                  Text("Bem Vinda",
                      style: TextStyle(color: Colors.red, fontSize: 30)),
                  SizedBox(height: 10),
                  Text(nomeNoiva,
                      style: TextStyle(color: Colors.red, fontSize: 30)),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          'https://scontent.fvag3-1.fna.fbcdn.net/v/t1.0-9/99436560_4467396746619915_6394530860007161856_n.jpg?_nc_cat=106&_nc_sid=8024bb&_nc_eui2=AeEN4d0gEAEszhnDe6jyGECP3PmZ5IbCcU3c-ZnkhsJxTRETPNdE2AO5zEardwiVp9E07TWNtYI3GB2g1-A1t7G7&_nc_ohc=PcPr5fba0HEAX_DeBY1&_nc_ht=scontent.fvag3-1.fna&oh=ed3eadfccff03e75ebfcb1d52b93dd68&oe=5F518D8E',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Mural de Recados",
                      style: TextStyle(color: Colors.red, fontSize: 25)),
                  SizedBox(
                    height: 10,
                  ),
                  recados,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
