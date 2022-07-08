import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthenticationService{
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Future<bool> signIn({required String email, required String password, required BuildContext context}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print('AMAN');
      return true;
    } on FirebaseAuthException catch (e){
      debugPrint(e.message ?? "Unknown Error");
      print('GAGAL');
      return false;
    }
  }

  Future<bool> singUp({required String email, required String password}) async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    }on FirebaseAuthException catch (e){
      debugPrint(e.message ?? "Unkwon Error");
      return false;
    }
  }

  void singOut(){
    _firebaseAuth.signOut();
  }
}
