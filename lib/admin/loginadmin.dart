import 'package:chatApp/sharedprefrencesmethods/sharedprefrences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chatApp/services/auth.dart';
import 'package:chatApp/modals/user.dart';
import 'package:chatApp/admin/chat.dart';

class LoginAd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginAd();
  }
}

GlobalKey<FormState> validatekey = GlobalKey<FormState>();

class _LoginAd extends State<LoginAd> {

  AuthMethods authMethods=AuthMethods();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String username;
  String password;
  String email;
  bool passwordVisible = true;
  bool _isloading=false;


  loginMeAsAAdmin(){
    setState(() {
      _isloading=true;
    });
    SharedPrefrences sharedPrefrences=SharedPrefrences();
    sharedPrefrences.setadminloginbool(true);
    sharedPrefrences.setuserloginbool(false);
    authMethods.signInWithEmailAndPassword(email, password).then((value) {
      UserInfo user=UserInfo(email:email,username: "Admin",name: "Admin",phonenumber: "9984508400");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminChatWithUserList(user: user,)));
      

    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xff1f1f1f),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: validatekey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {});
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 10),
                  //     child: Align(
                  //       alignment: Alignment.topLeft,
                  //       child: IconButton(
                  //           icon: Icon(
                  //           Icons.arrow_back,
                  //           color: Colors.cyanAccent[200],
                  //         ),
                  //         onPressed: (){
                  //           Navigator.pop(context);
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 30, top: 30),
                      child: Text(
                        ' ADMIN',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 25, color: Colors.white),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null) {
                          return "Enter Username";
                        } else
                          return null;
                      },
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        // fillColor: Color(0xffefb168),
                        hintText: "Username",
                        alignLabelWithHint: true,
                        labelText: "Username",
                        hintStyle: GoogleFonts.aBeeZee(color: Colors.grey),

                        labelStyle: GoogleFonts.aBeeZee(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.cyanAccent[200],
                              style: BorderStyle.solid,
                              width: 1),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xffffffff),
                              style: BorderStyle.solid,
                              width: 1),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      onSaved: (value) {
                        username = value;
                      },
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null) {
                          return "Enter Email";
                        } else
                          return null;
                      },
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.white,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        // fillColor: Color(0xffefb168),
                        hintText: "Email",
                        alignLabelWithHint: true,
                        labelText: "Email",
                        hintStyle: GoogleFonts.aBeeZee(color: Colors.grey),
                        labelStyle: GoogleFonts.aBeeZee(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.cyanAccent[200],
                              style: BorderStyle.solid,
                              width: 1),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xffffffff),
                              style: BorderStyle.solid,
                              width: 1),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      onSaved: (value) {
                        email = value;
                      },
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null) {
                          return "Enter Password";
                        } else
                          return null;
                      },
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.white,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        // fillColor: Color(0xffefb168),
                        hintText: "Password",
                        alignLabelWithHint: true,
                        labelText: "Password",
                        hintStyle: GoogleFonts.aBeeZee(color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon

                            passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                        labelStyle: GoogleFonts.aBeeZee(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.cyanAccent[200],
                              style: BorderStyle.solid,
                              width: 1),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xffffffff),
                              style: BorderStyle.solid,
                              width: 1),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      onSaved: (value) {
                        password = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      print(username);
                      validatekey.currentState.save();
                      loginMeAsAAdmin();
                      
                    },
                    child: Card(
                        color: Colors.cyanAccent[200],
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Login",
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                  ),
                  /*RaisedButton(
                                                onPressed: () {
                                                  loginFunction();
                                                },
                                                child: Text("Login"),
                                              )*/
                ],
              ),
            ),
          ),
        )));
  }

  _displaySnackBar(BuildContext context, String a) {
    final snackBar = SnackBar(
      content: Text(
        a,
        textAlign: TextAlign.center,
        style: GoogleFonts.aBeeZee(color: Colors.cyanAccent[200]),
      ),
      backgroundColor: Colors.black,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

// if(username?.isEmpty??true)
// {  _displaySnackBar(context, "Please enter your Username");

// }
//   else
//   if(password?.isEmpty??true)
//   _displaySnackBar(context, "Please enter your Password");
//   else
//   if(username.compareTo('Admin')!=0 && username.compareTo('admin')!=0)
//    _displaySnackBar(context, "Incorrect Username");
//    else
//    if(password!='admin'){
//        _displaySnackBar(context, "Incorrect Password");
//    }

//   else
// Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatAd())
// );
