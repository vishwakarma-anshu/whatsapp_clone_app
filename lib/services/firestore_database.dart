import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone_app/services/database_api.dart';

class FirestoreDatabase extends DatabaseApi {
  Firestore _database = Firestore.instance;
  final String _userCollection = 'users';

  @override
  Future<void> createUser(
      {FirebaseUser user,
      String name,
      String countryCode,
      String phoneNumber}) {
    return _database.collection(_userCollection).document(user.uid).setData({
      'uid': user.uid,
      'name': name,
      'countryCode': countryCode,
      'phoneNumber': phoneNumber,
    });
  }
}
