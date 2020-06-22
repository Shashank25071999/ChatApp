import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chatApp/admin/chat.dart';
import 'package:chatApp/admin/chatmodel.dart';
import 'package:chatApp/loginas.dart';
class ChatAd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChatAd();
  }
  
}
class _ChatAd extends State <ChatAd>{
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
        backgroundColor:  Color(0xff1f1f1f),
        appBar: AppBar(backgroundColor: Color(0xff1f1f1f),
        automaticallyImplyLeading: false,
        title: Text('MESSAGING',style: GoogleFonts.aBeeZee(color:Colors.cyanAccent[200],fontWeight: FontWeight.bold,fontSize: 20),),
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
        body: Container(
          child: ListView.builder(
            itemCount: ChatModel.dummyData.length,
            itemBuilder: (context, index) {
              ChatModel _model = ChatModel.dummyData[index];
              return Column(
               // crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                 
                  ListTile(
                    leading: CircleAvatar(
                      radius: 24.0,
                      backgroundImage: NetworkImage(_model.avatarUrl),
                    ),
                    title: Row(
                      children: <Widget>[
                        Text(_model.name,style: GoogleFonts.aBeeZee(color:Colors.white,fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 16.0,
                        ),
                        Text(
                          _model.datetime,
                          style: GoogleFonts.aBeeZee(color:Colors.white,fontSize: 12),
                        ),
                      ],
                    ),
                    subtitle: Text(_model.message ,style: GoogleFonts.aBeeZee(color:Colors.white,fontSize: 12),),
                    trailing: IconButton(
                      icon:Icon(
                      Icons.arrow_forward_ios,
                      size: 14.0,
                      color: Colors.cyanAccent[200],),
                      onPressed: (){  Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) =>Chatting()),
        (Route<dynamic> route) => false);},
                    ),
                  ),
                   Divider(
                    height: 12.0,
                    color: Colors.white,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
  
}