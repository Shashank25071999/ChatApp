import 'dart:async';

import 'package:chatApp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:chatApp/converstation/MessageTile/messageTile.dart';
import 'package:chatApp/Widget/widget.dart';

class Conversation extends StatefulWidget {
  
  final String chatroomid;
  final String username;
  Conversation({this.chatroomid, this.username});
  @override
  State<StatefulWidget> createState() {
    print(username);
    return _ConversationState();
  }
}

class _ConversationState extends State<Conversation> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream chatmessagestream;
  ScrollController _controller;
  // void _scrolltobottom(){
  //   if(_controller.hasClients){
  //     _controller.animateTo(_controller.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.elasticOut);

  //   }else{
  //     Timer(Duration(milliseconds: 400), ()=>_scrolltobottom);
  //   }
    

    
  // }
  void initState() {
     _controller=ScrollController();
    databaseMethods.getConversationMessages(widget.chatroomid).then((value) {
      setState(() {
        chatmessagestream = value;
      });
    });
    super.initState();
  }

  Widget ChatmessageList() {
    return StreamBuilder(
        stream: chatmessagestream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                controller: _controller,
                reverse: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                        message: snapshot.data.documents[index].data["message"],
                        issendby:
                            snapshot.data.documents[index].data["sendBy"] ==
                                widget.username);
                  })
              : Container();
        });
  }

  sendmessage() {
    if (textmessagecontroller.text.isNotEmpty) {
      Map<String, dynamic> messagemap = {
        "message": textmessagecontroller.text,
        "sendBy": widget.username,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(widget.chatroomid, messagemap);
      textmessagecontroller.text = "";
    }
  }

  TextEditingController textmessagecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>_scrolltobottom());
    // TODO: implement build
    return Scaffold(
        appBar:appBarMain(context, "Admin Conversation"),
        backgroundColor: Colors.black,
        body: Container(
            child: Column(
              children: <Widget>[
                Expanded(child: ChatmessageList()),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: TextField(
                            controller: textmessagecontroller,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Write message...",
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none),
                          )),
                          GestureDetector(
                            onTap: () {
                              print(textmessagecontroller.text);
                              sendmessage();
                            },
                            child: Center(
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)),
                                padding: EdgeInsets.all(12),
                                child: Center(child: Icon(Icons.send)),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ],
            )));
  }
}

