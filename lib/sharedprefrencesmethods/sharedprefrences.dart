import 'package:chatApp/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrences {
  String usernamekey = "sharedprefrencesusernamekey";
  String namekey = "sharedprefrencesnamekey";
  String emailkey = "sharedprefrencesemail";
  String phonekey = "sharedprefrencesphonekey";
  String userlogedin = "sharedprefrencesuserlogedin";
  String adminlogedin = "sharedprefrencesadminlogedib";
  String chatroomid = "sharedprefrenceschatroomid";

  Future<bool> setusername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(usernamekey, username);
  }

  Future<bool> setname(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(namekey, name);
  }

  Future<bool> setchatroomid(String chatroomid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(chatroomid, chatroomid);
  }

  Future<bool> setemail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(emailkey, email);
  }

  Future<bool> setphonenumber(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(phonekey, phone);
  }

  Future<String> getusername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(usernamekey);
  }

  Future<bool> setuserloginbool(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(userlogedin, value);
  }

  Future<bool> setadminloginbool(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(adminlogedin, value);
  }

  Future<String> getname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(namekey);
  }

  Future<String> getemail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(emailkey);
  }

  Future<String> getphonenumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(phonekey);
  }

  Future<bool> getuserlogedin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(userlogedin);
  }

  Future<bool> getadminloggedin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(adminlogedin);
  }

  Future<bool> getchatroomid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(chatroomid);
  }

  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    AuthMethods authMethods = AuthMethods();
    authMethods.signOut();
    prefs.setBool(adminlogedin, false);
    prefs.setBool(userlogedin, false);

    // print("logout:${}")
    return prefs.clear();
  }
}
