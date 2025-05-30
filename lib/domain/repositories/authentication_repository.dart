import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb, visibleForTesting;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;

import '../../app/models/models.dart' show User, UserData;
import 'repositories.dart' show UsersRepository;

/// Thrown during the sign up process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.code = 'unknown',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  String getErrorMessage(final AppLocalizations localizations) {
    switch (code) {
      case 'invalid-email':
        return localizations.invalidEmail;
      case 'user-disabled':
        return localizations.userDisabled;
      case 'email-already-in-use':
        return localizations.emailAlreadyInUse;
      case 'operation-not-allowed':
        return localizations.operationNotAllowed;
      case 'weak-password':
        return localizations.weakPassword;
      default:
        return localizations.signUpError;
    }
  }

  /// The error code.
  final String code;

  @override
  String toString() => code;
}

/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
class LogInWithEmailAndPasswordFailure implements Exception {
  const LogInWithEmailAndPasswordFailure([
    this.code = 'unknown',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  String getErrorMessage(final AppLocalizations localizations) {
    switch (code) {
      case 'invalid-email':
        return localizations.invalidEmail;
      case 'user-disabled':
        return localizations.userDisabled;
      case 'user-not-found':
        return localizations.userNotFound;
      case 'wrong-password':
        return localizations.wrongPassword;
      default:
        return localizations.logInError;
    }
  }

  // The error code
  final String code;

  @override
  String toString() => code;
}

/// Thrown during the anonymous sign in process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInAnonymously.html
class AnonymousSignInFailure implements Exception {
  const AnonymousSignInFailure([
    this.code = 'unknown',
  ]);

  /// Crea un mensaje de error
  /// a partir de un código de excepción de firebase_auth.
  String getErrorMessage(final AppLocalizations localizations) {
    switch (code) {
      case 'operation-not-allowed':
        return localizations.operationNotAllowed;
      default:
        return localizations.logInError;
    }
  }

  /// El código de error.
  final String code;

  @override
  String toString() => code;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// Repository which manages user authentication.
class AuthenticationRepository {
  AuthenticationRepository({
    final firebase_auth.FirebaseAuth? firebaseAuth,
    required final UsersRepository usersRepository,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _usersRepository = usersRepository;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final UsersRepository _usersRepository;

  /// Whether or not the current environment is web
  /// Should only be overridden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  @visibleForTesting
  bool isWeb = kIsWeb;

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  Stream<Future<User?>> get user => _firebaseAuth.authStateChanges().map(
        (
          final firebase_auth.User? firebaseUser,
        ) async =>
            firebaseUser?.toUser(_usersRepository),
      );

  Future<User?> get currentUser async {
    final User? user =
        await _firebaseAuth.currentUser?.toUser(_usersRepository);
    return user;
  }

  Future<void> deleteCurrentUser() async {
    await _firebaseAuth.currentUser?.delete();
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUp({
    required final String email,
    required final String password,
    required final UserData userData,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
    await _usersRepository.updateUserData(
      uid: _firebaseAuth.currentUser!.uid,
      userData: userData,
    );
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required final String email,
    required final String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  /// Signs in anonymously.
  ///
  /// Throws a [AnonymousSignInFailure] if an exception occurs.
  Future<void> logInAnonymously() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AnonymousSignInFailure(e.code);
    } catch (_) {
      throw const AnonymousSignInFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait(<Future<void>>[
        _firebaseAuth.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  /// Maps a [firebase_auth.User] into a [User].
  Future<User> toUser(final UsersRepository usersRepository) async {
    if (email != null && email!.isNotEmpty) {
      final UserData data = await usersRepository.fetchUserData(uid: uid);
      return User(
        uid: uid,
        email: email!,
        data: data,
      );
    }
    return User(
      uid: uid,
      email: email ?? '',
    );
  }
}
