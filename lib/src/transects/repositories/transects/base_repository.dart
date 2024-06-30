import 'package:transsectes_app/src/transects/models/transect_model.dart';

abstract class BaseRepository {
  Stream<List<TransectModel>> getAllTransects();
  Stream<List<TransectModel>> getUserTransects(String? userEmail);
  Future<void> addTransect(TransectModel transect);
  void removeAllTransects();
}
