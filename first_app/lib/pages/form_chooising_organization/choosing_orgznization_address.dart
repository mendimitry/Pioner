import 'package:first_app/controllers/ChoosingOrganizationAddress.dart';
import 'package:flutter/material.dart';

import '../form_chooising_service/choosing_service.dart';

import '../form_composition_services_car_wash/composition_services.dart';
import '../form_login_page/login_page.dart';
import 'dart:math' as math;
class ChoosingOrganizationAddress extends StatefulWidget {
  final String serviceValue;
  Map<String, dynamic> resultAddress;
  ChoosingOrganizationAddress({super.key, required this.serviceValue, required this.resultAddress});

  @override
  State<ChoosingOrganizationAddress> createState() => _ChoosingOrganizationAddress();
}


ChoosingOrganizationAddressController _choosingOrganizationAddressController = ChoosingOrganizationAddressController();

class _ChoosingOrganizationAddress extends State<ChoosingOrganizationAddress> {
  String textFlex = 'Введите адрес';
  String cityText = '';
  String addressText = '';
  String nameText = '';
  List<Map<String, dynamic>> findList = [];
  List<String> cityFind = [];
  late Map<String, dynamic> _resultAddress; // ВЫХОДНЫЕ ДАННЫЕ {годод}
  List<Map<String, dynamic>> _listOrganization = [];
  late Map<String, dynamic> _resultOrganization; // {город, адрес, название}
  String _serviceValue = "";

  late Future<List<Map<String,dynamic>>> address;

  @override
  void initState() {
    _resultAddress = widget.resultAddress;
    _serviceValue = widget.serviceValue;
    cityText = widget.resultAddress["city"].toString();
    // TODO: implement initState
    super.initState();
  }

  void _filterValue(String enteredKeyword, List<Map<String, dynamic>> _list) {
    List<Map<String, dynamic>> result = [];
    result = _list
        .where((element) =>
        element["name"]
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase()))
        .toList();
    setState(() {
      findList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    address = _choosingOrganizationAddressController.getAllAddressFromCity(_resultAddress['city']);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Transform.rotate(
                        angle: 180 * math.pi / 180,
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            icon: Icon(Icons.logout))),

                  ]),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         textCity(),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextField(
                        onChanged: (value) =>
                            _filterValue(value, _listOrganization),
                        decoration: InputDecoration(
                            hintText: textFlex, suffixIcon: Icon(Icons.search)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListAdress(),
                    SizedBox(
                      height: 20,
                    ),
                    // buttonBackNext(context)
                  ],
                ),
              ),
            ])),
      ),
      backgroundColor: Colors.grey,
    );
  }

  Container ListAdress() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 470,
        color: Colors.white10,
        child: FutureBuilder<List<Map<String,dynamic>>>(
            future: address,
            builder: (context, snapshot){
              List<Map<String,dynamic>> addresses = snapshot.data ?? [];
              return ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: addresses.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return listInformation(addresses, index);
                  });}));
  }

  Widget listInformation(List<Map<String, dynamic>> _list, int index) {
    return TextButton(
        onPressed: () {
          setState(() {
            nameText = _list[index]["name"].toString();
            addressText = _list[index]["address"].toString();
            print(_resultAddress);
            _resultOrganization = {"city": _resultAddress["city"].toString(), "name": _list[index]["name"].toString(), "address":_list[index]["address"].toString()};
            print(_resultOrganization); // _resultAddress нужно передать в push
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CompositionServices(resultAddress: _resultOrganization, serviceValue: _serviceValue))); // ПЕРЕХОД НА СЛЕД. ФОРМУ
          });
        },
        child: Align(
            alignment: Alignment.bottomLeft,
            child: ListTile(
                title: Text(
                  _list[index]["name"].toString(), // НАЗВАНИЕ ОРГАНИЗАЦИИ
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Text(
                  _list[index]["address"].toString(), // АДРЕС ОРГАНИЗАЦИИ
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontStyle: FontStyle.italic),
                )
            )));
  }
  Row textCity() {
    return Row(
      children: [
        Text(
          "$cityText",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  }
