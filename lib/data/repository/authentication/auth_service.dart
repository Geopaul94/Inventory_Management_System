import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inventory_management_system/data/models/user_data_model.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle errors
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else {
        throw Exception('An error occurred: ${e.message}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<UserCredential> signup(UserModel user) async {
    try {
      // Create a new user with email and password
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      // Add user information to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'shopName': user.shopename,
        'email': user.email,
        'phoneNumber': user.phonenumber,
        'uid': userCredential.user!.uid,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase exceptions
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else {
        throw Exception('An error occurred: ${e.message}');
      }
    } catch (e) {
      // Handle any other exceptions
      throw Exception('An error occurred: $e');
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await auth.signOut();

      // Optionally, you can show a message to the user

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully signed out')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $e')),
      );
    }
  }

Future<UserCredential?>loginwithgoogle()async{

 try { final googleUser =await GoogleSignIn().signIn();
  final googelAuth= await googleUser?.authentication;
  final cred =await GoogleAuthProvider.credential(idToken: googelAuth!.idToken,accessToken: googelAuth!.accessToken);
return await auth.signInWithCredential(cred);
   
 } catch (e) {

  print(e.toString());
   
 }return null;
}


  
}
