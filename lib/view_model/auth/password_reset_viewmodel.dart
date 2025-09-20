import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PasswordResetViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  String? _statusMessage;
  bool _isLoading = false;

  String? get email => emailController.text;
  String? get statusMessage => _statusMessage;
  bool get isLoading => _isLoading;

  void setEmail(String value) {
    emailController.text = value;
    notifyListeners();
  }

  Future<bool> sendResetEmail() async {
    _setLoading(true);
    try {
      final trimmedEmail = emailController.text.trim();
      await _auth.sendPasswordResetEmail(email: trimmedEmail);
      _statusMessage = '📩 A reset link has been sent to $trimmedEmail.';
      return true;
    } on FirebaseAuthException catch (e) {
      _statusMessage = e.message ?? 'Something went wrong.';
      return false;
    } catch (e) {
      _statusMessage = 'Unexpected error: $e';
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
