import 'dart:convert';

import 'package:ecarihesap/api/Api.dart';
import 'package:ecarihesap/constants.dart';
import 'package:ecarihesap/screens/bottomNavigaton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'alacakOlustur.dart';
import 'borcOlustur.dart';
import 'gelirOlustur.dart';
import 'giderolustur.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key key}) : super(key: key);

  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  final api = new Api();
  var response;
  var dailyIncome = '0';
  var dailyExpense = '0';
  var weeklyIncome = '0';
  var weeklyExpense = '0';

  @override
  void initState() {
    super.initState();
    this.initialAction();
    get();
  }

  get() async {
    var res = await api.get('/mobile-dashboard');
    setState(() {
      response = jsonDecode(res.body);
      dailyIncome = response['daily_income'];
      dailyExpense = response['daily_expense'];
      weeklyIncome = response['weekly_income'];
      weeklyExpense = response['weekly_expense'];
    });
  }

  initialAction() async {
    // SharedPreferences.setMockInitialValues({});
    var data = await SharedPreferences.getInstance();
    var accessToken = data.getString('access_token') ?? false;
    //print(accessToken);
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAppBar(),
               
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: gunvehafta("Bugün"),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Color(0xffFCFCFC),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/gelir.svg"),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    gelirgiderkar("Gelir"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    gunlukHaftalik("Günlük Gelir"),
                                  ],
                                ),
                              ],
                            ),
                            buildSayi(double.parse(dailyIncome), koyuYesil),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //-----------------------Gider Card
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Color(0xffFCFCFC),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/redcar.svg"),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    gelirgiderkar("Gider"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    gunlukHaftalik("Günlük Gider"),
                                  ],
                                ),
                              ],
                            ),
                            buildSayi(
                                double.parse(dailyExpense), Color(0XFFFD3C4A)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //-----------------------Kar Card
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Color(0xffFCFCFC),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/gider.svg"),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    gelirgiderkar(
                                      "Kar",
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    gunlukHaftalik("Günlük Kar"),
                                  ],
                                ),
                              ],
                            ),
                            buildSayi(
                                double.parse(dailyIncome) -
                                    double.parse(dailyExpense),
                                Color(0XFFFCAC12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: gunvehafta("Bu hafta"),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Color(0xffFCFCFC),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/gelir.svg"),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    gelirgiderkar(
                                      "Gelir",
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    gunlukHaftalik(
                                      "Haftalık Gelir",
                                    )
                                  ],
                                ),
                              ],
                            ),
                            buildSayi(
                              double.parse(weeklyIncome),
                              Color(0xff00A86B),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //-----------------------Gider Card
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Color(0xffFCFCFC),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/redcar.svg"),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    gelirgiderkar("Gider"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    gunlukHaftalik(
                                      "Haftalık Gider",
                                    )
                                  ],
                                ),
                              ],
                            ),
                            buildSayi(
                                double.parse(weeklyExpense), Color(0XFFFD3C4A)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //-----------------------Kar Card
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Color(0xffFCFCFC),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/gider.svg"),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    gelirgiderkar(
                                      "Kar",
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    gunlukHaftalik(
                                      "Haftalık Kar",
                                    )
                                  ],
                                ),
                              ],
                            ),
                            buildSayi(
                                double.parse(weeklyIncome) -
                                    double.parse(weeklyExpense),
                                Color(0XFFFCAC12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCari(
        deger: 0,
      ),
    );
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

  Text gunvehafta(String gunvehafta) {
    return Text(
      gunvehafta,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }

  Text buildSayi(double sayi, Color color) {
    return Text(
      "$sayi",
      style: GoogleFonts.inter(
          color: color, fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Text gelirgiderkar(
    String gelir_gider_kar,
  ) {
    return Text(
      gelir_gider_kar,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Text gunlukHaftalik(
    String gunluk_haftalik,
  ) {
    return Text(
      gunluk_haftalik,
      style: GoogleFonts.inter(fontSize: 12, color: Colors.grey.shade600),
    );
  }
}
