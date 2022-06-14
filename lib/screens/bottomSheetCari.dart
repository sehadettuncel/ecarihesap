import 'package:ecarihesap/screens/giderolustur.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'gelirOlustur.dart';

class BottomSheet extends StatefulWidget {
  const BottomSheet({Key  key}) : super(key: key);

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {

  void bottomSheet(context) {
    showModalBottomSheet(backgroundColor: Colors.white,shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topRight:Radius.circular(24), topLeft:Radius.circular(24)),


    ),
        context: context,
        builder: (BuildContext c) {
          Size size = MediaQuery.of(context).size;
          return Container(

            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Text("Kayıt oluştur", style: GoogleFonts.inter(fontSize: 16, fontWeight:FontWeight.w600),),
                  SizedBox(height: 20,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Gelir-Gider", style: GoogleFonts.inter(fontSize: 16, fontWeight:FontWeight.w600, ),),
                      SizedBox(height: 10,),
                      Row(

                        children: [
                          FlatButton(padding: EdgeInsets.all(10),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>GelirOlustur()),);
                              },  highlightColor: Color(0xffEEE5FF) ,
                              child: Text("Gelir",style: GoogleFonts.inter(fontSize: 14, fontWeight:FontWeight.w500, color:Color(0xff0D0E0F)), ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  side: BorderSide(
                                      color: Color(0xffE3E5E5), width: 1))),
                          SizedBox(width: 10,),
                          FlatButton(padding: EdgeInsets.all(10),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>GiderOlustur()),);
                              },  highlightColor: Color(0xffEEE5FF) ,
                              child: Text("Gider", style: GoogleFonts.inter(fontSize: 14, fontWeight:FontWeight.w500,color:Color(0xff0D0E0F)), ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  side: BorderSide(
                                      color: Color(0xffE3E5E5), width: 1))),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Text("Cari",style: GoogleFonts.inter(fontSize: 16, fontWeight:FontWeight.w600),),
                      SizedBox(height: 10,),
                      Row(

                        children: [
                          FlatButton(padding: EdgeInsets.all(10),
                              onPressed: () {},  highlightColor: Color(0xffEEE5FF) ,

                              child: Text("Borç", style: GoogleFonts.inter(fontSize: 14, fontWeight:FontWeight.w600, color:Color(0xff0D0E0F))),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  side: BorderSide(
                                      color: Color(0xffE3E5E5), width: 1))),
                          SizedBox(width: 10,),
                          FlatButton(padding: EdgeInsets.all(10),
                              onPressed: () {},  highlightColor: Color(0xffEEE5FF) ,
                              child: Text("Alacak", style: GoogleFonts.inter(fontSize: 14, fontWeight:FontWeight.w600, color:Color(0xff0D0E0F)) ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  side: BorderSide(
                                      color: Color(0xffE3E5E5), width: 1))),

                        ],
                      ),
                      SizedBox(height: 10,),
                      Text("Diğer",style: GoogleFonts.inter(fontSize: 16, fontWeight:FontWeight.bold),),
                      SizedBox(height: 10,),
                      Row(

                        children: [
                          FlatButton(padding: EdgeInsets.all(15),
                              onPressed: () {},  highlightColor: Color(0xffEEE5FF) ,
                              child: Text("Müşteri Kaydı", style: GoogleFonts.inter(fontSize: 14, fontWeight:FontWeight.w600, color:Color(0xff0D0E0F)) ),
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


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



