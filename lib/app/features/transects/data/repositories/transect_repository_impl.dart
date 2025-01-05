import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/datasources/transect_datasource.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';
import 'package:transsectes_app/app/features/transects/domain/repositories/transect_repository.dart';

class TransectRepositoryImpl implements TransectRepository {
  final TransectDataSource _transectDataSource;

  TransectRepositoryImpl({required TransectDataSource transectDataSource})
      : _transectDataSource = transectDataSource;

  @override
  Future<Result<void, DataError>> addTransect(TransectEntity transect) {
    return _transectDataSource.insertTransect(transect);
  }

  @override
  Future<Result<String, DataError>> findDocument(
      String createdBy, Timestamp createdAt) {
    return _transectDataSource.searchDocumentId(createdBy, createdAt);
  }

  @override
  Result<Stream<List<TransectEntity>>, DataError> getAllTransects() {
    return _transectDataSource.fetchAllTransects();
  }

  @override
  Result<Stream<List<TransectEntity>>, DataError> getUserTransects(
      String? userEmail) {
    return _transectDataSource.fetchUserTransects(userEmail);
  }

  @override
  Future<Result<void, DataError>> removeAllTransects() {
    return _transectDataSource.clearAllTransects();
  }

  @override
  Future<Result<void, DataError>> updateTransect(TransectEntity transect) {
    return _transectDataSource.updateTransectData(transect);
  }
}
