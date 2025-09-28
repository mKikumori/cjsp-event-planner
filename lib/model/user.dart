import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  // Firebase Auth Attributes
  final String uid;
  final String? email;
  final String? photoURL;

  // Profile Attributes (managed in Firestore)
  final String role;
  final String firstName;
  final String lastName;
  final List<String> favoriteIds;
  final bool notificationsEnabeled;

  // Timestamps
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.uid,
    this.email,
    this.photoURL,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.favoriteIds,
    required this.notificationsEnabeled,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create User instance from Firestore document
  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      uid: doc.id,
      email: data['email'] as String?,
      photoURL: data['photo_url'] as String?,
      role: data['role'] as String? ?? '',
      firstName: data['first_name'] as String? ?? '',
      lastName: data['last_name'] as String? ?? '',
      favoriteIds: parseStringList(data['favorite_ids']),
      notificationsEnabeled: data['notifications_enabeled'] as bool? ?? false,
      createdAt: parseDateTime(data['created_at']),
      updatedAt: parseDateTime(data['updated_at']),
    );
  }

  /// Convert User instance to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'photo_url': photoURL,
      'role': role,
      'first_name': firstName,
      'last_name': lastName,
      'favorite_ids': favoriteIds,
      'notifications_enabeled': notificationsEnabeled,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
    };
  }

  /// Helpers for parsing Firestore data
  static List<String> parseStringList(dynamic value) {
    if (value is List) return value.whereType<String>().toList();
    return [];
  }

  static List<int> parseIntList(dynamic value) {
    if (value is List) return value.whereType<int>().toList();
    return [];
  }

  static DateTime parseDateTime(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }
}
