import 'package:event_planner/services/user_service.dart';
import 'package:event_planner/view/auth/register_view.dart';
import 'package:event_planner/view/core/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:event_planner/services/auth_service.dart';

class RegistrationViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  bool _isLoading = false;
  String? _errorMessage;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _password;
  String? _phoneNumber;
  String? _uid;
  String? _role;

  String? _selectedCountryCode = '+55';

  String? _firstNameError;
  String? _lastNameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _roleError;

  // --- Getters ---
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get password => _password;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get uid => _uid;
  String? get role => _role;
  String? get selectedCountryCode => _selectedCountryCode;

  String? get firstNameError => _firstNameError;
  String? get lastNameError => _lastNameError;
  String? get emailError => _emailError;
  String? get phoneError => _phoneError;
  String? get passwordError => _passwordError;
  String? get roleError => _roleError;

  // --- Setters ---
  void setSelectedCountryCode(String code) {
    _selectedCountryCode = code;
    notifyListeners();
  }

  void setFirstName(String value) {
    _firstName = value;
  }

  void setLastName(String value) {
    _lastName = value;
  }

  void setEmail(String value) {
    _email = value;
  }

  void setPhoneNumber(String value) {
    _phoneNumber = value;
  }

  void setPassword(String value) {
    _password = value;
  }

  void setRole(String value) {
    _role = value;
    notifyListeners();
  }

  void setUserInfo({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
    required String role,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _password = password;
    _phoneNumber = phoneNumber;
    _role = role;
    notifyListeners();
  }

  // --- Loading control ---
  void _setLoading(bool value) {
    _isLoading = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearAllErrors() {
    _firstNameError = null;
    _lastNameError = null;
    _emailError = null;
    _phoneError = null;
    _passwordError = null;
    _roleError = null;
    notifyListeners();
  }

  void setFieldErrors({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? password,
    String? role,
  }) {
    _firstNameError = firstName;
    _lastNameError = lastName;
    _emailError = email;
    _phoneError = phone;
    _role = role;
    _passwordError = password;
    notifyListeners();
  }

  Future<void> register({
    required String password,
    required BuildContext context,
  }) async {
    _setLoading(true);
    try {
      final credential = await _authService.register(_email!, password);
      _uid = credential?.user?.uid;
      if (_uid == null) throw Exception("UID é nulo");

      await _userService.saveUserProfile(
        uid: _uid!,
        email: _email!,
        firstName: _firstName!,
        lastName: _lastName!,
        role: _role!,
      );

      Navigator.push(
        context,
        CupertinoPageRoute(builder: (_) => const HomeView()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _errorMessage = 'Esse email ja foi cadastrado.';
      } else if (e.code == 'weak-password') {
        _errorMessage =
            'Senha deve conter 8 caracteres, com pelo menos 1 letra maiuscula e 1 caractere especial.';
      } else if (e.code == 'invalid-email') {
        _errorMessage = 'Esse não parece ser um email válido.';
      } else {
        _errorMessage = 'Algo deu errado. Tente novamente.';
      }
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (_) => const RegisterView()),
        (route) => false,
      );
    } catch (e) {
      _errorMessage = 'Algo inesperado aconteceu.';
      print('Registration failed: $e');
    }
    _setLoading(false);
  }
}
