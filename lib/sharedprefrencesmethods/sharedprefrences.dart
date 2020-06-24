import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrences{

String usernamekey="sharedprefrencesusernamekey";
String namekey ="sharedprefrencesnamekey";
String emailkey="sharedprefrencesemail";
String phonekey="sharedprefrencesphonekey";

Future<bool> setusername(String username)async{
 SharedPreferences prefs = await SharedPreferences.getInstance();
 return prefs.setString(usernamekey, username);
}

Future<bool> setname(String name)async{
 SharedPreferences prefs = await SharedPreferences.getInstance();
 return prefs.setString(namekey, name);
}

Future<bool> setemail(String email)async{
 SharedPreferences prefs = await SharedPreferences.getInstance();
 return prefs.setString(emailkey, email);
}

Future<bool> setphonenumber(String phone)async{
 SharedPreferences prefs = await SharedPreferences.getInstance();
 return prefs.setString(phonekey, phone);
}


Future<String> getusername()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get(usernamekey);
}

Future<String> getname()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get(namekey);
}



Future<String> getemail()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get(emailkey);
}


Future<String> getphonenumber()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get(phonekey);
}

}