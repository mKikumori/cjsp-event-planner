import 'package:event_planner/services/auth_service.dart';
import 'package:event_planner/view/core/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  String get email => emailController.text.trim();
  String get password => passwordController.text.trim();

  Future<void> signIn(BuildContext context) async {
    _setLoading(true);
    try {
      final userCredential = await _authService.signin(
        email: email,
        password: password,
      );

      if (userCredential != null) {
        final user = userCredential.user;

        _errorMessage = null;
        print('✅ User signed in: ${user?.uid}');
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => const HomeView(),
          ),
        );
      } else {
        _errorMessage = 'Login failed, please try again.';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        _errorMessage =
            'We couldn’t find an account with those details. Try again?';
      } else {
        _errorMessage = 'Something went wrong. Please try again later.';
      }
    } catch (e) {
      _errorMessage = 'Error: ${e.toString()}';
    }
    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
