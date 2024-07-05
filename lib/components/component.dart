/*
  This class is to ensure all the pages designs are synchronized
  and consistent
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
      double? letterSpacing,
      double? height,
      TextDecoration? decoration,
      TextAlignVertical? textAlignVertical,
      FontStyle? fontStyle,
      // ignore: non_constant_identifier_names
      TextAlign? textAlign}) {
    return GoogleFonts.poppins(
      decoration: decoration,
      textStyle: TextStyle(
          fontStyle: style,
          height: height,
          letterSpacing: letterSpacing,
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }

  PreferredSize buildAppBar(String title) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(75),
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

  PreferredSize buildAppBarWithBackbutton(String title, BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(75),
      child: Container(
        color: getPrimaryColor(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              width: 30,
            ),
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 25,
                    color: getPrimaryColor(),
                  )),
            ),
            const SizedBox(
              width: 25,
            ),
            Container(
              child: Center(
                child: Text(
                  title,
                  style: getTextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInput(TextEditingController controller,
      {Icon? prefixIcon,
      String? hintText,
      List<TextInputFormatter>? formats,
      TextInputType? keyboardType,
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
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          inputFormatters: formats,
          keyboardType: keyboardType,
          obscureText: isObscure,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIconButton,
            hintStyle: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                style: FontStyle.italic,
                color: Colors.black.withOpacity(0.20)),
            hintText: hintText,
          ),
        ));
  }

  Widget greyButton(String text, void Function() onPressed) {
    return TextButton(
        onPressed: onPressed,
        child: Container(
          width: 100,
          height: 35,
          decoration: ShapeDecoration(
            color: const Color(0xFFD9D9D9),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 2,
                offset: Offset(0, 1),
                spreadRadius: 0,
              )
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: getTextStyle(
                  fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        ));
  }

  Widget blueButton(String text, void Function() onPressed) {
    return TextButton(
        onPressed: onPressed,
        child: Container(
          width: 100,
          height: 35,
          decoration: ShapeDecoration(
            color: Color(0xFF002B7F),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 2,
                offset: Offset(0, 1),
                spreadRadius: 0,
              )
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: getTextStyle(
                  fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        ));
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
              side: const BorderSide(width: 3, color: Color(0xFFFFC600)),
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
