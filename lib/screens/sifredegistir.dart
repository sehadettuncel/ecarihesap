
import 'dart:convert';



import 'package:ecarihesap/api/Api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import 'alacakOlustur.dart';
import 'borcOlustur.dart';
import 'gelirOlustur.dart';
import 'giderolustur.dart';

class SifreDegistir extends StatefulWidget {
  const SifreDegistir({Key key}) : super(key: key);

  @override
  _SifreDegistirState createState() => _SifreDegistirState();
}

class _SifreDegistirState extends State<SifreDegistir> {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var api = new Api();
  var response;
  var password_old = new TextEditingController(text: '');
  var password= new TextEditingController(text: '');
  var password_confirmation= new TextEditingController(text: '');
  var alertSuccessVisible = false;
  var alertErrorVisible = false;
  var errorMessage = "";
  
  initState() {
    super.initState();
  
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: acikPembe,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [

                buildAppBar(),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left:20.0, right: 20.0, top:50),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white,
                      borderRadius:BorderRadius.circular(24), border:Border.all(color:acikPembe, width: 2) ,),


                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(key: _formKey,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("??ifre De??i??tir",style:TextStyle(fontSize: 18, fontWeight: FontWeight.w600 ),),
                            SizedBox(height: 20,),
                            Text("Eski ??ifre",style:TextStyle(fontSize: 18, fontWeight: FontWeight.w400 ),),
                            SizedBox(height: 10,),
                            TextFormField(controller: password_old,
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 16),
                                  hintText: "",
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
                            SizedBox(height: 10,),
                            Text("Yeni ??ifre",style:TextStyle(fontSize: 18, fontWeight: FontWeight.w400 ),),
                            SizedBox(height: 10,),
                            TextFormField(controller: password,
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 16),
                                  hintText: "",
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
                            SizedBox(height: 10,),
                            Text("Yeni ??ifre Tekrar",style:TextStyle(fontSize: 18, fontWeight: FontWeight.w400 ),),
                            SizedBox(height: 10,),
                            TextFormField(controller: password_confirmation,
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 16),
                                  hintText: "",
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
                            SizedBox(height: 30,),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                Container(
                                  width: 200, 

  
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () {
                                             api.post("/profile/change-password", {
                                          "password_old": password_old.text,
                                          "password": password.text,
                                          "password_confirmation": password_confirmation.text,
                                          
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
                                      "??ifreyi G??ncelle",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                style: TextButton.styleFrom(
                                  maximumSize:size,
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
                              child: Text("Bor??lar",
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
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Di??er",
                        style: GoogleFonts.inter(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          FlatButton(
                              padding: EdgeInsets.all(15),
                              onPressed: () {},
                              highlightColor: Color(0xffEEE5FF),
                              child: Text("M????teri Y??netimi",
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

