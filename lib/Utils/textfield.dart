import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class textfield extends StatelessWidget {
  TextEditingController controller;
  final String hinttext;
  //final String colName;

  textfield({
    required this.controller,
    required this.hinttext,
    //required this.colName
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.robotoSerif(color: Colors.white),
      decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: GoogleFonts.robotoSerif(color: Colors.white),
          fillColor: const Color.fromRGBO(203, 240, 255, 0.37),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      validator: (value) {
        if (value!.isEmpty) {
          return "Enter $hinttext";
        }
        return null;
      },
    );
  }
}
