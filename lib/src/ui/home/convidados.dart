import 'package:cha_de_lingerie/core/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Convidados extends StatefulWidget {
  @override
  _ConvidadosState createState() => _ConvidadosState();
}

class _ConvidadosState extends State<Convidados> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var list;

  @override
  void initState() {
    super.initState();
    //listaCon();
    getUrlServidor();
  }

  TextEditingController txtmensagem = new TextEditingController();

  void listaCon() async {
    /*Map obj = Map();
    Map retorno = await promessa(_scaffoldKey, "GetProdutos", obj);
    if (retorno["situacao"] == "sucesso") {
      list = retorno["obj"];
      listaConvidados =
          list.map((convidado) => Convidados.fromJson(convidado)).toList();
    }*/
  }

  @override
  Widget build(BuildContext context) {
    // página inteira para listar convidados com nome e foto
    final List<String> listaConvidados = <String>[
      'João Victor Bellini',
      'Rafaela Pereira',
      'Miguel Bellini',
      'Davi Machado',
      'Marjorie Rafaela Alvarenga Pereira'
    ];

    final convidados = listaConvidados.length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: 400,
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              itemCount: listaConvidados.length,
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
                          Text('${listaConvidados[index]}',
                              maxLines: 2,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 25)),
                        ],
                      ),
                    )),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 20,
              ),
            ),
          );

    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 20),
                Center(
                  child: Text("Lista de Convidados:",
                      style: TextStyle(color: Colors.red, fontSize: 20)),
                ),
                SizedBox(height: 10),
                convidados
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
