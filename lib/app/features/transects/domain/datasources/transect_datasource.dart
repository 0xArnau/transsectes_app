import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';

/// A data source interface for handling raw operations with the transects database.
abstract class TransectDataSource {
  /// Fetches all transects from the database.
  ///
  /// This method retrieves all transects from the Firestore database as a stream.
  /// On success, it returns a [Stream] of [Result] containing a [List] of [TransectEntity].
  /// On failure, it returns a [Result.failure] containing an error message.
  ///
  /// Returns:
  /// - [Result.success] containing a [Stream] of [List<TransectEntity>] on success.
  /// - [Result.failure] containing a [DataError] if an error occurs.
  Result<Stream<List<TransectEntity>>, DataError> fetchAllTransects();

  /// Fetches all transects created by a specific user from the database.
  ///
  /// This method retrieves the transects created by a specific user based on their email.
  /// It returns a stream that will emit either a [List] of [TransectEntity] on success or an error message on failure.
  ///
  /// [userEmail]: The email address of the user whose transects should be fetched.
  ///
  /// Returns:
  /// - [Result.success] containing a [Stream] of [List<TransectEntity>] on success.
  /// - [Result.failure] containing a [DataError] if the [userEmail] is invalid or any other error occurs.
  Result<Stream<List<TransectEntity>>, DataError> fetchUserTransects(
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
