import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:ecarihesap/api/Api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'alacakOlustur.dart';
import 'borcOlustur.dart';
import 'gelirOlustur.dart';
import 'giderolustur.dart';
import 'package:http/http.dart' as http;

class KullaniciBilgileri extends StatefulWidget {
  KullaniciBilgileri({
    Key key,
  }) : super(key: key);

  @override
  _KullaniciBilgileriState createState() => _KullaniciBilgileriState();
}

class _KullaniciBilgileriState extends State<KullaniciBilgileri> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var api = new Api();
  var response;
  var name = new TextEditingController(text: '');
  var email = new TextEditingController(text: '');
  var phone = new TextEditingController(text: '');
  var alertSuccessVisible = false;
  var alertErrorVisible = false;
  var errorMessage = "";
  
  initState() {
    super.initState();
    this.get();
  }

  get() async {
    await api.get("/user").then((res) async {
      response = jsonDecode(res.body);
      name.text = response["user"]["name"];
      phone.text = response["user"]["phone"];
      email.text = response["user"]["email"];
     
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: acikPembe,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                buildAppBar(),
                alertSuccessVisible ? alertGreen() : Container(),
                alertErrorVisible ? alertRed() : Container(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 50),
                  child: Container(
                    decoration: BoxDecoration(color:Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: acikPembe, width: 2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kullanıcı Bilgileri",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Ad Soyad *",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                controller: name,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 16),
                                  hintText: "",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: Colors.black54, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade100, width: 2),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Telefon *",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                controller: phone,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 16),
                                  hintText: "",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: Colors.black54, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade100, width: 2),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "E-mail Adresi *",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                controller: email,
                                // obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 16),
                                  hintText: "",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: Colors.black54, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade100, width: 2),
                                  ),
                                )),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                Container(
                                  width: 150,
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () {
                                      api.put("/profile/update-user", {
                                        "name": name.text,
                                        "phone": phone.text,
                                        "email": email.text,
                                      }).then((res) {
                                        print(res.body);
                                        var response = jsonDecode(res.body);
                                        if (res.statusCode == 200) {
                                          setState(() {
                                            alertSuccessVisible = true;
                                          });
                                        } else {
                                          setState(() {
                                            alertErrorVisible = true;
                                            errorMessage = response.message;
                                          });
                                        }
                                      });
                                    },
                                    child: Text(
                                      "Ayarları Kaydet",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Color(0xff7F3DFF),
                                      primary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  alertGreen() {
    return Container(
      height: 30,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.green.shade200),
      child: Text(
        "Başarıyla kaydedildi",
        style: TextStyle(color: Colors.green.shade700),
      ),
    );
  }
    alertRed() {
    return Container(
      height: 30,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.red.shade200),
      child: Text(
        errorMessage,
        style: TextStyle(color: Colors.red.shade700),
      ),
    );
  }

  void _bottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        context: context,
        builder: (BuildContext c) {
          Size size = MediaQuery.of(context).size;
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Container(
                    width: 40,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Color(0xffD3BDFF),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gelir-Gider",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          FlatButton(
                              padding: EdgeInsets.all(10),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GelirOlustur()),
                                );
                              },
                              highlightColor: Color(0xffEEE5FF),
                              child: Text(
                                "Gelirler",
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff0D0E0F)),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  side: BorderSide(
                                      color: Color(0xffE3E5E5), width: 1))),
                          SizedBox(
                            width: 10,
                          ),
                          FlatButton(
                              padding: EdgeInsets.all(10),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GiderOlustur()),
                                );
                              },
                              highlightColor: Color(0xffEEE5FF),
                              child: Text(
                                "Giderler",
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff0D0E0F)),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  side: BorderSide(
                                      color: Color(0xffE3E5E5), width: 1))),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Cari",
                        style: GoogleFonts.inter(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          FlatButton(
                              padding: EdgeInsets.all(10),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BorcOlustur()),
                                );
                              },
                              highlightColor: Color(0xffEEE5FF),
                              child: Text("Borçlar",
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff0D0E0F))),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  side: BorderSide(
                                      color: Color(0xffE3E5E5), width: 1))),
                          SizedBox(
                            width: 10,
                          ),
                          FlatButton(
                              padding: EdgeInsets.all(10),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AlacakOlustur()),
                                );
                              },
                              highlightColor: Color(0xffEEE5FF),
                              child: Text("Alacaklar",
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff0D0E0F))),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  side: BorderSide(
                                      color: Color(0xffE3E5E5), width: 1))),
                        ],
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  buildAppBar() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Cari Hesap",
              style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: SvgPicture.asset("assets/menu.svg"),
                onPressed: () {
                  _bottomSheet(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
