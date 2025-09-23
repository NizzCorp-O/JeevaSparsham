import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_pratice/features/profile/domain/entities/user_profile.dart';
import 'package:hello_pratice/features/profile/domain/repositories/i_profile_repository.dart';

class ProfileRepositoryImpl extends IProfileRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<UserProfile> getUserProfile(String userId) async {
    try {
      final userData = await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .get();
      final Map<String, dynamic>? userProfile = userData.data();
      return UserProfile(
        userId: userProfile?['uid'],
        name: userProfile?['name'],
        email: userProfile?['email'],
        phoneNumber: userProfile?['phone'],
        role: userProfile?['role'],
        location: userProfile?['location'],
      );
    } catch (e) {
      throw 'Failed to get profile';
    }
  }
}
