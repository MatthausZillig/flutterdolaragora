import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

const request = "https://api.hgbrasil.com/finance";

void main() async {
  print(await getData());
  runApp(MaterialApp(
    home: Home(),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("\$ DÓLAR AGORA \$"),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Carregando...",
                    style: TextStyle(color: Colors.black54, fontSize: 25.5),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if(snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro ao carregar dados :(",
                      style: TextStyle(color: Colors.black54, fontSize: 25.5),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return Container( color: Colors.white,);
                }
            }
          }),
    );
  }
}
