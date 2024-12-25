import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/datasources/transect_datasource.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';

/// Implementation of [TransectDataSource] that interacts with Firestore.
///
/// This class provides methods to interact with Firestore for transect data,
/// including fetching, inserting, updating, and deleting transects. It uses
/// Firestore's real-time snapshot capabilities and handles data transformation
/// between Firestore documents and [TransectEntity] objects. Error handling is
/// performed using the [Result] class to wrap success or failure responses.
///
/// Example usage:
/// ```dart
/// final datasource = TransectFirebaseDatasourceImpl();
/// final result = await datasource.insertTransect(transect);
/// result.fold(
///   (error) => print('Error: $error'),
///   (success) => print('Transect inserted'),
/// );
/// ```
class TransectFirebaseDatasourceImpl implements TransectDataSource {
  final FirebaseFirestore _firebaseFirestore;

  TransectFirebaseDatasourceImpl({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<Result<void, DataError>> clearAllTransects() async {
    try {
      // Fetch all documents from the transects collection
      CollectionReference collectionRef =
          _firebaseFirestore.collection('transects');
      QuerySnapshot querySnapshot = await collectionRef.get();

      // Iterate through documents and delete them
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Logger().d('Deleting ${doc.data()}');
        await doc.reference.delete().whenComplete(() => Logger().d('Deleted'));
      }

      return Result.success(null);
    } catch (e) {
      Logger().e(e);
      return Result.failure(RemoteError(RemoteErrorType.unknown));
    }
  }

  @override
  Result<Stream<List<TransectEntity>>, DataError> fetchAllTransects() {
    try {
      // Return a Result.success containing the Stream of transects
      final stream =
          _firebaseFirestore.collection('transects').snapshots().map((event) {
        // Transform Firestore documents into TransectEntity objects
        final transects =
            event.docs.map((e) => TransectEntity.fromSnapshot(e)).toList();
        return transects; // Return the list of transects
      });

      // Return the stream wrapped in a Result.success
      return Result.success(stream);
    } catch (e) {
      // Log the error
      Logger().e(e);

      // Return a Result.failure with an unknown RemoteError in case of failure
      return Result.failure(RemoteError(RemoteErrorType.unknown));
    }
  }

  @override
  Result<Stream<List<TransectEntity>>, DataError> fetchUserTransects(
      String? userEmail) {
    if (userEmail == null) {
      // Log and return a failure if the user email is null
      Logger().e('Email is null');
      return Result.failure(RemoteError(RemoteErrorType.unknown));
    }

    try {
      // Return a Result.success containing the Stream of user-specific transects
      final stream = _firebaseFirestore
          .collection('transects')
          .where('createdBy', isEqualTo: userEmail)
          .snapshots()
          .map((event) {
        // Transform Firestore documents into TransectEntity objects
        final transects =
            event.docs.map((e) => TransectEntity.fromSnapshot(e)).toList();
        return transects; // Return the list of transects
      });

      // Return the stream wrapped in a Result.success
      return Result.success(stream);
    } catch (e) {
      // Log the error
      Logger().e(e);

      // Return a Result.failure with an unknown RemoteError in case of failure
      return Result.failure(RemoteError(RemoteErrorType.unknown));
    }
  }

  @override
  Future<Result<void, DataError>> insertTransect(
      TransectEntity transect) async {
    try {
      await _firebaseFirestore
          .collection('transects')
          .add(transect.toDocument()); // Add the transect document to Firestore

      return Result.success(null);
    } catch (e) {
      Logger().e('Error adding document: $e');
      return Result.failure(RemoteError(RemoteErrorType.unknown));
    }
  }

  @override
  Future<Result<String, DataError>> searchDocumentId(
      String createdBy, Timestamp createdAt) async {
    try {
      // Perform the query to find the document by createdBy and createdAt fields
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('transects')
          .where('createdBy', isEqualTo: createdBy)
          .where('createdAt', isEqualTo: createdAt)
          .get();

      // Check if any document was found
      if (querySnapshot.docs.isNotEmpty) {
        // Return the first document ID if found
        String documentId = querySnapshot.docs.first.id;
        Logger().i('Document found with ID: $documentId');
        return Result.success(documentId);
      }

      Logger().e('No document found with the specified criteria.');
      return Result.failure(RemoteError(RemoteErrorType.unknown));
    } catch (e) {
      Logger().e('Error finding document: $e');
      return Result.failure(RemoteError(RemoteErrorType.unknown));
    }
  }

  @override
  Future<Result<void, DataError>> updateTransectData(
      TransectEntity transect) async {
    // Search for the document ID based on the transect's createdBy and createdAt values
    final response =
        await searchDocumentId(transect.createdBy, transect.createdAt);

    // If the search fails or no document is found, return failure
    if (response.isFailure || response.value == null) {
      Logger().e('Error finding the document');
      return Result.failure(RemoteError(RemoteErrorType.unknown));
    }

    String documentId = response.value!;

    try {
      // Update the Firestore document with the new transect data
      await _firebaseFirestore
          .collection('transects')
          .doc(documentId)
          .update(transect.toDocument());

      Logger().d('Document updated successfully.');
      return Result.success(null);
    } catch (e) {
      Logger().e('Error updating document: $e');
      return Result.failure(RemoteError(RemoteErrorType.unknown));
    }
  }
}
