import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/auth/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<SignIn>((event, emit) async {
      Logger().d(event.toString());
      emit(const AuthLoading(isLoading: true));
      try {
        await repository.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        Logger().i('sign in successfully');
      } on FirebaseAuthException catch (e) {
        Logger().e(e.toString());
        switch (e.code) {
          case 'wrong-password':
            emit(AuthFailure(message: S.current.wrong_password));
            break;
          case 'invalid-email':
            emit(AuthFailure(message: S.current.invalid_email));
            break;
          case 'user-disabled':
            emit(AuthFailure(message: S.current.user_disabled));
            break;
          case 'user-not-found':
            emit(AuthFailure(message: S.current.user_not_found));
            break;
          default:
            emit(AuthFailure(message: e.message.toString()));
        }
      } catch (e) {
        Logger().e(e.toString());
        emit(AuthFailure(message: 'Error: ${e.toString()}'));
      }
      emit(const AuthLoading(isLoading: false));
    });

    on<SignOut>((event, emit) async {
      emit(const AuthLoading(isLoading: true));

      try {
        repository.singOut();
      } catch (e) {
        Logger().e(e.toString());
        emit(AuthFailure(message: 'Error: ${e.toString()}'));
      }
    });

    on<GetEmail>((event, emit) async {
      emit(const AuthLoading(isLoading: true));

      try {
        final String? email = await repository.getUserEmail();

        emit(AuthSuccess(value: email));
      } catch (e) {
        Logger().e(e.toString());
        emit(AuthFailure(message: 'Error: ${e.toString()}'));
      }
    });

    on<ResetPassword>((event, emit) async {
      emit(const AuthLoading(isLoading: true));

      try {
        await repository.resetPassword(email: event.email);

        emit(const AuthSuccess(value: null));
      } on FirebaseAuthException catch (e) {
        Logger().e(e.toString());
        switch (e.code) {
          default:
            emit(AuthFailure(message: e.message.toString()));
        }
      } catch (e) {
        Logger().e(e.toString());
        emit(AuthFailure(message: 'Error: ${e.toString()}'));
      }
    });

    on<SignUp>((event, emit) async {
      emit(const AuthLoading(isLoading: true));

      try {
        await repository.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        // TODO: Validate email (send an email)

        emit(const AuthSuccess(value: null));
      } on FirebaseAuthException catch (e) {
        Logger().e(e.toString());
        switch (e.code) {
          default:
            emit(AuthFailure(message: e.message.toString()));
        }
      } catch (e) {
        Logger().e(e.toString());
        emit(AuthFailure(message: 'Error: ${e.toString()}'));
      }
    });
  }
}
