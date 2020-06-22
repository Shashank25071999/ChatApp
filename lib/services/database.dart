import 'package:chatApp/modals/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseMethods{

getUserByEmail(String email)async{

}


uploadUserInfo(Map<String,dynamic> mapobject)async{
  Firestore.instance.collection("users").add(mapobject);
  }
}