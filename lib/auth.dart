// import 'dart:async';

// import 'package:cache/cache.dart';
// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
// import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:google_sign_in/google_sign_in.dart';

// import 'models/user.dart';

// class SignUpWithEmailAndPasswordFailure implements Exception {
//   const SignUpWithEmailAndPasswordFailure([
//     this.message = 'An unknown exception occurred.',
//   ]);

//   final String message;
// }

// class LogInWithEmailAndPasswordFailure implements Exception {
//   const LogInWithEmailAndPasswordFailure([
//     this.message = 'An unknown exception occurred.',
//   ]);

//   final String message;
// }

// class LogInWithGoogleFailure implements Exception {
//   const LogInWithGoogleFailure([
//     this.message = 'An unknown exception occurred.',
//   ]);

//   final String message;
// }

// class LogOutFailure implements Exception {}

// class AuthenticationRepository {
//   AuthenticationRepository({
//     CacheClient? cache,
//     firebase_auth.FirebaseAuth? firebaseAuth,
//     GoogleSignIn? googleSignIn,
//   })  : _cache = cache ?? CacheClient(),
//         _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
//         _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),

//   final CacheClient _cache;
//   final firebase_auth.FirebaseAuth _firebaseAuth;
//   final GoogleSignIn _googleSignIn;

//   @visibleForTesting
//   bool isWeb = kIsWeb;

//   @visibleForTesting
//   static const userCacheKey = '__user_cache_key__';

//   Stream<User> get user {
//     return _firebaseAuth.authStateChanges().map((firebaseUser) {
//       final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
//       _cache.write(key: userCacheKey, value: user);
//       return user;
//     });
//   }

//   User get currentUser {
//     return _cache.read<User>(key: userCacheKey) ?? User.empty;
//   }

//   Future<void> signUp({required String email, required String password}) async {
//     try {
//       await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } on FirebaseAuthException catch (e) {
//       throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
//     } catch (_) {
//       throw const SignUpWithEmailAndPasswordFailure();
//     }
//   }

//   Future<void> logInWithGoogle() async {
//     try {
//       late final firebase_auth.AuthCredential credential;
//       if (isWeb) {
//         final googleProvider = firebase_auth.GoogleAuthProvider();
//         final userCredential = await _firebaseAuth.signInWithPopup(
//           googleProvider,
//         );
//         credential = userCredential.credential!;
//       } else {
//         final googleUser = await _googleSignIn.signIn();
//         final googleAuth = await googleUser!.authentication;
//         credential = firebase_auth.GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );
//       }

//       await _firebaseAuth.signInWithCredential(credential);
//     } on FirebaseAuthException catch (e) {
//       throw LogInWithGoogleFailure.fromCode(e.code);
//     } catch (_) {
//       throw const LogInWithGoogleFailure();
//     }
//   }

//   Future<void> logInWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } on FirebaseAuthException catch (e) {
//       throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
//     } catch (_) {
//       throw const LogInWithEmailAndPasswordFailure();
//     }
//   }

//   Future<void> logOut() async {
//     try {
//       await Future.wait([
//         _firebaseAuth.signOut(),
//         _googleSignIn.signOut(),
//       ]);
//     } catch (_) {
//       throw LogOutFailure();
//     }
//   }
// }

// extension on firebase_auth.User {
//   User get toUser {
//     return User(id: uid, email: email, name: displayName, photo: photoURL);
//   }
// }
