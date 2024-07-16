part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {
  final bool isLoading;

  const AuthLoading({required this.isLoading});
}

final class AuthSuccess extends AuthState {
  final String? value;

  const AuthSuccess({required this.value});

  @override
  List<Object> get props => [value ?? ''];
}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}
