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