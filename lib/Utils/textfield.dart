import 'package:book_app/View/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class textfield extends StatelessWidget {
  TextEditingController controller;
  final String hinttext;
  //final String colName;

  textfield(
      {required this.controller,
      required this.hinttext,
      //required this.colName
      });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.robotoSerif(color: Colors.white),
      decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: GoogleFonts.robotoSerif(color: Colors.white),
          fillColor: Color.fromRGBO(203, 240, 255, 0.37),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      // onChanged: (value) async {
      //   debugPrint(colName);
      //   debugPrint(controller.toString());
      //   final user = supabase.auth.currentUser!;
      //   final userId = user.id;
      //   await supabase
      //       .from('userid_table')
      //       .update({colName: controller.text}).eq("user_id", userId);
      // },
    );
  }
}
