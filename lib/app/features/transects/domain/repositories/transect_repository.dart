import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';

/// The repository interface for handling domain-level transect operations.
abstract class TransectRepository {
  /// Retrieves all transects.
  ///
  /// Returns a [Stream] of [Result] containing a [List] of [TransectEntity] on success
  /// or an error message on failure.
  Stream<Result<List<TransectEntity>, DataError>> getAllTransects();

  /// Retrieves all transects for a specific user.
  ///
  /// [userEmail]: The email of the user whose transects are to be retrieved.
  /// Returns a [Stream] of [Result] containing a [List] of [TransectEntity] on success
  /// or an error message on failure.
  Stream<Result<List<TransectEntity>, DataError>> getUserTransects(
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
