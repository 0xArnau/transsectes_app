import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';

/// A data source interface for handling raw operations with the transects database.
abstract class TransectDataSource {
  /// Fetches all transects from the database.
  ///
  /// Returns a [Stream] of [Result] containing either a [List] of [TransectEntity]
  /// on success or an error message on failure.
  Stream<Result<List<TransectEntity>, DataError>> fetchAllTransects();

  /// Fetches all transects created by a specific user from the database.
  ///
  /// [userEmail]: The email of the user whose transects are to be fetched.
  /// Returns a [Stream] of [Result] containing either a [List] of [TransectEntity]
  /// on success or an error message on failure.
  Stream<Result<List<TransectEntity>, DataError>> fetchUserTransects(
      String? userEmail);

  /// Adds a new transect to the database.
  ///
  /// [transect]: The [TransectEntity] to be added.
  /// Returns a [Result] containing `void` on success or an error message on failure.
  Future<Result<void, DataError>> insertTransect(TransectEntity transect);

  /// Removes all transects from the database.
  ///
  /// Returns a [Result] containing `void` on success or an error message on failure.
  Future<Result<void, DataError>> clearAllTransects();

  /// Searches for a document ID by its creator and creation timestamp in the database.
  ///
  /// [createdBy]: The email of the user who created the transect.
  /// [createdAt]: The [Timestamp] when the transect was created.
  /// Returns a [Result] containing the document ID as a [String] on success
  /// or an error message on failure.
  Future<Result<String, DataError>> searchDocumentId(
      String createdBy, Timestamp createdAt);

  /// Updates an existing transect in the database.
  ///
  /// [transect]: The [TransectEntity] containing the updated data.
  /// Returns a [Result] containing `void` on success or an error message on failure.
  Future<Result<void, DataError>> updateTransectData(TransectEntity transect);
}
