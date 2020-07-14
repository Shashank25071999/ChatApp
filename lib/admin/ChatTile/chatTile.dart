import 'package:flutter/material.dart';

class Chatroomtile extends StatelessWidget {
  final String othername;
  final String email;
  Chatroomtile({this.othername, this.email});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.only(top: 22),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 22),
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
              width: 12,
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  othername,
                  style: TextStyle(
                       fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  email,
                  
                ),
              ),
            )
          ],
        ));
  }
}
