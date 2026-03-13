import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/hive_service.dart';

class AuthProvider with ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final HiveService hiveService = HiveService();

  bool isLoading = false;

  Future<String?> login(String email, String password) async {

    try {

      isLoading = true;
      notifyListeners();

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );


      await hiveService.saveLogin(true);

      return null;

    } on FirebaseAuthException catch (e) {

      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      }

      if (e.code == 'wrong-password') {
        return "Incorrect password.";
      }

      if (e.code == 'invalid-email') {
        return "Invalid email format.";
      }

      return e.message;

    } catch (e) {

      return "Something went wrong";

    } finally {

      isLoading = false;
      notifyListeners();
    }
  }

  Future logout() async {

    await _auth.signOut();

    await hiveService.logout();
  }
}