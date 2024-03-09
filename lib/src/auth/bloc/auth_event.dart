part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUp extends AuthEvent {
  final String email;
  final String password;

  const SignUp({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignIn extends AuthEvent {
  final String email;
  final String password;

  const SignIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class GetEmail extends AuthEvent {}

class SignOut extends AuthEvent {}
