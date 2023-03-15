import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:requests/requests.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(
    MaterialApp(
      routes: {
        '/': (BuildContext context) {
          return TestAdminka();
        },
      },
    ),
  );
}
class TestAdminka extends StatefulWidget {
  const TestAdminka({
    Key? key,
  }) : super(key: key);
  @override
  State createState() => _TestAdminkaState();
}
class _TestAdminkaState extends State {
  String _data = "no data";
  getData() async {

   //присваиваем полученный код страницы, переменной _data

    final token =
        't1.9euelZrIksyTzJeXmZCWiouKy5yMm-3rnpWais6KiczPzovNmpqJlIzKlsfl8_dVczhf-e8nNXYm_d3z9xUiNl_57yc1dib9zef1656VmsuUiZ6ZmJWNnZySlJOTm5qM7_0.LTIaGE67d46sFDp4T767ucHoSss04YIGksZ6So8dJ1rGFMifzfr_pR-qsCcMZanbXf4t_mXKgHfOEU6d_Iy_Cg';

    // final url = Uri.parse("https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/c9qrdr73am2rvah0kq5q/databases/pionerdb");
    //URI(System.getenv("jdbc:postgresql://user:12345678@rc1b-tzf902fgo6tak7op.mdb.yandexcloud.net:6432/pionerdb?ssl=true&sslmode=require"));

    //final response = await http.get(url);

    final uri1 = Uri.parse(
        'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/c9qrdr73am2rvah0kq5q/databases/pionerdb');
    var res = await http.get(
      uri1,
      headers: {
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    print('Status code: ${res.statusCode}');
    print('Headers: ${res.headers}');
    print('Body: ${res.body}');
    final results = [jsonDecode(res.body)];
    _data = res.body;

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(top: 15),
          child: Column(children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 25)),
            Container(
              child: Column(
                  children: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          getData();
                        },
                        child: Text("Get Data"),
                      ),
                    ),
                    Text("$_data"),
                Padding(padding: EdgeInsets.only(top: 300)),

              ]),
            ),
          ])),
      backgroundColor: Colors.grey,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Административная панель"),
      ),
      body: Container(
        color: Colors.greenAccent,
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  getData();
                },
                child: Text("Get Data"),
              ),
            ),
            Text("$_data"),
          ],
        ),
      ),
    );
  }
}