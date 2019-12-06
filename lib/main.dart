import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(
      primaryColor: Colors.blue,
      hintColor: Colors.amber,
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)))),
  ));
}

Future<Map> getDados() async {
  String url = "https://api.hgbrasil.com/finance?key=c209638b";
  var response = await http.get(url);
  return json.decode(response.body);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" \$ Conversor \$"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: getDados(),
        builder: (context, conexao) {
          switch (conexao.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando Dados...",
                  style: TextStyle(color: Colors.amber, fontSize: 25),
                ),
              );
            default:
              if (conexao.hasError) {
                return Center(
                  child: Text(
                    "Deu erro :(",
                    style: TextStyle(color: Colors.amber, fontSize: 25),
                  ),
                );
              } else {
                return SingleChildScrollView(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        color: Colors.amber,
                        size: 150,
                      ),
                      Divider(),
                      campoTexto("Real", "R\$ "),
                      Divider(),
                      campoTexto("Dolar", "U\$D "),
                      Divider(),
                      campoTexto("Euro", "£ ")
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }

  Widget campoTexto(String label, String prefixo) {
    return TextField(
                      decoration: InputDecoration(
                        labelText: label,
                        labelStyle: TextStyle(color: Colors.amber),
                        border: OutlineInputBorder(),
                        prefix: Text(prefixo, style: TextStyle(color: Colors.amber, fontSize: 25),)
                      ),
                       style: TextStyle(color: Colors.amber, fontSize: 25),
                      keyboardType: TextInputType.number,
                    );
  }
}
