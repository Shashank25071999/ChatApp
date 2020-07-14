import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appBarMain(BuildContext context,String title){
  return  AppBar(
        backgroundColor: Color(0xff1f1f1f),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Admin Conversation',
            style: GoogleFonts.aBeeZee(
                color: Colors.white,
                
                ),
          ),
        ));
}