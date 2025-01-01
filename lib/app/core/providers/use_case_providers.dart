import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/features/auth/data/datasources/auth_firebase_datasource_impl.dart';
import 'package:transsectes_app/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:transsectes_app/app/features/auth/domain/datasources/auth_datasource.dart';
import 'package:transsectes_app/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/delete_user_account_usecase.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/is_email_verified_usecase.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/send_email_verification_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/get_address_from_coordinates_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/get_current_position_usecase.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/is_technician_usecase.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/is_user_authenticated_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/get_location_stream_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/request_location_permissions_usecase.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:transsectes_app/app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:transsectes_app/app/features/transects/data/datasources/local/file_datasource_impl.dart';
import 'package:transsectes_app/app/features/transects/data/datasources/local/geocoding_datasoure_impl.dart';
import 'package:transsectes_app/app/features/transects/data/datasources/local/geolocation_datasource_impl.dart';
import 'package:transsectes_app/app/features/transects/data/datasources/local/permission_datasource_impl.dart';
import 'package:transsectes_app/app/features/transects/data/datasources/remote/transect_firebase_datasource_impl.dart';
import 'package:transsectes_app/app/features/transects/data/repositories/file_repository_impl.dart';
import 'package:transsectes_app/app/features/transects/data/repositories/geolocation_repository_impl.dart';
import 'package:transsectes_app/app/features/transects/data/repositories/transect_repository_impl.dart';
import 'package:transsectes_app/app/features/transects/domain/datasources/file_datasource.dart';
import 'package:transsectes_app/app/features/transects/domain/datasources/geocoding_datasource.dart';
import 'package:transsectes_app/app/features/transects/domain/datasources/geolocation_datasource.dart';
import 'package:transsectes_app/app/features/transects/domain/datasources/permission_datasource.dart';
import 'package:transsectes_app/app/features/transects/domain/datasources/transect_datasource.dart';
import 'package:transsectes_app/app/features/transects/domain/repositories/file_repository.dart';
import 'package:transsectes_app/app/features/transects/domain/repositories/geolocation_repository.dart';
import 'package:transsectes_app/app/features/transects/domain/repositories/transect_repository.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/add_transect_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/find_document_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/get_all_transects_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/get_user_transects_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/remove_all_transects_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/save_transects_as_csv_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/update_transect_usecase.dart';

// DataSources

/// Provider for AuthDatasource
final authDataSourceProvider = Provider<AuthDatasource>((ref) {
  return AuthFirebaseDatasourceImpl();
});

/// Provider for TransectDataSource
final transectDataSourceProvider = Provider<TransectDataSource>((ref) {
  return TransectFirebaseDatasourceImpl();
});

/// Provider for TransectDataSource
final fileDatasourceProvider = Provider<FileDatasource>((ref) {
  return FileDatasourceImpl();
});

/// Provider for GeocodingDataSource
final geocodingDatasourceProvider = Provider<GeocodingDataSource>((ref) {
  return GeocodingDatasourceImpl();
});

/// Provider for GeolocationDataSource
final geolocationDatasourceProvider = Provider<GeolocationDataSource>((ref) {
  return GeolocationDatasourceImpl();
});

/// Provider for PermissionDataSource
final permissionDatasourceProvider = Provider<PermissionDataSource>((ref) {
  return PermissionDatasourceImpl();
});

// Repositories

/// Provider for AuthRepository, which depends on AuthDatasource
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authDataSource = ref.watch(authDataSourceProvider);
  return AuthRepositoryImpl(authDatasource: authDataSource);
});

/// Provider for TransectRepository, which depends on AuthDatasource
final transectRepositoryProvider = Provider<TransectRepository>((ref) {
  final transectDataSource = ref.watch(transectDataSourceProvider);
  return TransectRepositoryImpl(transectDataSource: transectDataSource);
});

/// Provider for FileRepository, which depends on FileDatasource
final fileRepositoryProvider = Provider<FileRepository>((ref) {
  final fileDatasource = ref.watch(fileDatasourceProvider);
  return FileRepositoryImpl(fileDatasource: fileDatasource);
});

/// Provider for GeolocationRepository, which depends on
/// PermissionDataSource, GeolocationDataSource & GeocodingDataSource
final geolocationRepositoryProvider = Provider<GeolocationRepository>((ref) {
  final permissionDatasource = ref.watch(permissionDatasourceProvider);
  final geolocationDatasource = ref.watch(geolocationDatasourceProvider);
  final geocodingDatasource = ref.watch(geocodingDatasourceProvider);
  return GeolocationRepositoryImpl(
    geolocationDataSource: geolocationDatasource,
    permissionDataSource: permissionDatasource,
    geocodingDataSource: geocodingDatasource,
  );
});

// UseCases

/// Provider for IsTechnicianUseCase, which depends on AuthRepository
final isTechnicianUseCaseProvider = Provider<IsTechnicianUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return IsTechnicianUseCase(authRepository);
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
final isUserAuthenticatedUseCaseProvider =
    Provider<IsUserAuthenticatedUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return IsUserAuthenticatedUseCase(authRepository);
});

/// Provider for SignOutUseCase, which depends on AuthRepository
final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GetCurrentUserUseCase(authRepository);
});

/// Provider for DeleteUserAccountUsecase, which depends on AuthRepository
final deleteUserAccountUsecaseProvider =
    Provider<DeleteUserAccountUsecase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return DeleteUserAccountUsecase(authRepository);
});

/// Provider for GetAllTransectsUseCase, which depends on TransectRepository
final getAllTransectsUseCaseProvider = Provider<GetAllTransectsUseCase>((ref) {
  final transectRepository = ref.watch(transectRepositoryProvider);
  return GetAllTransectsUseCase(transectRepository);
});

/// Provider for GetUserTransectsUseCase, which depends on TransectRepository
final getUserTransectsUseCaseProvider =
    Provider<GetUserTransectsUseCase>((ref) {
  final transectRepository = ref.watch(transectRepositoryProvider);
  return GetUserTransectsUseCase(transectRepository);
});

/// Provider for AddTransectUseCase, which depends on TransectRepository
final addTransectUseCaseProvider = Provider<AddTransectUseCase>((ref) {
  final transectRepository = ref.watch(transectRepositoryProvider);
  return AddTransectUseCase(transectRepository);
});

/// Provider for RemoveAllTransectsUseCase, which depends on TransectRepository
final removeAllTransectsUseCaseProvider =
    Provider<RemoveAllTransectsUseCase>((ref) {
  final transectRepository = ref.watch(transectRepositoryProvider);
  return RemoveAllTransectsUseCase(transectRepository);
});

/// Provider for FindDocumentUseCase, which depends on TransectRepository
final findDocumentUseCaseProvider = Provider<FindDocumentUseCase>((ref) {
  final transectRepository = ref.watch(transectRepositoryProvider);
  return FindDocumentUseCase(transectRepository);
});

/// Provider for UpdateTransectUseCase, which depends on TransectRepository
final updateTransectUseCaseProvider = Provider<UpdateTransectUseCase>((ref) {
  final transectRepository = ref.watch(transectRepositoryProvider);
  return UpdateTransectUseCase(transectRepository);
});

/// Provider for UpdateTransectUseCase, which depends on TransectRepository
final saveTransectsAsCsvUsecaseProvider =
    Provider<SaveTransectsAsCsvUsecase>((ref) {
  final fileRepository = ref.watch(fileRepositoryProvider);
  return SaveTransectsAsCsvUsecase(fileRepository);
});

/// Provider for GetCurrentPositionUseCase, which depends on GeolocationRepository
final getCurrentPositionUseCaseProvider =
    Provider<GetCurrentPositionUseCase>((ref) {
  final geolocationRepository = ref.watch(geolocationRepositoryProvider);
  return GetCurrentPositionUseCase(geolocationRepository);
});

/// Provider for GetLocationStreamUseCase, which depends on GeolocationRepository
final getLocationStreamUseCaseProvider =
    Provider<GetLocationStreamUseCase>((ref) {
  final geolocationRepository = ref.watch(geolocationRepositoryProvider);
  return GetLocationStreamUseCase(geolocationRepository);
});

/// Provider for RequestLocationPermissionsUseCase, which depends on GeolocationRepository
final requestLocationPermissionsUseCaseProvider =
    Provider<RequestLocationPermissionsUseCase>((ref) {
  final geolocationRepository = ref.watch(geolocationRepositoryProvider);
  return RequestLocationPermissionsUseCase(geolocationRepository);
});

/// Provider for GetAddressFromCoordinatesUseCase, which depends on GeolocationRepository
final getAddressFromCoordinatesUseCaseProvider =
    Provider<GetAddressFromCoordinatesUseCase>((ref) {
  final geolocationRepository = ref.watch(geolocationRepositoryProvider);
  return GetAddressFromCoordinatesUseCase(geolocationRepository);
});

/// Provider for IsEmailVerifiedUseCase, which depends on AuthRepository
final isEmailVerifiedUseCaseProvider = Provider<IsEmailVerifiedUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return IsEmailVerifiedUseCase(authRepository);
});

/// Provider for SendEmailVerificationUsecase, which depends on AuthRepository
final sendEmailVerificationUsecaseProvider =
    Provider<SendEmailVerificationUsecase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SendEmailVerificationUsecase(authRepository);
});
