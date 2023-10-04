import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:stepper/bloc/app/failture.dart';
import 'package:stepper/repository.dart';
import '/model/user.dart';

part 'event.dart';
part 'state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.initial()) {
    on<AppSignUp>(signUp);
    on<AppLogin>(logInWithEmailAndPassword);
    on<AppLogout>(logOut);
    on<AddAchievement>(addAchievement);
  }

  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

  Future<void> signUp(AppSignUp event, Emitter<AppState> emit) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      User newUser = User(
        email: _firebaseAuth.currentUser?.email,
        name: _firebaseAuth.currentUser?.displayName,
        photo: _firebaseAuth.currentUser?.photoURL,
        items: [],
      );
      emit(AppState(status: 'authenticated', user: newUser));
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> logInWithEmailAndPassword(
      AppLogin event, Emitter<AppState> emit) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      User newUser = User(
        email: _firebaseAuth.currentUser?.email,
        name: _firebaseAuth.currentUser?.displayName,
        photo: _firebaseAuth.currentUser?.photoURL,
        items: await Repository().fetchUserItems(),
      );
      emit(AppState(status: 'authenticated', user: newUser));
      emit(const AppState(status: 'authenticated'));
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logOut(AppLogout event, Emitter<AppState> emit) async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
      emit(const AppState(status: 'unauthenticated', user: User()));
    } catch (_) {
      // throw LogOutFailure();
    }
  }

  void addAchievement(AddAchievement event, Emitter<AppState> emit) async {
    await Repository().addAchivement(event.index);
    User newUser = User(
      email: _firebaseAuth.currentUser?.email,
      name: _firebaseAuth.currentUser?.displayName,
      photo: _firebaseAuth.currentUser?.photoURL,
      items: await Repository().fetchUserItems(),
    );
    emit(AppState(status: 'authenticated', user: newUser));
  }
}
