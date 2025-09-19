import 'package:hello_pratice/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepositoryImpl extends IAuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference usersCollection = FirebaseFirestore.instance
      .collection('users');
  @override
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      final user = credential.user;
      return user?.uid;
    } catch (e) {
      throw "Login failed. Please try again later.";
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw "Logout failed. Please try again later.";
    }
  }

  @override
  Future<String> getUserRole(String uid) async {
    try {
      DocumentSnapshot userDoc = await usersCollection.doc(uid).get();
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      final userRole = userData['role'];
      return userRole;
    } catch (e) {
      throw "Login failed. Please try again later.";
    }
  }
}
