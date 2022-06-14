import 'package:ecarihesap/screens/anasayfa.dart';
import 'package:ecarihesap/screens/borcAlacak.dart';
import 'package:ecarihesap/screens/profilim.dart';
import 'package:flutter/material.dart';

import 'gelir_gider.dart';

class BottomNavigationBarCari extends StatefulWidget {
    int deger;

   BottomNavigationBarCari({Key key, this.deger})
      : super(
          key: key,
        );

  @override
  _BottomNavigationBarCariState createState() =>
      _BottomNavigationBarCariState();
}

class _BottomNavigationBarCariState extends State<BottomNavigationBarCari> {



  @override
  Widget build(BuildContext context) {
    //print(widget.deger);
    return Container(
      child: BottomNavigationBar(
        onTap: (index) {
         widget.deger=index;
          setState(() {

            if (widget.deger == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Anasayfa()),
              );
            } else if (widget.deger == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profilim()),
              );
            }
            else if (widget.deger == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GelirGider()),
              );}
            else if (widget.deger == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BorcAlacak()),
              );}
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Color(0xffFCFCFC),
            icon: Icon(Icons.home),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Gelir-Gider',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outlined),
            label: 'Borç-Alınacak',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profilim',
          ),
        ],
        currentIndex: widget.deger,
        selectedItemColor: Color(0xff7F3DFF),
        unselectedItemColor: Color(0xffC6C6C6),
      ),
    );
  }
}
