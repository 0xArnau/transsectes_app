import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';
import 'package:transsectes_app/src/transects/repositories/base_repository.dart';

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
    if (userEmail == null) return Stream<List<TransectModel>>.empty();

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
}
