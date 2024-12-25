import 'package:transsectes_app/app/features/transects/domain/repositories/transect_repository.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Use case for finding a document by the creator's email and creation timestamp.
///
/// This class defines the logic for finding a specific transect document in the repository.
/// It returns a [Result] containing the document ID as a [String] on success
/// or an error message on failure.
class FindDocumentUseCase {
  final TransectRepository repository;

  /// Constructor for the use case, accepts an instance of the [TransectRepository].
  FindDocumentUseCase(this.repository);

  /// Executes the logic to find a document.
  ///
  /// Accepts a [createdBy] (email) and [createdAt] (timestamp), then calls the repository to find the document ID.
  /// Returns a [Result] containing the document ID as a [String] on success,
  /// or an error message if the operation fails.
  Future<Result<String, DataError>> execute(
      String createdBy, Timestamp createdAt) async {
    return await repository.findDocument(createdBy, createdAt);
  }
}
