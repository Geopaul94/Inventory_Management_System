import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inventory_management_system/data/models/user_data_model.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential; // Return the UserCredential object
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


      // Optionally, you can store additional user information in Firestore or Realtime Database

      // For example, you can save the username here


      return userCredential; // Return the UserCredential object

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

        SnackBar(content: Text('Successfully signed out')),

      );

    } catch (e) {

      // Handle any errors that occur during sign-out

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(content: Text('Error signing out: $e')),

      );

    }
}}