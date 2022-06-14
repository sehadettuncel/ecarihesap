import 'package:ecarihesap/constants.dart';
import 'package:ecarihesap/screens/firmaBilgileri.dart';
import 'package:ecarihesap/screens/giris_screen.dart';
import 'package:ecarihesap/screens/sifredegistir.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottomNavigaton.dart';
import 'kullaniciBilgileri.dart';


class Profilim extends StatefulWidget {



  const Profilim({Key key}) : super(key: key);

  @override
  _ProfilimState createState() => _ProfilimState();
}

class _ProfilimState extends State<Profilim> {
  initState() {
    super.initState();
  }

  logout() async {
    // SharedPreferences.setMockInitialValues({});
    var data = await SharedPreferences.getInstance();
    data.remove('access_token');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:acikPembe,
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, right: 20, left: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          child:  CircleAvatar(
                            radius: 55,
                            backgroundColor: Color(0xff7F3DFF),
                            child: CircleAvatar(  radius: 52, backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 47,
                                backgroundImage: AssetImage('assets/sehadet.jpg'),
                              ),
                            ),
                          ),),
                      SizedBox(
                        width: 10,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kullanıcı Adı",
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff91919F)),

                          ),
                          SizedBox(height: 7,),

                          Text("Şehadet Tunçel",
                              style: GoogleFonts.inter(
                                  fontSize: 24, fontWeight: FontWeight.w600)),
                        ],
                      )
                    ],
                  ),
                  SvgPicture.asset("assets/pencil.svg"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/profilicon.png"),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context,  MaterialPageRoute(builder: (context) => KullaniciBilgileri()),);
                              },
                              child: Text(
                                "Kullanıcı Bilgileri",
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff292B2D)),
                              )),
                        ],
                      ),
                      Divider(
                        color: Color(0xffF6F6F6),
                        height: 30,
                      ),
                      Row(
                        children: [
                          Image.asset("assets/firmaicon.png"),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context,  MaterialPageRoute(builder: (context) => FirmaBilgileri()),);
                              },
                              child: Text(
                                "Firma Bilgileri",
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff292B2D)),
                              )),
                        ],
                      ),
                      Divider(
                        color: Color(0xffF6F6F6),
                        height: 30,
                      ),
                      Row(
                        children: [
                          Image.asset("assets/sifredegistir.png"),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(context,  MaterialPageRoute(builder: (context) => SifreDegistir()),);
                              },
                              child: Text(
                                "Şifreyi Değiştir",
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff292B2D)),
                              )),
                        ],
                      ),
                      Divider(
                        color: Color(0xffF6F6F6),
                        height: 30,
                      ),
                      Row(
                        children: [
                          Image.asset("assets/logout.png"),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                logout();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => GirisScreen()),
                                );
                              },
                              child: Text(
                                "Çıkış Yap",
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff292B2D)),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCari(deger:3,),
    );
  }
}


