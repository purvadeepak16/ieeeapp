import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ieee_app/core/auth/auth_provider.dart';

class AuthUiState {
  const AuthUiState({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  AuthUiState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return AuthUiState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage:
          clearSuccess ? null : (successMessage ?? this.successMessage),
    );
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthUiState>((ref) {
  return AuthController(ref);
});

class AuthController extends StateNotifier<AuthUiState> {
  AuthController(this._ref) : super(const AuthUiState());

  final Ref _ref;

  Future<bool> signIn({required String email, required String password}) async {
    return _run(() async {
      final repository = _ref.read(authRepositoryProvider);
      final credential = await repository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.reload();
      await repository.syncCurrentUserDocument();

      final isVerified =
          FirebaseAuth.instance.currentUser?.emailVerified ?? false;
      if (!isVerified) {
        state = state.copyWith(
          successMessage: 'Login successful. Please verify your email first.',
        );
      }
      return isVerified;
    });
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return _run(() async {
      final repository = _ref.read(authRepositoryProvider);
      await repository.registerWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
      state = state.copyWith(
        successMessage:
            'Account created. Verification mail sent. Please verify your email.',
      );
      return true;
    });
  }

  Future<void> sendPasswordReset({required String email}) async {
    await _run(() async {
      final repository = _ref.read(authRepositoryProvider);
      await repository.sendPasswordResetEmail(email: email);
      state = state.copyWith(
        successMessage: 'Password reset email has been sent.',
      );
      return true;
    });
  }

  Future<void> resendVerificationEmail() async {
    await _run(() async {
      final repository = _ref.read(authRepositoryProvider);
      await repository.sendEmailVerification();
      state = state.copyWith(
        successMessage: 'Verification email sent again.',
      );
      return true;
    });
  }

  Future<bool> refreshVerificationStatus() async {
    return _run(() async {
      final repository = _ref.read(authRepositoryProvider);
      await repository.reloadCurrentUser();
      await repository.syncCurrentUserDocument();
      final isVerified = repository.currentUser?.emailVerified ?? false;
      if (!isVerified) {
        state = state.copyWith(
          errorMessage:
              'Email is not verified yet. Please open your inbox and verify.',
        );
      }
      return isVerified;
    });
  }

  Future<void> signOut() async {
    await _run(() async {
      final repository = _ref.read(authRepositoryProvider);
      await repository.signOut();
      return true;
    });
  }

  void clearMessages() {
    state = state.copyWith(clearError: true, clearSuccess: true);
  }

  Future<T> _run<T>(Future<T> Function() action) async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
      clearSuccess: true,
    );

    try {
      final result = await action();
      state = state.copyWith(isLoading: false);
      return result;
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _friendlyAuthError(e),
      );
      rethrow;
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Something went wrong. Please try again.',
      );
      rethrow;
    }
  }

  String _friendlyAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account is disabled.';
      case 'user-not-found':
        return 'No user found for this email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'weak-password':
        return 'Password should be at least 6 characters.';
      case 'too-many-requests':
        return 'Too many attempts. Please wait and try again.';
      default:
        return e.message ?? 'Authentication failed. Please try again.';
    }
  }
}
