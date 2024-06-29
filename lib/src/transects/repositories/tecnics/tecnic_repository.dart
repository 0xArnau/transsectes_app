import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/src/auth/repositories/auth_repository.dart';
import 'package:transsectes_app/src/transects/repositories/tecnics/base_repository.dart';

class TecnicRepository extends BaseRepository {
  final FirebaseFirestore _firebaseFirestore;

  TecnicRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<bool> isTechnician() async {
    String? currentUserEmail = await AuthRepository().getUserEmail();

    try {
      return await _firebaseFirestore
          .collection('tecnics')
          .doc(currentUserEmail?.toLowerCase())
          .get()
          .then(
        (snapshot) {
          if (snapshot.exists) return true;
          return false;
        },
      );
    } catch (e) {
      Logger().e(e);
    }

    return false;
  }
}
