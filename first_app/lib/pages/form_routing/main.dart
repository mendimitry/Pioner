import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/pages/form_chooising_time/Choosing_time_service.dart';
import 'package:first_app/pages/TestAdminka.dart';
import 'package:first_app/pages/form_register_number_telephone/auto_user_register_page.dart';


import 'package:first_app/pages/form_chooising_service/choosing_service.dart';

import 'package:first_app/pages/form_administrator/list_applications.dart';
import 'package:first_app/pages/form_administrator/user_administrator.dart';
import 'package:first_app/pages/form_organization/connecting_organization.dart';
import 'package:first_app/pages/form_organization/organization_register.dart';
import 'package:first_app/pages/form_organization/privacy_policy.dart';
import 'package:first_app/pages/form_organization/user_organization.dart';
import 'package:first_app/pages/form_end/record_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:first_app/pages/form_login_page/login_page.dart';

import '../form_chooising_organization/choosing_organization.dart';
import '../form_composition_services_car_wash/composition_services.dart';
void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pioneer',
      initialRoute: 'LoginPage',
      routes: {
        'user_organization':(context) => const UserOrganization(),
        'list_applications':(context) => const ListApplication(),
        'connecting_organization':(context) => const ConnectingOrganization(),
        'privacy_policy':(context) => const PrivacyPolicy(),
        'auto_user_register_page':(context) => const AutoUserRegister(value: "",),
        'choosing_organization_car_wash':(context) => const ChoosingOrganization(serviceValue: '',),
        'choosing_service':(context) => const ChoosingServices(),
        'choosing_time_service':(context) => ChoosingTimeService(listServiceResult: [], resultAddress: [], serviceValue: '', resultValue: 0),
        'composition_services_car_wash':(context) => CompositionServices(resultAddress: [], serviceValue: '',),
        'record_confirmation':(context) => RecordConfirmation(listService: [], resultAddress: [], serviceValue: '', resultTime: '', days: '',),
        'TestAdminka':(context) => const TestAdminka(),
        'login_page':(context) => LoginPage(),
        'organization_register':(context) => OrganizationRegister(),
        'user_administrator':(context) => UserAdministrator()
      },
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: LoginPage(),
    );
  }
}
