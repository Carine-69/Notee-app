import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> saveUserData(User user) async {
    final docRef = _firestore.collection('users').doc(user.uid);

    final doc = await docRef.get();
    if (!doc.exists) {
      await docRef.set({'email': user.email, 'createdAt': Timestamp.now()});
    }
  }
}
