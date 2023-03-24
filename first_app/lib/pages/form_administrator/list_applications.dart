import 'package:first_app/models/ConnectionRequest.dart';
import 'package:first_app/pages/form_administrator/user_administrator.dart';
import 'package:first_app/pages/form_chooising_service/choosing_service.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../controllers/ConnectingOrganization.dart';
import '../../data/PionerDBContext.dart';
import '../form_organization/connecting_organization.dart';
import '../form_login_page/login_page.dart';

class ListApplication extends StatefulWidget {
  const ListApplication({super.key});

  @override
  State<ListApplication> createState() => _ListApplication();
}

PionerDB pionerDB = PionerDB();
final TextEditingController regNumberTextController = TextEditingController();
final TextEditingController DateCreateTextController = TextEditingController();
final TextEditingController kratkoeTextController = TextEditingController();


Future<List<ConnectionRequest>> getAllConnectionRequest() async {
  await pionerDB.initDatabaseConnection();

  var query = await pionerDB.dbConnection.mappedResultsQuery('SELECT * from connection_request');
  //Нулевой объект
  ConnectionRequest _connectionRequest;
  List<ConnectionRequest> _conncetionRequests =[];
  for (var element in query) {
    for (var subElement in element.values) {
      _connectionRequest = ConnectionRequest.fromReqBody(subElement);
      _connectionRequest.printAttributes();

      _conncetionRequests.add(_connectionRequest);
    }
  }
  //Закрываем соединение с БД
  await pionerDB.closeDatabaseConnection();

  //Возвращаем всех полученных пользователей
  return _conncetionRequests;
}
Future<List<ConnectionRequest>> usersFuture = getAllConnectionRequest();
var status = [
  "НОВАЯ",
  "В РАБОТЕ",
  "ИСПОЛНЕНА",
  "ОТКЛОНЕНА",
];

var organization1 = [
  "1",
  "08.03.2023",
  "Белый лед",
];
var organization2 = [
  "2",
  "18.01.2023",
  "Ласточка",
];
var organization3 = [
  "3",
  "26.04.2023",
  "Каприз",
];
var mass = [organization1, organization2, organization3];

class _ListApplication extends State<ListApplication> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('d'),
      ),
      body: Container(
        child: FutureBuilder<List<ConnectionRequest>>(
            future: usersFuture,
            builder: (context, snapshot) {
              if(snapshot.connectionState != ConnectionState.done) {
                // return: show loading widget
              }
              if(snapshot.hasError) {
                // return: show error widget
              }
              List<ConnectionRequest> users = snapshot.data ?? [];
              return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    ConnectionRequest user = users[index];
                    return ListTile(

                        leading: CircleAvatar(

                        ),
                        title: new Text(
                    '${user.reg_number}'+"      "+'${user.date_begin}'+"      "+'${user.organization_id}'),
                        onTap: (){

                          Navigator.push(context,
                              new MaterialPageRoute(builder: (context) => ChoosingSerice()
                          )

                          );},



                      // onTap: () {
                      //  Navigator.push(context,
                      //      new MaterialPageRoute(builder: (context) => new ChoosingSerice()));


                    );
                  });
            }),
      ),




              );
            }




  }


  Container list_organization() {
    return Container(
        child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: mass.length,
            itemBuilder: (context, index) {
              var vector = mass[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Table(
                    border: TableBorder(
                        top: BorderSide(width: 1, color: Colors.black)),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(70),
                      1: FixedColumnWidth(100),
                    },
                    children: [
                      TableRow(
                          decoration: BoxDecoration(color: Colors.white),
                          children: [
                            Container(
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    vector[1],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic),
                                  ),
                                )),
                            Container(
                                // color: Colors.white,
                                height: 40,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    vector[1],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic),
                                  ),
                                )),
                            Container(
                                // color: Colors.white,
                                height: 40,
                                child: FutureBuilder<List<ConnectionRequest>>(
                                    future: usersFuture,
                                    builder: (context, snapshot) {
                                      if(snapshot.connectionState != ConnectionState.done) {
                                        // return: show loading widget
                                      }
                                      if(snapshot.hasError) {
                                        // return: show error widget
                                      }
                                      List<ConnectionRequest> users = snapshot.data ?? [];
                                      return ListView.builder(
                                          itemCount: users.length,
                                          itemBuilder: (context, index) {
                                            ConnectionRequest user = users[index];
                                            return Center(
                                                child: new Text(
                                                    '${user.date_begin}')

                                             // onTap: () {
                                              //  Navigator.push(context,
                                              //      new MaterialPageRoute(builder: (context) => new ChoosingSerice()));


                                            );
                                          });
                                    }),
                                ),
                          ])
                    ],
                  ),
                ],
              );
            }));
  }

  Row transition(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Transform.rotate(
              angle: 180 * math.pi / 180,
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  icon: Icon(Icons.logout))),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserAdministrator()));
              },
              icon: Icon(Icons.logout))
        ]);
  }

