/*
  This class is to ensure all the pages designs are synchronized
  and consistent
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class KoroboriComponent {
  Color getPrimaryColor() {
    return const Color(0xFF010066);
  }

  TextStyle getTextStyle(
      {Color? color,
      double fontSize = 16,
      FontWeight? fontWeight,
      FontStyle? style,
      double? height,
      TextDecoration? decoration}) {
    return GoogleFonts.poppins(
        decoration: decoration,
        textStyle: TextStyle(
            fontStyle: style,
            height: height,
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight));
  }

  PreferredSize buildAppBar(String title) {
    return PreferredSize(
      preferredSize: Size.fromHeight(75),
      child: Container(
        color: getPrimaryColor(),
        child: Center(
          child: Text(
            title,
            style: getTextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget buildInput(TextEditingController controller,
      {Icon? prefixIcon,
      String? hintText,
      List<TextInputFormatter>? formats,
      bool isObscure = false,
      IconButton? suffixIconButton,
      double width = 1,
      List<BoxShadow>? shadows}) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: shadows,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: width, color: const Color(0xFF9397A0)),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: TextFormField(
        controller: controller,
        inputFormatters: formats,
        obscureText: isObscure,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIconButton,
            hintStyle: getTextStyle(color: Colors.black.withOpacity(0.25)),
            hintText: hintText),
      ),
    );
  }

  Widget buildOutlinedButton(Text title, void Function() onPressed) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Container(
          height: 50,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 3, color: Color(0xFFFFC600)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Center(
            child: title,
          ),
        ),
      ),
    );
  }
}
