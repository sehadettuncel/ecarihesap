import 'dart:convert';

import 'package:ecarihesap/api/Api.dart';
import 'package:ecarihesap/screens/anasayfa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_format/date_format.dart';

import 'bottomNavigaton.dart';
import 'giderolustur.dart';

class GiderOlustur extends StatefulWidget {
  const GiderOlustur({Key key}) : super(key: key);

  @override
  _GiderOlusturState createState() => _GiderOlusturState();
}

class _GiderOlusturState extends State<GiderOlustur> {
  var api = new Api();
  var loaded = false;
  var response;


  var price= new TextEditingController(text: '');

  var categoryId;
  var clientId;


  initState() {
    super.initState();
    this.get();
  }

  get() async {
    api.get("/expenses").then((res) async {
      setState(() {
        
        response = jsonDecode(res.body);
        loaded = true;
        
        
      });
    });
  }

  DateTime _dateTime;

  String getText() {
    if (_dateTime == null) {
      return "";
    } else {
      return '${_dateTime.year}-${_dateTime.month}-${_dateTime.day}';
    }
  }

  submit() async {
 
    var data = {
      'client_id': clientId,
      'category_id': categoryId,
      "price" : price.text,
      'date': getText(),
    };
    print(data);

    var res = await api.post('/expenses', data);

     if (res.statusCode == 200) {
      print("başarılı");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Anasayfa()),
      );
    }
    setState(() {
      res = jsonDecode(res.body);
    });
    
  }





  @override
  Widget build(BuildContext context) {
    if( !loaded ) {
      return Container();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Cari Hesap",
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Gider Kaydı Oluştur",
                      style: GoogleFonts.inter(fontSize: 16)),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffFCFCFC),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                               Text(
                              "Ödeme Tarihi*",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade200, width: 1),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      getText(),
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16,
                                          color: Color(0xff292B2D)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2001),
                                                lastDate: DateTime(2222))
                                            .then((date) {
                                          setState(() {
                                            _dateTime = date;
                                          });
                                        });
                                      },
                                      child: Icon(
                                        Icons.date_range,
                                        color: Color(0xff7F3DFF),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                           
                        SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Kategori*",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                            // SizedBox(height: 5,),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade200, width: 1),
                                    borderRadius: BorderRadius.circular(16)),
                                child: DropdownButton(
                                  hint: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                  ),
                                  icon: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xff7F3DFF),
                                    ),
                                  ),
                                  iconSize: 36,
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  style: TextStyle(fontSize: 16),
                                  value: categoryId,
                                  onChanged: (newValue) {
                                    setState(() {
                                      categoryId = newValue;
                                    });
                                  },
                                  items: response == null
                                      ? null
                                      : response["categories"]
                                          .map<DropdownMenuItem<String>>(
                                              (valueItem) {
                                          return DropdownMenuItem<String>(
                                            value: "${valueItem["value"]}",
                                            child: new Text(valueItem["text"],style: TextStyle(color: Colors.black)),
                                          );
                                        }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                         
                          SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Müşteri",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                            //SizedBox(height: 5,),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade200, width: 1),
                                    borderRadius: BorderRadius.circular(16)),
                                child: DropdownButton(
                                  icon: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xff7F3DFF),
                                    ),
                                  ),
                                  iconSize: 36,
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  style: TextStyle(fontSize: 16),
                                  value: clientId,
                                  onChanged: (newValue) {
                                    setState(() {
                                      clientId = newValue;
                                    });
                                  },
                                  items: response != null
                                      ? response["clients"]
                                          .map<DropdownMenuItem<String>>(
                                              (valueItem) {
                                          return DropdownMenuItem<String>(
                                            value: "${valueItem["value"]}",
                                            child: Text(valueItem["text"],style: TextStyle(color: Colors.black)),
                                          );
                                        }).toList()
                                      : null,
                                ),
                              ),
                            ),
                                 Text(
                              "Fiyat",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            TextFormField(
                                controller: price,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 16),
                                  // hintText: "Fatura No",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: Colors.black54, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade200, width: 1),
                                  ),
                                )),
                                SizedBox(height: 20,),
                                
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Container(
                            decoration: BoxDecoration(
                                color: Color(0xffB18AFF),
                                borderRadius: BorderRadius.circular(16)),
                            width: 150,
                            height: 50,
                            child: FlatButton(
                              child: Text("Kayıt Oluştur",
                                  style: GoogleFonts.inter(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                submit();
                              },
                            )),
                      ],
                    ),
                    SizedBox(height: 20,),
                 
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
      ),
      //bottomNavigationBar: BottomNavigationBarCari(),
    );
  }
}
