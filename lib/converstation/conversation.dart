import 'package:chatApp/services/database.dart';
import 'package:flutter/material.dart';

class Conversation extends StatefulWidget {
  final String chatroomid;
  final String username;
  Conversation({this.chatroomid, this.username});
  @override
  State<StatefulWidget> createState() {
    return _ConversationState();
  }
}

class _ConversationState extends State<Conversation> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream chatmessagestream;

  void initState() {
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
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Admin Conversation"),
        ),
        backgroundColor: Colors.black,
        body: Container(
            child: Stack(
          children: <Widget>[
            ChatmessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                  color: Color(0x54FFFFFF),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextField(
                        controller: textmessagecontroller,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none),
                      )),
                      GestureDetector(
                        onTap: () {
                          print(textmessagecontroller.text);
                          sendmessage();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0x36FFFFFF),
                                Color(0x0FFFFFFF)
                              ]),
                              borderRadius: BorderRadius.circular(40)),
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.send),
                        ),
                      )
                    ],
                  )),
            )
          ],
        )));
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool issendby;
  MessageTile({this.message, this.issendby});
  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.only(left:issendby? 0:20, right:issendby?20:0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: issendby ? Alignment.centerRight : Alignment.bottomLeft,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: issendby
                    ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                    : [
                        const Color(0x1AFFFFFF),
                        const Color(0X1AFFFFFF),
                      ]),
            borderRadius: issendby
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23))),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Text(
          message,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
