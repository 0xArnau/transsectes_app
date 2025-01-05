import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/get_address_from_coordinates_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/remove_all_transects_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/update_transect_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';
import 'package:transsectes_app/generated/l10n.dart';

class TransectViewModel {
  final Ref _ref;
  final UpdateTransectUseCase _updateTransectUseCase;
  final RemoveAllTransectsUseCase _removeAllTransectsUseCase;
  final GetAddressFromCoordinatesUseCase _getAddressFromCoordinatesUseCase;

  // The error message that will be shown in the view (via snackbar)
  String? errorMessage;

  // List of TransectEntities to be displayed in the view
  List<TransectEntity> transects = [];

  TransectViewModel({
    required Ref ref,
    required UpdateTransectUseCase updateTransectUseCase,
    required RemoveAllTransectsUseCase removeAllTransectsUseCase,
    required GetAddressFromCoordinatesUseCase getAddressFromCoordinatesUseCase,
  })  : _ref = ref,
        _updateTransectUseCase = updateTransectUseCase,
        _removeAllTransectsUseCase = removeAllTransectsUseCase,
        _getAddressFromCoordinatesUseCase = getAddressFromCoordinatesUseCase;

  /// Calls the update transect use case and updates errorMessage on failure.
  Future<TransectEntity?> updateTransect(TransectEntity transect) async {
    final entity = await _updatedFields(transect);

    if (entity == null) {
      errorMessage = S.current.failedToUpdateTransect;
      return null;
    }

    final result = await _updateTransectUseCase.execute(entity);

    result.fold(
      (value) {},
      (error) {
        errorMessage = S.current.failedToUpdateTransect;
      },
    );

    return entity;
  }

  Future<TransectEntity?> _updatedFields(TransectEntity entity) async {
    // Address variables
    String administrativeAreaFirst = '';
    String administrativeAreaLast = '';
    String localityFirst = '';
    String localityLast = '';
    String subAdministrativeAreaFirst = '';
    String subAdministrativeAreaLast = '';

    final firstCoordinate = entity.coordinates.firstOrNull;
    final lastCoordinate = entity.coordinates.lastOrNull;

    if (firstCoordinate == null || lastCoordinate == null) {
      errorMessage = S.current.failedToUpdateTransect;
      return null;
    }

    // Fetch and handle the first address
    (await _getAddressFromCoordinatesUseCase.execute(
            firstCoordinate.latitude, firstCoordinate.longitude))
        .fold(
      (success) {
        administrativeAreaFirst = success.administrativeArea ?? '';
        localityFirst = success.locality ?? '';
        subAdministrativeAreaFirst = success.subAdministrativeArea ?? '';
      },
      (_) {
        errorMessage = S.current.failedToUpdateTransect;
        return null;
      },
    );

    // Fetch and handle the last address
    (await _getAddressFromCoordinatesUseCase.execute(
            lastCoordinate.latitude, lastCoordinate.longitude))
        .fold(
      (success) {
        administrativeAreaLast = success.administrativeArea ?? '';
        localityLast = success.locality ?? '';
        subAdministrativeAreaLast = success.subAdministrativeArea ?? '';
      },
      (_) {
        errorMessage = S.current.failedToUpdateTransect;
        return null;
      },
    );

    return TransectEntity(
      createdAt: entity.createdAt,
      updatedAt: Timestamp.now(),
      createdBy: entity.createdBy,
      coordinates: entity.coordinates,
      tractor: entity.tractor,
      informedPeople: entity.informedPeople,
      observations: entity.observations,
      administrativeAreaFirst: administrativeAreaFirst,
      administrativeAreaLast: administrativeAreaLast,
      localityFirst: localityFirst,
      localityLast: localityLast,
      subAdministrativeAreaFirst: subAdministrativeAreaFirst,
      subAdministrativeAreaLast: subAdministrativeAreaLast,
    );
  }

  /// Calls the remove all transects use case and updates errorMessage on failure.
  Future<void> removeAllTransects() async {
    final result = await _removeAllTransectsUseCase.execute();

    result.fold(
      (value) {
        transects = []; // Clear the list when all transects are removed
      },
      (error) {
        errorMessage = S.current.failedToUpdateTransect;
      },
    );
  }
}
