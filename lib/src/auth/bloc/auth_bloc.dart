import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/web.dart';
import 'package:transsectes_app/src/auth/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository = AuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<SignIn>((event, emit) async {
      Logger().d("on SignIn ");

      emit(AuthLoading(isLoading: true));
      try {
        await repository.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        final String? userEmail = await repository.getUserEmail();

        if (userEmail != null) {
          emit(AuthSuccess(email: userEmail));
        } else {
          emit(AuthFailure(message: 'User creation failed'));
        }
      } catch (e) {
        Logger().e(e.toString());
        emit(AuthFailure(message: 'Error: ${e.toString()}'));
      }
      emit(AuthLoading(isLoading: false));
    });

    on<SignOut>((event, emit) {
      emit(AuthLoading(isLoading: true));

      try {
        repository.singOut();
      } catch (e) {
        Logger().e(e.toString());
        emit(AuthFailure(message: 'Error: ${e.toString()}'));
      }

      emit(AuthLoading(isLoading: true));
    });
  }
}
