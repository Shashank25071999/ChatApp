import 'package:chatApp/modals/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class DatabaseMethods {
  getUserByEmail(String email) async {
    return await Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments();
  }

  uploadUserInfo(Map<String, dynamic> mapobject) async {
    Firestore.instance.collection("users").add(mapobject);
  }

  createchatroom(String chatRoomId, Map<String, dynamic> mapdata) async {
    return await Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .setData(mapdata)
        .catchError((onError) {
      print(onError);
    });
  }

  addConversationMessages(String chatroomid, Map<String, dynamic> messagemap) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatroomid)
        .collection("Chats")
        .add(messagemap)
        .catchError((onError) {});
  }

  getConversationMessages(String chatroomid)async {
   return await Firestore.instance
        .collection("ChatRoom")
        .document(chatroomid)
        .collection("Chats").orderBy("time",descending: false)
        .snapshots();
  }

  getChatroom(String username)async{
  return  Firestore.instance.collection("ChatRoom").where("users",arrayContains:username).snapshots();
  }

}
