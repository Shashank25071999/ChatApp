import 'package:chatApp/modals/user.dart';
import 'package:chatApp/user/chatting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chatApp/loginregister.dart';
import 'package:chatApp/sharedprefrencesmethods/sharedprefrences.dart';

import 'admin/chat.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));
  });
}
class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{
    bool userloggedin;
    bool adminloggedin;
    String name;
    String phonenumber;
    String email;
    String username;
    UserInfo userInfo =UserInfo();
  void initState(){

    checkinglogindetail();
    super.initState();
  }

  checkinglogindetail()async{
      SharedPrefrences sharedPrefrences=SharedPrefrences();
      adminloggedin=await sharedPrefrences.getadminloggedin();
      
      print(adminloggedin);
      userloggedin=await sharedPrefrences.getuserlogedin();
      print(userloggedin);
      name=await sharedPrefrences.getname();
      email=await sharedPrefrences.getemail();
      phonenumber=await sharedPrefrences.getphonenumber();
      username=await sharedPrefrences.getusername();
      if(userloggedin==true){
        userInfo.email=email;
        adminloggedin=false;
        userInfo.name=name;
        userInfo.phonenumber=phonenumber;
        userInfo.username=username;
      }else if(adminloggedin==true){
        userInfo.email="admin@gmail.com";
        userInfo.name="Admin";
        userInfo.phonenumber="9984508400";
        userloggedin=false;
        userInfo.username="admin";
      }

      // print(userloggedin);
      // print(adminloggedin);
      // print(userloggedin==true&&adminloggedin==false);
      print(userInfo.name);
      setState(() {   
      });
  }
  @override
  Widget build(BuildContext context) {
    print("build method:${userloggedin}");
    print("build method:${adminloggedin}");
    // TODO: implement build
    return userloggedin==true&&adminloggedin==false?Chatting(user:userInfo):userloggedin==false&&adminloggedin==true?AdminChatWithUserList(user:userInfo):Loginregister();
  }
}
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
