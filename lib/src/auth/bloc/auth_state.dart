part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {
  final bool isLoading;

  AuthLoading({required this.isLoading});
}

final class AuthSuccess extends AuthState {
  final String? value;

  AuthSuccess({required this.value});

  @override
  List<Object> get props => [value ?? ''];
}

final class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}
