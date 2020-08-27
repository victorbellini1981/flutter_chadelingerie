import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:cha_de_lingerie/src/public/globals.dart';

Future<String> getUrlServidor() async {
  final response = await http.get(
      "https://sistemaagely.com.br/ajax?tela=GetVersaoApp&app=${configApp.nomeApp}&teste=${configApp.teste}&linkCompleto=true");

  if (response.statusCode == 200) {
    configApp.urlServidor = json.decode(response.body);
    return configApp.urlServidor;
  } else {
    throw Exception('Failed to load post');
  }
}

Future<Map<String, dynamic>> promessa(
    GlobalKey<ScaffoldState> scaffoldKey, String servico, Object obj) async {
  //String objjson = json.encode(obj);
  /*String url =
      "${configApp.urlServidor}/${configApp.servlet}?tela=${servico}&obj=${objjson}";*/
  //String url = "${configApp.urlServidor}/${configApp.servlet}?tela=${servico}";
  String url =
      // ignore: unnecessary_brace_in_string_interps
      'https://sistemaagely.com.br:8345/ChaDeLingerie27082020/chadelingerie?metodo=${servico}';
  final response = await http.get(url);

  if (response.statusCode == 200) {
    try {
      return json.decode(response.body);
    } catch (e) {
      //throw Exception('Formato inválido de retorno');
      scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text(
              "Falha ao ler dados do servidor! Verifique sua conexão com a internet.")));

      return null;
    }
  } else {
    //throw Exception('Failed to load post');
    scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
            "Falha de comunicação! Verifique sua conexão com a internet.")));
    return null;
  }
}

Future<Map<String, dynamic>> promessaB(
    GlobalKey<ScaffoldState> scaffoldKey, String servico, Object obj) async {
  //String objjson = json.encode(obj);
  /*String url =
      "${configApp.urlServidor}/${configApp.servlet}?tela=${servico}&obj=${objjson}";*/
  //String url = "${configApp.urlServidor}/${configApp.servlet}?tela=${servico}";
  String url =
      // ignore: unnecessary_brace_in_string_interps
      'https://sistemaagely.com.br:8345/ChaDeLingerie27082020/chadelingerie?metodo=${servico}&referencia=${obj}';
  final response = await http.get(url);

  if (response.statusCode == 200) {
    try {
      return json.decode(response.body);
    } catch (e) {
      //throw Exception('Formato inválido de retorno');
      scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text(
              "Falha ao ler dados do servidor! Verifique sua conexão com a internet.")));

      return null;
    }
  } else {
    //throw Exception('Failed to load post');
    scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
            "Falha de comunicação! Verifique sua conexão com a internet.")));
    return null;
  }
}

String textToMd5(String text) {
  return md5.convert(utf8.encode(text)).toString();
}
