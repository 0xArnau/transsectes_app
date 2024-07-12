import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';
import 'package:transsectes_app/src/transects/repositories/transects/base_repository.dart';

class TransectRepository extends BaseRepository {
  final FirebaseFirestore _firebaseFirestore;

  TransectRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<TransectModel>> getAllTransects() {
    return _firebaseFirestore.collection('transects').snapshots().map((event) {
      return event.docs.map((e) => TransectModel.fromSnapshot(e)).toList();
    });
  }

  @override
  Stream<List<TransectModel>> getUserTransects(String? userEmail) {
    if (userEmail == null) return const Stream<List<TransectModel>>.empty();

    return _firebaseFirestore
        .collection('transects')
        .where('createdBy', isEqualTo: userEmail)
        .snapshots()
        .map((event) {
      return event.docs.map((e) => TransectModel.fromSnapshot(e)).toList();
    });
  }

  @override
  Future<void> addTransect(TransectModel transect) {
    return _firebaseFirestore
        .collection('transects')
        .add(transect.toDocument());
  }

  @override
  void removeAllTransects() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('transects');
    QuerySnapshot querySnapshot = await collectionRef.get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Logger().d("Deleting ${doc.data()}");
      await doc.reference.delete().whenComplete(() => Logger().d("Deleted"));
    }
  }

  @override
  Future<String> findDocument(String createdBy, Timestamp createdAt) async {
    String documentId = '';
    try {
      // Realizar la consulta
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('transects')
          .where('createdBy', isEqualTo: createdBy)
          .where('createdAt', isEqualTo: createdAt)
          .get();

      // Verificar si se encontró algún documento
      if (querySnapshot.docs.isNotEmpty) {
        // Obtener el primer documento encontrado
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        // Obtener el ID del documento
        documentId = documentSnapshot.id;

        Logger().i('Documento encontrado con ID: $documentId');
      } else {
        Logger().e(
            'No se encontró ningún documento con los criterios especificados.');
      }
    } catch (e) {
      Logger().e('Error buscando el documento: $e');
    }

    return documentId;
  }

  @override
  Future<void> updateTransect(TransectModel transect) async {
    String documentId =
        await findDocument(transect.createdBy, transect.createdAt);

    Logger().d(documentId);

    try {
      await _firebaseFirestore
          .collection('transects')
          .doc(documentId)
          .update(transect.toDocument());
      Logger().d('Documento actualizado con éxito.');
    } catch (e) {
      Logger().e('Error actualizando el documento: $e');
    }
  }
}
