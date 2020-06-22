import 'package:chatApp/modals/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{

final FirebaseAuth _auth= FirebaseAuth.instance;

User _userFromFirebase(FirebaseUser user){
  print("userUid :${user.uid}");
  return user!=null?User(userId: user.uid):null;
}

//login function after registration
Future signInWithEmailAndPassword(String email,String password)async{
  try{
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser firebaseUser=result.user;
    return _userFromFirebase(firebaseUser);
  }catch(e){
    print(e);
  }
}

//regidtration function before registration
Future signUpWithEmailAndPassword(String email, String password)async{

  try{
     AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
     FirebaseUser firebaseUser=result.user;
     return _userFromFirebase(firebaseUser);

  }catch(e){
    print(e.toString());
  }
}

//reset password function
Future resetPassword(String email)async{
  try{
    return await _auth.sendPasswordResetEmail(email: email);

  }catch(e){
    print(e.toString());
  }
}

//signout function
Future signOut()async{
  try{
    return await _auth.signOut();
  }catch(e){
    print(e.toString());
  }
}

}