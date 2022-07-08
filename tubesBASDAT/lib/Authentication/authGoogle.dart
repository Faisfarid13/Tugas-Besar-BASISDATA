import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class authenticationServiceGoogle{
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth./contacts.readonly',
    ],
  );

  Future<bool> signIn()async{
    try{
      await _googleSignIn.signIn();
      print('AMAN');
      return true;
    } on FirebaseAuthException catch (e){
      debugPrint(e.message ?? "Unknown Error");
      print('GAGAL');
      return false;
    }
  }
}