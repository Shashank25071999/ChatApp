import 'package:flutter/material.dart';

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
                    ? [
                        const Color(0xff007EF4), 
                        const Color(0xff2A75BC)
                      ]
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
