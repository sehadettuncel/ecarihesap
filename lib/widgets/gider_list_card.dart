import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class gider_list_card extends StatefulWidget {
   final title;
   final price;
   final date;
  const gider_list_card({
    Key key, this.title, this.price, this.date,
  }) : super(key: key);

  @override
  State<gider_list_card> createState() => _gider_list_cardState();
}

class _gider_list_cardState extends State<gider_list_card> {
  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Text(
                        widget.date,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        widget.title,
                        style: GoogleFonts.inter(fontSize: 12, color: Colors.grey.shade600),
                      )
                    ],
                  ),
                ],
              ),
              Text(
                "${widget.price} TL",
                style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffFD3C4A)),
              ),
            ],
          ),
          Divider(height: 20,)
        ],
      ),
    );
  }
}

