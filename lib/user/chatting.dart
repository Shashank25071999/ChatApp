import 'package:chatApp/admin/ChatTile/chatTile.dart';
import 'package:chatApp/converstation/conversation.dart';
import 'package:chatApp/loginregister.dart';
import 'package:chatApp/modals/user.dart';
import 'package:chatApp/services/database.dart';
import 'package:chatApp/sharedprefrencesmethods/sharedprefrences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chatApp/loginas.dart';

class Chatting extends StatefulWidget {
  QuerySnapshot usersnapshot;
  UserInfo user = UserInfo();
  Chatting({this.usersnapshot, this.user});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Chatting(username: user.name);
  }
}

class _Chatting extends State<Chatting> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  String username;
  _Chatting({this.username});

  Stream chatroomstream;
  var snapshot2;

  Widget chatRoomList() {
    return StreamBuilder(
        stream: chatroomstream,
        builder: (context, snapshot) {
          // print(snapshot.data.documents.length);
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Chatroomtile(
                        othername: "Admin",
                        email: "admin@gmail.com",
                      ),
                      onTap: () {
                        createchatroomforuseradmin();
                      },
                    );
                  })
              : Container();
        });
  }

  void initState() {
    getuserinfo();
    super.initState();
  }

  getuserinfo() async {
    databaseMethods.getChatroom(widget.user.name).then((value) {
      chatroomstream = value;
      setState(() {});
    });
  }

  void MoveToLastScreen() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Logout from app',
                style: GoogleFonts.aBeeZee(color: Colors.black),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text(
                      'OK',
                      style: GoogleFonts.aBeeZee(color: Colors.cyanAccent[300]),
                    )),
              ],
            ));
  }

  void handleClick(String value) {
    SharedPrefrences pref = SharedPrefrences();
    pref.logout();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Loginregister()),
        (Route<dynamic> route) => false);
  }

  getchatroomid(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createchatroomforuseradmin() {
    List<String> users = [username, "AdminName"];
    String chatroomid = getchatroomid(widget.user.email, "admin@gmail.com");
    print(chatroomid);
    Map<String, dynamic> chatroommap = {
      "users": users,
      "chatroomid": chatroomid
    };
    

    databaseMethods.createchatroom(chatroomid, chatroommap).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Conversation(
                    chatroomid: chatroomid,
                    username: widget.user.name,
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.chat,
            color: Colors.black,
          ),
          onPressed: () {
            createchatroomforuseradmin();
          }),
      body: chatRoomList(),
      backgroundColor: Color(0xff1f1f1f),
      appBar: AppBar(
        backgroundColor: Color(0xff1f1f1f),
        automaticallyImplyLeading: false,
        title: Text(
          'Admin Conversation',
          style: GoogleFonts.aBeeZee(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Theme(
            data: Theme.of(context).copyWith(
              cardColor: Color(0xff1f1f1f),
            ),
            child: PopupMenuButton<String>(
              color: Colors.white,
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Logout'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(
                      choice,
                      style: GoogleFonts.aBeeZee(color: Colors.black),
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Container(height: 60,child: GestureDetector(onTap: (){
//           print("message to admin connection build");
//           createchatroomforuseradmin();
//         },
//                   child: Card(child:Row(mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Column(children: <Widget>[
//                 Text("Admin"),
//                 SizedBox(height:8),
//                 Text("admin@gmail.com"),

//               ],
//               ),
//            Text("Message to admin") ],
//           )),
//         ),),
