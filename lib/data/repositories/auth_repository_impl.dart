import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> login(String email, String password) async {

    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {

    await _auth.signOut();
  }
}