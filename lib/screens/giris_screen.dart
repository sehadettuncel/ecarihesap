
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


import 'package:ecarihesap/screens/signIn.dart';

import 'package:http/http.dart' as http;

import 'anasayfa.dart';

class GirisScreen extends StatelessWidget {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();

  var access_token;
  String email2;
  String password2;




  GirisScreen({Key  key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Form(
                key: globalFormKey,

                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text("Giriş Yap",
                          style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                          onSaved: (value) {
                            email2 = value;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16),
                            hintText: "E-mail",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                              BorderSide(color: Colors.black54, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                              BorderSide(color: Colors.grey.shade100, width: 2),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextFormField(
                          onSaved: (value) {
                            password2 = value;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16),
                            hintText: "Şifre",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                              BorderSide(color: Colors.black54, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                              BorderSide(color: Colors.grey.shade100, width: 2),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: 380,
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          validateAndSave();

                          var accessToken = await postIslemi();
                          if(accessToken.length > 0) {
                            final data = await SharedPreferences.getInstance();
                            data.setString('access_token', accessToken);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Anasayfa()));
                          }

                        },
                        child: Text(
                          "Giriş Yap",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xff7F3DFF),
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    
                 ],
                ),
              ),
            ),
          ),
        ));
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  postIslemi() async {
    Uri request = Uri.parse("https://api.ecarihesap.com/api/login") ;
    var response = await http.post(
      request,
      body: {
        'email': email2,
        'password': password2,
      }
    );
    if(response.statusCode == 200) {
      return jsonDecode(response.body) ['access_token'];
    } return "";
  }

}
