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

class AlacakOlustur extends StatefulWidget {
  const AlacakOlustur({Key key}) : super(key: key);

  @override
  _AlacakOlusturState createState() => _AlacakOlusturState();
}

class _AlacakOlusturState extends State<AlacakOlustur> {
  var api = new Api();
  var loaded = false;
  var response;

  double totalTax = 0;
  double totalPrice = 0;

  var faturaNo = new TextEditingController(text: '');

  var categoryId;
  var clientId;
  var servicesList = [
    {
      'service_id': new TextEditingController(text: null),
      'price': new TextEditingController(text: '0'),
      'tax': new TextEditingController(text: '0'),
      'discount': new TextEditingController(text: '0'),
      'piece': new TextEditingController(text: '0'),
    }
  ];

  initState() {
    super.initState();
    this.get();
  }

  get() async {
    api.get("/incomes/create").then((res) async {
      setState(() {
        response = jsonDecode(res.body);
        servicesList[0]['service_id'].text = response['services'][0]['id'];
        loaded = true;
      });
    });
  }

  DateTime _dateTimeLast, _dateTimeFirst;

  String getFirstText() {
    if (_dateTimeFirst == null) {
      return "";
    } else {
      return '${_dateTimeFirst.year}-${_dateTimeFirst.month}-${_dateTimeFirst.day}';
    }
  }

  String getLastText() {
    if (_dateTimeLast == null) {
      return "";
    } else {
      return '${_dateTimeLast.year}-${_dateTimeLast.month}-${_dateTimeLast.day}';
    }
  }

  submit() async {
    var servicesData = [];
    for (var i = 0; i < servicesList.length; i++) {
      servicesData.add({
        'service_id': servicesList[i]['service_id'].text,
        'price': servicesList[i]['price'].text,
        'piece': servicesList[i]['piece'].text,
        'discount': servicesList[i]['discount'].text,
        'tax': servicesList[i]['tax'].text,
      });
    }
    var data = {
      'invoice_number': faturaNo.text,
      'client_id': clientId,
      'category_id': categoryId,
      'services': servicesData,
      'first_payment_date': getFirstText(),
      'last_payment_date': getLastText(),
    };
    //print(data);

    var res = await api.post('/credits', data);

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

  calculatePrices() {
    double inBlockTax = 0;
    double inBlockPrice = 0;
    for (var i = 0; i < servicesList.length; i++) {
      var price = double.parse(servicesList[i]['price'].text.length > 0
          ? servicesList[i]['price'].text
          : '0');
      var piece = double.parse(servicesList[i]['piece'].text.length > 0
          ? servicesList[i]['piece'].text
          : '0');
      var discount = double.parse(servicesList[i]['discount'].text.length > 0
          ? servicesList[i]['discount'].text
          : '0');
      var tax = double.parse(servicesList[i]['tax'].text.length > 0
          ? servicesList[i]['tax'].text
          : '0');

      var realPrice = piece * (price - discount);

      inBlockTax += (realPrice * tax) / 100;
      inBlockPrice += realPrice;
    }

    setState(() {
      totalTax = inBlockTax;
      totalPrice = inBlockPrice + inBlockTax;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
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
                  child: Text("Alacak Kaydı Oluştur",
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
                        Text(
                          "Detaylar",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Fatura No",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            TextFormField(
                                controller: faturaNo,
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
                                            child: new Text(valueItem["text"],
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          );
                                        }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
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
                                      getFirstText(),
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
                                            _dateTimeFirst = date;
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
                              "Son Ödeme Tarihi*",
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
                                      getLastText(),
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
                                            _dateTimeLast = date;
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
                                            value: "${valueItem["id"]}",
                                            child: Text(valueItem["full_name"],
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          );
                                        }).toList()
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                        Text(
                          "Hizmetler",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: servicesList.length,
                              itemBuilder: (context, index) {
                                return Column(children: [
                                  Text(
                                    "Ürün / Hizmet*",
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                  // SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade200,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: DropdownButton(
                                        icon: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Icon(
                                            Icons.arrow_drop_down,
                                            color: Color(0xff7F3DFF),
                                          ),
                                        ),
                                        iconSize: 36,
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        style: TextStyle(fontSize: 16),
                                        value: servicesList[index]['service_id']
                                            .text,
                                        onChanged: (newValue) {
                                          setState(() {
                                            servicesList[index]['service_id']
                                                .text = newValue;
                                          });
                                        },
                                        items: response == null
                                            ? <DropdownMenuItem<String>>[]
                                                .toList()
                                            : response["services"]
                                                .map<DropdownMenuItem<String>>(
                                                    (valueItem) {
                                                return DropdownMenuItem<String>(
                                                  value: '${valueItem["id"]}',
                                                  child: new Text(
                                                      valueItem["name"],
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                );
                                              }).toList(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      new Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Birim Fiyatı",
                                              style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                                onChanged: (newValue) {
                                                  calculatePrices();
                                                },
                                                controller: servicesList[index]
                                                    ['price'],
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12.0,
                                                          horizontal: 16),
                                                  // hintText: "Birim Fiyatı *",
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    borderSide: BorderSide(
                                                        color: Colors.black54,
                                                        width: 2.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade200,
                                                        width: 1),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      new Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "KDV Oranı *",
                                              style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                                onChanged: (newValue) {
                                                  calculatePrices();
                                                },
                                                controller: servicesList[index]
                                                    ['tax'],
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12.0,
                                                          horizontal: 16),
                                                  //hintText: "KDV Oranı *",
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    borderSide: BorderSide(
                                                        color: Colors.black54,
                                                        width: 2.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade200,
                                                        width: 1),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      new Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "İskonto *",
                                              style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                                onChanged: (newValue) {
                                                  calculatePrices();
                                                },
                                                controller: servicesList[index]
                                                    ['discount'],
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12.0,
                                                          horizontal: 16),
                                                  // hintText: "Birim Fiyatı *",
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    borderSide: BorderSide(
                                                        color: Colors.black54,
                                                        width: 2.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade200,
                                                        width: 1),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      new Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Adet *",
                                              style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                                onChanged: (newValue) {
                                                  calculatePrices();
                                                },
                                                controller: servicesList[index]
                                                    ['piece'],
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 12.0,
                                                          horizontal: 16),
                                                  //hintText: "KDV Oranı *",
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    borderSide: BorderSide(
                                                        color: Colors.black54,
                                                        width: 2.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .grey.shade200,
                                                        width: 1),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    width: 60,
                                    height: 45,
                                    child: FlatButton(
                                      onPressed: () {
                                        setState(() {
                                          servicesList.removeAt(index);
                                        });
                                      },
                                      child: Icon(
                                        Icons.delete_outline,
                                        color: Colors.white,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xffFD3C4A),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                  ),
                                ]);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.grey.shade400,
                              height: 50,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 45,
                                  child: FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        servicesList.add({
                                          'service_id':
                                              new TextEditingController(
                                                  text: response['services'][0]
                                                      ['id']),
                                          'price': new TextEditingController(
                                              text: '0'),
                                          'tax': new TextEditingController(
                                              text: '0'),
                                          'discount': new TextEditingController(
                                              text: '0'),
                                          'piece': new TextEditingController(
                                              text: '0'),
                                        });
                                      });
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Color(0xffFCAC12),
                                      borderRadius: BorderRadius.circular(16)),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    "Toplam KDV: ${totalTax} TL\nToplam Fiyat:${totalPrice} TL",
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18)),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
      //bottomNavigationBar: BottomNavigationBarCari(),
    );
  }
}
