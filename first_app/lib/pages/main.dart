import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/pages/Choosing_time_service.dart';
import 'package:first_app/pages/TestAdminka.dart';
import 'package:first_app/pages/auto_user_register_page.dart';
import 'package:first_app/pages/choosing_organization_car_wash.dart';
import 'package:first_app/pages/choosing_organization_tire_service.dart';
import 'package:first_app/pages/choosing_service.dart';
import 'package:first_app/pages/composition_services_car_wash.dart';
import 'package:first_app/pages/form_administrator/list_applications.dart';
import 'package:first_app/pages/form_administrator/user_administrator.dart';
import 'package:first_app/pages/form_organization/connecting_organization.dart';
import 'package:first_app/pages/form_organization/organization_register.dart';
import 'package:first_app/pages/form_organization/privacy_policy.dart';
import 'package:first_app/pages/form_organization/user_organization.dart';
import 'package:first_app/pages/record_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:first_app/pages/login_page.dart';
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
        'auto_user_register_page':(context) => const AutoUserRegister(),
        'choosing_organization_car_wash':(context) => const ChoosingOrganizationCarWash(),
        'choosing_organization_tire_service':(context) => const ChoosingOrganizationTireService(),
        'choosing_service':(context) => const ChoosingSerice(),
        'choosing_time_service':(context) => const ChoosingTimeService(),
        'composition_services_car_wash':(context) => const CompositionServicesCarWash(),
        'record_confirmation':(context) => RecordConfirmation(),
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
