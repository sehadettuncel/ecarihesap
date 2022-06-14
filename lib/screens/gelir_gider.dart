import 'dart:convert';

import 'package:ecarihesap/api/Api.dart';
import 'package:ecarihesap/constants.dart';
import 'package:ecarihesap/screens/bottomNavigaton.dart';
import 'package:ecarihesap/widgets/gelir_list_card.dart';
import 'package:ecarihesap/widgets/gider_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'alacakOlustur.dart';
import 'borcOlustur.dart';
import 'gelirOlustur.dart';
import 'giderolustur.dart';

class GelirGider extends StatefulWidget {
  const GelirGider({Key key}) : super(key: key);

  @override
  _GelirGiderState createState() => _GelirGiderState();
}

class _GelirGiderState extends State<GelirGider> {
  final api = new Api();
  var response;
  @override
  void initState() {
    super.initState();
    get();
  }

  get() async {
    api.get('/mobile-incomes').then((res) async {
      setState(() {
        response = jsonDecode(res.body);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF6F6F6),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildAppBar(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Gelir-Gider Kayıtları",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            // scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount:
                                response != null ? response["data"].length : 0,

                            itemBuilder: (context, index) {
                              if (response["data"][index]["type"] == "income") {
                                return gelir_list_card(
                                  price: response["data"][index]["price"],
                                  title: response["data"][index]["title"],
                                  date: response["data"][index]["date"],
                                );
                              } else if (response["data"][index]["type"] ==
                                  "expense") {
                                return gider_list_card(
                                  price: response["data"][index]["price"],
                                  title: response["data"][index]["title"],
                                  date: response["data"][index]["date"],
                                );
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBarCari(
          deger: 1,
        ));
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
                                "Gelir Oluştur",
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
                                "Gider Oluştur",
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
                              child: Text("Borç Oluştur",
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
                              child: Text("Alacak Oluştur",
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
}
