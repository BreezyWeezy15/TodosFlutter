import 'dart:ui';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getBoldFont(){
  return GoogleFonts.poppins(
    fontWeight : FontWeight.bold
  );
}
TextStyle getMedFont(){
  return GoogleFonts.poppins(
      fontWeight : FontWeight.w500
  );
}
TextStyle getNormalFont(){
  return GoogleFonts.poppins(
      fontWeight : FontWeight.normal
  );
}

hexStringToHexInt(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff$hex' : hex;
  int val = int.parse(hex, radix: 16);
  return val;
}