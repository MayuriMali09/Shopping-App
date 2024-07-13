import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
class AuthService{
  final auth=FirebaseAuth.instance;
Future<User?>createUserWithEmailAndPassword(String mail,String password)async{
  try{
    final credential=await auth.createUserWithEmailAndPassword(email: mail, password: password);
    return credential.user;//if this user is null then something wrong has happened
  }catch(e){
    log("something went wrong");
  }
return null;
}

  Future<User?>loginUserWithEmailAndPassword(String mail,String password)async{
    try{
      final credential=await auth.signInWithEmailAndPassword(email: mail, password: password);
      return credential.user;//if this user is null then something wrong has happened
    }catch(e){
      log("something went wrong");
    }
    return null;
  }
Future<void>signOut()async{
  try{
    await auth.signOut();
  }catch(e){
    log("something went wrong while signing out");
  }
}
}