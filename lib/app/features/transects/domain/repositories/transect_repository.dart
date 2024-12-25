import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';

/// The repository interface for handling domain-level transect operations.
abstract class TransectRepository {
  /// Retrieves all transects from the database.
  ///
  /// This method fetches all transects from the Firestore database as a stream.
  /// On success, it returns a [Stream] of [Result] containing a [List] of [TransectEntity].
  /// On failure, it returns a [Result.failure] containing a [DataError] message.
  ///
  /// Returns:
  /// - [Result.success] containing a [Stream] of [List<TransectEntity>] on success.
  /// - [Result.failure] containing a [DataError] if an error occurs.
  Result<Stream<List<TransectEntity>>, DataError> getAllTransects();

  /// Retrieves all transects created by a specific user from the database.
  ///
  /// [userEmail]: The email address of the user whose transects should be retrieved.
  ///
  /// This method returns a [Stream] of [Result] that emits either a [List] of [TransectEntity] on success
  /// or a [Result.failure] containing a [DataError] if the user’s transects cannot be fetched.
  ///
  /// Returns:
  /// - [Result.success] containing a [Stream] of [List<TransectEntity>] on success.
  /// - [Result.failure] containing a [DataError] if an error occurs or the [userEmail] is invalid.
  Result<Stream<List<TransectEntity>>, DataError> getUserTransects(
      String? userEmail);

  /// Adds a new transect.
  ///
  /// [transect]: The [TransectEntity] to be added.
  /// Returns a [Result] containing `void` on success or an error message on failure.
  Future<Result<void, DataError>> addTransect(TransectEntity transect);

  /// Removes all transects.
  ///
  /// Returns a [Result] containing `void` on success or an error message on failure.
  Future<Result<void, DataError>> removeAllTransects();

  /// Finds a document ID using the creator's email and creation timestamp.
  ///
  /// [createdBy]: The email of the user who created the transect.
  /// [createdAt]: The [Timestamp] when the transect was created.
  /// Returns a [Result] containing the document ID as a [String] on success
  /// or an error message on failure.
  Future<Result<String, DataError>> findDocument(
      String createdBy, Timestamp createdAt);

  /// Updates an existing transect.
  ///
  /// [transect]: The [TransectEntity] containing the updated data.
  /// Returns a [Result] containing `void` on success or an error message on failure.
  Future<Result<void, DataError>> updateTransect(TransectEntity transect);
}
