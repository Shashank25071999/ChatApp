import 'package:chatApp/converstation/conversation.dart';
import 'package:chatApp/loginregister.dart';
import 'package:chatApp/services/database.dart';
import 'package:chatApp/sharedprefrencesmethods/sharedprefrences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chatApp/modals/user.dart';
import 'package:chatApp/admin/ChatTile/chatTile.dart';

class AdminChatWithUserList extends StatefulWidget {
  QuerySnapshot usersnapshot;
  UserInfo user=UserInfo();
  
  AdminChatWithUserList({this.user});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AdminChatting(username:user.name);
  }
}

class _AdminChatting extends State<AdminChatWithUserList> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  String username;
  _AdminChatting({this.username});

  Stream chatroomstream;
  var snapshot2;

  Widget chatRoomList() {
    return StreamBuilder(
        stream: chatroomstream,
        builder: (context, snapshot) {
          // print("snapshot data : ${snapshot.hasData}");
          
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Chatroomtile(
                        othername: snapshot.data.documents[index].data["name"],
                        email:snapshot.data.documents[index].data["email"],
                      ),
                      onTap: () {
                        createchatroomforuseradmin(firstuser: "Admin",seconduser:snapshot.data.documents[index].data["name"],otheremail: snapshot.data.documents[index].data["email"] );
                        
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
    databaseMethods.getallUsers().then((value) {
      chatroomstream = value;
      setState(() {});
    });
  }

  void MoveToLastScreen() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Do you want to exit',
                style: GoogleFonts.aBeeZee(color: Colors.black),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      print("exit app");
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
    SharedPrefrences pref=SharedPrefrences();
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
// this is must be called in the listview builder for getting the user 
  createchatroomforuseradmin({String firstuser,String seconduser,String otheremail}) {
    List<String> users = [
      seconduser,
      firstuser
    ];
    String chatroomid = getchatroomid(
        otheremail, "admin@gmail.com");
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
    return Scaffold(
      
      body: chatRoomList(),
      backgroundColor: Color(0xff1f1f1f),
      appBar: AppBar(elevation: 12,
      
        backgroundColor: Color(0xff1f1f1f),
        automaticallyImplyLeading: false,
        title: Text(
          'All Users',
          style: GoogleFonts.aBeeZee(
              color: Colors.white,
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
