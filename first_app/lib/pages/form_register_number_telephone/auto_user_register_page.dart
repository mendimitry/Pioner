import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/pages/form_chooising_service/choosing_service.dart';

import 'package:first_app/pages/form_login_page/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:get/get_core/src/get_main.dart';

import '../form_organization/privacy_policy.dart';
import '../form_routing/main.dart';
import '../otp.dart';

class AutoUserRegister extends StatefulWidget {
  const AutoUserRegister({Key? key, required Object value}) : super(key: key);

  @override
  State<AutoUserRegister> createState() => _MyPhoneState();
}

bool rememberMe = false;

class _MyPhoneState extends State<AutoUserRegister> {
  TextEditingController countryController = TextEditingController();
  TextEditingController text = TextEditingController();
  final authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  var phone = '';
  var code = '';
  var showPrefix = false.obs;
  var isLogin = true;
  var phoneNo = "".obs;
  var otp = "".obs;
  var isOtpSent = false.obs;
  var resendAfter = 30.obs;
  var resendOTP = false.obs;
  var firebaseVerificationId = "";
  var statusMessage = "".obs;
  var statusMessageColor = Colors.black.obs;
  bool value = false;
  bool buttonCheck = false;
  var timer;
  final scaffoldKey = GlobalKey();

  int _otpCodeLength = 6;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController textEditingController =
      new TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 15),
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
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChoosingSerice()));
                        },
                        icon: Icon(Icons.logout))
                  ]),
              Padding(padding: EdgeInsets.only(top: 25)),
              Container(
                  constraints: BoxConstraints.tightFor(width: 325, height: 600),
                  color: const Color.fromRGBO(255, 228, 225, 0.6),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 15)),
                      Text('Регистрация',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Text(
                        'Номер телефона',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 20),
                      ),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      TextField(
                          onChanged: (value) {
                            phone = value;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '+7 (900) 000 00 00',
                              fillColor: Colors.black12,
                              filled: true,
                              contentPadding: EdgeInsets.only(
                                  top: 5, right: 20, left: 20))),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Text('SMS-код',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 20)),
                      Padding(padding: EdgeInsets.only(top: 5)),
                      TextField(
                        onChanged: (value) {
                          code = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '999999',
                          fillColor: Colors.black12,
                          filled: true,
                          contentPadding:
                              EdgeInsets.only(top: 5, right: 20, left: 20),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 50)),
                      Row(
                        children: [
                          Checkbox(
                              value: value,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  value = newValue!;
                                  buttonCheck = value;
                                });
                              }),
                          Flexible(
                              child: RichText(
                            text: TextSpan(
                                text: 'Принимаю условия ',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'политики конфиденциальности',
                                      style: const TextStyle(
                                          color: Colors.blueAccent,
                                          decoration: TextDecoration.underline),
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PrivacyPolicy()));
                                        })
                                ]),
                          )),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 75)),
                      ElevatedButton(
                          onPressed: buttonCheck
                              ? () async {
                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                    phoneNumber: '${phone}',
                                    timeout: const Duration(seconds: 20),
                                    verificationCompleted:
                                        (PhoneAuthCredential credential) {},
                                    verificationFailed:
                                        (FirebaseAuthException e) {},
                                    codeSent: (String verificationId,
                                        int? resendToken) {
                                      firebaseVerificationId = verificationId;
                                      isOtpSent.value = true;
                                      statusMessage.value =
                                          "OTP sent to +7" + phone;
                                    },
                                    codeAutoRetrievalTimeout: (timeout) {},
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black26,
                              fixedSize: Size(300, 50)),
                          child: Text('Получить код',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                              textAlign: TextAlign.center)),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            statusMessage.value = "Verifying... " + code;
                            // Create a PhoneAuthCredential with the code
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                                    verificationId: firebaseVerificationId,
                                    smsCode: code);
                            // Sign the user in (or link) with the credential
                            await auth.signInWithCredential(credential);
                            Navigator.pushNamed(context, 'choosing_service',
                                arguments: firebaseVerificationId);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black26,
                              fixedSize: Size(300, 50)),
                          child: Text('Verification Test',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                              textAlign: TextAlign.center))
                    ],
                  ))
            ])),
      ),
      backgroundColor: Colors.grey,
    );
  }
}