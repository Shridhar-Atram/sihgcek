import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class TextHelper {
  static Widget textWithColorSize(String text , double size , Color color ,
      {FontWeight fontWeight = FontWeight.w300}) {
    return Text(
      text,
      overflow: TextOverflow.clip,
      style:  GoogleFonts.montserrat(
        textStyle: TextStyle(color: color,fontSize: size , fontWeight: fontWeight)
      ),
    );
  }
}
