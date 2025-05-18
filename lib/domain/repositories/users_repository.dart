import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentReference, DocumentSnapshot, FirebaseFirestore;
import '../../app/models/models.dart' show UserData;

class UsersRepository {
  UsersRepository({final FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const String usersCollectionKey = 'users';

  Future<UserData> fetchUserData({required final String uid}) async {
    final DocumentReference<Map<String, dynamic>> docRef =
        _firestore.collection(usersCollectionKey).doc(uid);

    final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await docRef.get();

    if (!docSnapshot.exists) {
      throw Exception('User data not found');
    }

    return UserData.fromJson(docSnapshot.data()!);
  }

  Future<void> updateUserData({
    required final String uid,
    required final UserData userData,
  }) async {
    await _firestore
        .collection(usersCollectionKey)
        .doc(uid)
        .set(userData.toJson());
  }

  Future<void> removeUserData({required final String uid}) async {
    await _firestore.collection(usersCollectionKey).doc(uid).delete();
  }
}
