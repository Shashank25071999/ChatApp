import 'package:chatApp/converstation/conversation.dart';
import 'package:chatApp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chatApp/loginas.dart';

class Chatting extends StatefulWidget {
  QuerySnapshot usersnapshot;
  
  Chatting({this.usersnapshot});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Chatting(username: usersnapshot.documents[0].data["name"]);
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
          print("snapshot data : ${snapshot.hasData}");
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Chatroomtile(
                        othername: "Admin",
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
    databaseMethods.getChatroom(username).then((value) {
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
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      'OK',
                      style: GoogleFonts.aBeeZee(color: Colors.cyanAccent[300]),
                    )),
              ],
            ));
  }

  void handleClick(String value) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Loginas()),
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
    List<String> users = [
      widget.usersnapshot.documents[0].data["name"],
      "AdminName"
    ];
    String chatroomid = getchatroomid(
        widget.usersnapshot.documents[0].data["email"], "admin@gmail.com");
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
                    username: username,
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        MoveToLastScreen();
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor:Color(0xff007EF4),
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
            'CHAT',
            style: GoogleFonts.aBeeZee(
                color: Color(0xff007EF4),
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          centerTitle: true,
          actions: <Widget>[
            Theme(
              data: Theme.of(context).copyWith(
                cardColor: Color(0xff1f1f1f),
              ),
              child: PopupMenuButton<String>(
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
                        style: GoogleFonts.aBeeZee(color: Colors.white),
                      ),
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

class Chatroomtile extends StatelessWidget {
  final String othername;
  Chatroomtile({this.othername});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.only(top: 22),
        color: Color(0xff007EF4),
        child: Row(
          children: <Widget>[
            Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(40)),
              child: Text(
                "${othername.substring(0, 1).toUpperCase()}",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Text(
              othername,
              style: TextStyle(color: Colors.black),
            )
          ],
        ));
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
