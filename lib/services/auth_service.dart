import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth;
  AuthService([FirebaseAuth? auth]) : _auth = auth ?? FirebaseAuth.instance;

  /// Register without verification
  Future<UserCredential?> register(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("✅ User registered: ${userCredential.user?.uid}");
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("❌ Registration error: ${e.code} - ${e.message}");
      return null;
    }
  }

  /// Register and send email verification
  Future<UserCredential?> registerWithEmailVerification(
      String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.sendEmailVerification();
      print("📧 Verification email sent to $email");
      return credential;
    } on FirebaseAuthException catch (e) {
      print('❌ FirebaseAuthException: ${e.code} - ${e.message}');
      rethrow;
    }
  }

  /// Reload user and check email verification
  Future<bool> checkEmailVerifiedStatus() async {
    try {
      await _auth.currentUser?.reload();
      return _auth.currentUser?.emailVerified ?? false;
    } catch (e) {
      print("❌ Error checking email verification: $e");
      return false;
    }
  }

  /// Resend email verification
  Future<bool> resendVerificationEmail() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        print("📨 Verification email resent.");
        return true;
      }
      return false;
    } catch (e) {
      print("❌ Failed to resend verification email: $e");
      return false;
    }
  }

  /// Normal sign-in
  Future<UserCredential?> signin({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("Sign-in error: ${e.code} - ${e.message}");
      return null;
    } catch (e) {
      print("Unexpected sign-in error: $e");
      return null;
    }
  }

  /// Sign-in, fallback to MFA resolver if needed
  Future<UserCredential?> signInWithSmsMfa({
    required String email,
    required String password,
    required Future<String> Function(String verificationId) getCodeFromUser,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthMultiFactorException catch (e) {
      final resolver = e.resolver;
      if (resolver.hints.isNotEmpty) {
        final phoneHint = resolver.hints.first as PhoneMultiFactorInfo;
        final session = resolver.session;
        final completer = Completer<UserCredential>();

        await _auth.verifyPhoneNumber(
          multiFactorInfo: phoneHint,
          multiFactorSession: session,
          verificationCompleted: (_) {},
          verificationFailed: (error) {
            print("❌ MFA failed: ${error.code}");
            if (!completer.isCompleted) completer.completeError(error);
          },
          codeSent: (verificationId, _) async {
            final smsCode = await getCodeFromUser(verificationId);
            try {
              final credential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: smsCode,
              );
              final assertion =
                  PhoneMultiFactorGenerator.getAssertion(credential);
              final result = await resolver.resolveSignIn(assertion);
              if (!completer.isCompleted) completer.complete(result);
            } catch (e) {
              if (!completer.isCompleted) completer.completeError(e);
            }
          },
          codeAutoRetrievalTimeout: (_) {},
        );

        return completer.future;
      }
    } catch (e) {
      print("❌ Sign in error: $e");
    }

    return null;
  }

  /// MFA Enrollment
  Future<void> enrollSmsMfa({
    required String phoneNumber,
    required Future<String> Function(String verificationId) getCodeFromUser,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not signed in");

    final session = await user.multiFactor.getSession();
    final completer = Completer<void>();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      multiFactorSession: session,
      verificationCompleted: (_) {},
      verificationFailed: (e) {
        print("❌ Enroll error: ${e.message}");
        if (!completer.isCompleted) completer.completeError(e);
      },
      codeSent: (verificationId, _) async {
        final smsCode = await getCodeFromUser(verificationId);
        try {
          final credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );
          final assertion = PhoneMultiFactorGenerator.getAssertion(credential);
          await user.multiFactor.enroll(assertion, displayName: 'SMS Factor');
          if (!completer.isCompleted) completer.complete();
        } catch (e) {
          if (!completer.isCompleted) completer.completeError(e);
        }
      },
      codeAutoRetrievalTimeout: (_) {},
    );

    return completer.future;
  }

  /// Reauthenticate user (normal, non-MFA)
  Future<bool> reauthenticate(String email, String password) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await _auth.currentUser?.reauthenticateWithCredential(credential);
      print("🔐 Reauthentication successful");
      return true;
    } on FirebaseAuthException catch (e) {
      print("❌ Reauthentication failed: ${e.code} - ${e.message}");
      return false;
    }
  }

  /// Reauthenticate with MFA support
  Future<bool> reauthenticateWithMfa({
    required String email,
    required String password,
    required Future<String> Function(String verificationId) getCodeFromUser,
  }) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      await _auth.currentUser?.reauthenticateWithCredential(credential);
      print("🔐 Reauthenticated (no MFA required)");
      return true;
    } on FirebaseAuthMultiFactorException catch (e) {
      print("⚠️ MFA reauthentication required: ${e.code} - ${e.message}");
      final resolver = e.resolver;

      if (resolver.hints.isNotEmpty) {
        final phoneHint = resolver.hints.first as PhoneMultiFactorInfo;
        final session = resolver.session;

        final completer = Completer<bool>();

        await _auth.verifyPhoneNumber(
          multiFactorInfo: phoneHint,
          multiFactorSession: session,
          verificationCompleted: (_) {},
          verificationFailed: (error) {
            print("❌ MFA reauth failed: ${error.message}");
            if (!completer.isCompleted) completer.complete(false);
          },
          codeSent: (verificationId, _) async {
            final smsCode = await getCodeFromUser(verificationId);
            try {
              final phoneCredential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: smsCode,
              );
              final assertion =
                  PhoneMultiFactorGenerator.getAssertion(phoneCredential);
              await resolver.resolveSignIn(assertion);
              print("✅ MFA reauthentication completed");
              if (!completer.isCompleted) completer.complete(true);
            } catch (e) {
              print("❌ Error resolving MFA reauth: $e");
              if (!completer.isCompleted) completer.complete(false);
            }
          },
          codeAutoRetrievalTimeout: (_) {},
        );

        return completer.future;
      }

      return false;
    } catch (e) {
      print("❌ Unexpected error in MFA reauthentication: $e");
      return false;
    }
  }

  /// Password reset
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print("📩 Password reset email sent to $email");
      return true;
    } on FirebaseAuthException catch (e) {
      print("❌ Failed to send password reset email: ${e.code} - ${e.message}");
      return false;
    } catch (e) {
      print("❌ Unexpected error: $e");
      return false;
    }
  }

  /// Getter
  User? get currentUser => _auth.currentUser;

  Future<void> signOut() async => await _auth.signOut();
}
