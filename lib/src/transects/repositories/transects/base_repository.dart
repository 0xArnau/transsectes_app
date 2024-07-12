import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';

abstract class BaseRepository {
  Stream<List<TransectModel>> getAllTransects();
  Stream<List<TransectModel>> getUserTransects(String? userEmail);
  Future<void> addTransect(TransectModel transect);
  void removeAllTransects();
  Future<String> findDocument(String createdBy, Timestamp createdAt);
  Future<void> updateTransect(TransectModel transect);
}
