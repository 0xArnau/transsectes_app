import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/features/auth/data/datasources/auth_firebase_datasource_impl.dart';
import 'package:transsectes_app/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:transsectes_app/app/features/auth/domain/datasources/auth_datasource.dart';
import 'package:transsectes_app/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/is_user_authenticated_usecase.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/sign_up_usecase.dart';

/// Provider for AuthDatasource
final authDataSourceProvider = Provider<AuthDatasource>((ref) {
  return AuthFirebaseDatasourceImpl();
});

/// Provider for AuthRepository, which depends on AuthDatasource
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authDataSource = ref.watch(authDataSourceProvider);
  return AuthRepositoryImpl(authDatasource: authDataSource);
});

/// Provider for SignUpUseCase, which depends on AuthRepository
final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignUpUseCase(authRepository);
});

/// Provider for SignInUseCase, which depends on AuthRepository
final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignInUseCase(authRepository);
});

/// Provider for SignOutUseCase, which depends on AuthRepository
final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignOutUseCase(authRepository);
});

/// Provider for SignOutUseCase, which depends on AuthRepository
final isUserAuthenticatedUseCaseProvider = Provider<IsUserAuthenticatedUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return IsUserAuthenticatedUseCase(authRepository);
});

/// Provider for SignOutUseCase, which depends on AuthRepository
final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GetCurrentUserUseCase(authRepository);
});
