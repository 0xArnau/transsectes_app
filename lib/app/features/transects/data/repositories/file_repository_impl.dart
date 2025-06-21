import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/datasources/file_datasource.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';
import 'package:transsectes_app/app/features/transects/domain/repositories/file_repository.dart';

class FileRepositoryImpl implements FileRepository {
  final FileDatasource _fileDatasource;

  FileRepositoryImpl({required FileDatasource fileDatasource})
      : _fileDatasource = fileDatasource;

  @override
  Future<Result<String, DataError>> saveReportsAsCsv({
    required List<TransectEntity> reports,
    required String locality,
  }) {
    return _fileDatasource.saveReportsAsCsv(
      reports: reports,
      locality: locality,
    );
  }

  @override
  Future<Result<String, DataError>> savePdfFromAssets({
    required String assetPath,
    required String fileName,
  }) {
    return _fileDatasource.savePdfFromAssets(
      assetPath: assetPath,
      fileName: fileName,
    );
  }
}
