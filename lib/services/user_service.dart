// lib/services/user_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:event_planner/model/user.dart' as custom;

/// Manages user profile operations in Firestore, including retrieval, creation, and updates.
class UserService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  UserService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  /// Retrieves the user profile for the given UID from Firestore.
  Future<custom.User?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('userprofiles').doc(uid).get();
      if (!doc.exists) return null;
      return custom.User.fromFirestore(doc);
    } catch (e) {
      return null;
    }
  }

  /// Saves a new user profile to Firestore with default settings.
  Future<void> saveUserProfile({
    required String uid,
    required String email,
    required String firstName,
    required String lastName,
    required String role,
  }) async {
    try {
      final now = FieldValue.serverTimestamp();
      await _firestore.collection('userprofiles').doc(uid).set({
        'email': email,
        'photo_url': null,
        'role': role,
        'first_name': firstName,
        'last_name': lastName,
        'favorite_ids': <String>[],
        'notifications_enabled': false,
        'created_at': now,
        'updated_at': now,
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Updates specific fields of an existing user profile in Firestore.
  Future<void> updateUserProfileField(
    String uid,
    Map<String, dynamic> updates,
  ) async {
    try {
      updates['updated_at'] = FieldValue.serverTimestamp();
      await _firestore.collection('userprofiles').doc(uid).update(updates);
    } catch (e) {
      rethrow;
    }
  }
}
