import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chatApp/admin/listadmin.dart';

class Chatting extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Chatting();
  }
  
}
class _Chatting extends State <Chatting>{
  void MoveToLastScreen(){
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => ChatAd()),
        (Route<dynamic> route) => false);        
  }
 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        MoveToLastScreen();
      },
          child: Scaffold(
        backgroundColor: Color(0xff1f1f1f),
        appBar:  AppBar(backgroundColor: Color(0xff1f1f1f),
         leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){  Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => ChatAd()),
        (Route<dynamic> route) => false);},),
          title: Text('CHAT',style: GoogleFonts.aBeeZee(color:Colors.cyanAccent[200],fontWeight: FontWeight.bold,fontSize: 20),),
          centerTitle: true,
         
          ),
      ),
    );
  }
  
}