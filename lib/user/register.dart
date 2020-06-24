import 'dart:io';

import 'package:chatApp/modals/user.dart';
import 'package:chatApp/services/auth.dart';
import 'package:chatApp/services/database.dart';
import 'package:chatApp/user/chatting.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chatApp/loginas.dart';
import 'package:chatApp/loginregister.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Register();
  }
}

GlobalKey<FormState> validatekey = GlobalKey<FormState>();

class _Register extends State<Register> with TickerProviderStateMixin {
  
  
  AuthMethods authMethods= AuthMethods();
  DatabaseMethods databaseMethods=DatabaseMethods();
  
  bool _isloading=false;
  String name;
  String username;
  String phone;
  String email;
  String pass;
  String conpass;
  UserInfo userInfo=UserInfo();
  File _imageFile;
  bool passwordVisible = true;
  bool _passwordVisible = true;
  void _getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = image;
    });
    Navigator.pop(context);
  }

  //not required because we are uploading image to the backend
  void _openImagePickerModal(BuildContext context) {
    print('hi');
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: Colors.cyanAccent[400],
                  child: Text('Use Camera'),
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: Colors.cyanAccent[400],
                  child: Text('Use Gallery'),
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  void MoveToLastScreen() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Loginregister()),
        (Route<dynamic> route) => false);
  }

  //signmeup function

  sigMeUp(String email, String password){

    setState(() {
      _isloading=true;
    });

    authMethods.signUpWithEmailAndPassword(email, password).then((value){
      // print("${value.userId}"),
      //upload data to firestore
      Map<String,dynamic> userInfoMap ={
        "name":userInfo.name,
        "email":userInfo.email,
        "username":userInfo.username,
        "phonenumber":userInfo.phonenumber
      };
      databaseMethods.uploadUserInfo(userInfoMap);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Loginas()));
       setState(() {
      _isloading=false;
    });
    });


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        MoveToLastScreen();
      },
      child:_isloading?Container(child: Center(child: CircularProgressIndicator(),),): Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff1f1f1f),
          title: Text(
            'REGISTER',
            style: GoogleFonts.aBeeZee(
                fontSize: 20, color: Colors.cyanAccent[200]),
          ),
          centerTitle: true,
        ),
        backgroundColor: Color(0xff1f1f1f),
        body: SingleChildScrollView(
          child: Center(
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
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: <Widget>[
                              //     // ClipOval(
                              //     //   child: SizedBox(
                              //     //     height: 180,
                              //     //     width: 180,
                              //     //     child: _imageFile == null
                              //     //         ? Image.asset(
                              //     //             'assets/pro.png',
                              //     //             fit: BoxFit.fill,
                              //     //           )
                              //     //         : Image.file(
                              //     //             _imageFile,
                              //     //             fit: BoxFit.fill,
                              //     //           ),
                              //     //   ),
                              //     // ),
                              //     Padding(
                              //       padding: EdgeInsets.only(top: 60),
                              //       child: IconButton(
                              //         icon: Icon(
                              //           Icons.camera,
                              //           size: 30,
                              //           color: Colors.white,
                              //         ),
                              //         onPressed: () {
                              //           _openImagePickerModal(context);
                              //         },
                              //       ),
                              //     )
                              //   ],
                              // ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextFormField(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return "Enter Name";
                                    } else
                                      return null;
                                  },
                                  cursorColor: Colors.white,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    // fillColor: Color(0xffefb168),
                                    hintText: "Name",
                                    alignLabelWithHint: true,
                                    labelText: "Name",
                                    hintStyle:
                                        GoogleFonts.aBeeZee(color: Colors.grey),

                                    labelStyle: GoogleFonts.aBeeZee(
                                        color: Colors.white),
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
                                    name = value;
                                  },
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                                    hintStyle:
                                        GoogleFonts.aBeeZee(color: Colors.grey),

                                    labelStyle: GoogleFonts.aBeeZee(
                                        color: Colors.white),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextFormField(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return "Enter Phone Number";
                                    } else
                                      return null;
                                  },
                                  cursorColor: Colors.white,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    // fillColor: Color(0xffefb168),
                                    hintText: "Phone No",
                                    alignLabelWithHint: true,
                                    labelText: "Phone No",
                                    hintStyle:
                                        GoogleFonts.aBeeZee(color: Colors.grey),

                                    labelStyle: GoogleFonts.aBeeZee(
                                        color: Colors.white),
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
                                    phone = value;
                                  },
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                                  decoration: InputDecoration(
                                    // fillColor: Color(0xffefb168),
                                    hintText: "Email",
                                    alignLabelWithHint: true,
                                    labelText: "Email",
                                    hintStyle:
                                        GoogleFonts.aBeeZee(color: Colors.grey),

                                    labelStyle: GoogleFonts.aBeeZee(
                                        color: Colors.white),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                                  cursorColor: Colors.white,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    // fillColor: Color(0xffefb168),
                                    hintText: "Password",
                                    alignLabelWithHint: true,
                                    labelText: "Password",
                                    hintStyle:
                                        GoogleFonts.aBeeZee(color: Colors.grey),
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
                                    labelStyle: GoogleFonts.aBeeZee(
                                        color: Colors.white),
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
                                    pass = value;
                                  },
                                  obscureText: passwordVisible,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                                  obscureText: _passwordVisible,
                                  decoration: InputDecoration(
                                    // fillColor: Color(0xffefb168),
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
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                    hintText: "Confirm Password",
                                    alignLabelWithHint: true,
                                    labelText: "Confirm Password",
                                    hintStyle:
                                        GoogleFonts.aBeeZee(color: Colors.grey),

                                    labelStyle: GoogleFonts.aBeeZee(
                                        color: Colors.white),
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
                                    conpass = value;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  validatekey.currentState.save();
                                  print(pass);
                                  print(email);
                                //TODO snackbar code must be added after the app completed
                                 userInfo=UserInfo(name: name,username: username,email: email,phonenumber: phone);

                                  sigMeUp(email,pass);


                                },
                                child: Card(
                                    color: Colors.cyanAccent[200],
                                    clipBehavior: Clip.antiAlias,
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.people,
                                                color: Colors.black,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Register",
                                                  style: GoogleFonts.aBeeZee(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))),
                              ),
                            ],
                          ))))),
        ),
      ),
    );
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


//snackbar code 
  // if (name?.isEmpty ?? true) {
  //                                   {
  //                                     _displaySnackBar(
  //                                         context, "Please enter your Name");
  //                                   }
  //                                 } else if (username?.isEmpty ?? true) {
  //                                   {
  //                                     _displaySnackBar(context,
  //                                         "Please enter your Username");
  //                                   }
  //                                 } else if (phone?.isEmpty ?? true) {
  //                                   {
  //                                     _displaySnackBar(context,
  //                                         "Please enter your Phone Number");
  //                                   }
  //                                 } else if (email?.isEmpty ?? true) {
  //                                   {
  //                                     _displaySnackBar(
  //                                         context, "Please enter your Email");
  //                                   }
  //                                 } else if (pass?.isEmpty ?? true) {
  //                                   {
  //                                     _displaySnackBar(context,
  //                                         "Please enter your Password");
  //                                   }
  //                                 } else if (conpass?.isEmpty ?? true) {
  //                                   {
  //                                     _displaySnackBar(
  //                                         context, "Re-Enter password");
  //                                   }
  //                                 } else if (pass.compareTo(conpass) != 0) {
  //                                   _displaySnackBar(context,
  //                                       "Entered Password's don't match.");
  //                                 } else if (pass.length < 8)
  //                                   _displaySnackBar(context,
  //                                       "Password must be atleast 8 characters long");
  //                                 else if (!RegExp(
  //                                         r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  //                                     .hasMatch(email))
  //                                   _displaySnackBar(
  //                                       context, "Please Fill valid Email");
  //                                 else if (phone.length != 10) {
  //                                   _displaySnackBar(context,
  //                                       "Please Fill a valid mobile no.");
  //                                 } else {
  //                                   _displaySnackBar(
  //                                       context, "Successfully Registered");
  //                                 }