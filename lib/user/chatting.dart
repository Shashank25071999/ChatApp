import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chatApp/loginas.dart';
class Chatting extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Chatting();
  }
  
}
class _Chatting extends State <Chatting>{
  void MoveToLastScreen(){
           showDialog(context: context,
           builder: (context)=> AlertDialog(title: Text('Logout from app',style: GoogleFonts.aBeeZee(color:Colors.black),),
           actions: <Widget>[
             FlatButton(onPressed:()=>Navigator.pop(context,false), child: Text('OK',style: GoogleFonts.aBeeZee(color:Colors.cyanAccent[300]),)
             ),
            
           ],
           ));
          
  }
   void handleClick(String value) {
   Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => Loginas()),
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
          automaticallyImplyLeading: false,
          title: Text('CHAT',style: GoogleFonts.aBeeZee(color:Colors.cyanAccent[200],fontWeight: FontWeight.bold,fontSize: 20),),
          centerTitle: true,
          actions: <Widget>[
          Theme(
             data: Theme.of(context).copyWith(
                    cardColor:Color(0xff1f1f1f),
                  ),
             child: PopupMenuButton<String>(
               icon: Icon(Icons.more_vert, color: Colors.white,),
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  
                  return {'Logout'}.map((String choice) {
                    return PopupMenuItem<String>(
                      
                      value: choice,
                      child: Text(choice,style: GoogleFonts.aBeeZee(color:Colors.white),),
                    );
                  }).toList();
                },
              ),
           ),
          ],
          ),
      ),
    );
  }
  
}