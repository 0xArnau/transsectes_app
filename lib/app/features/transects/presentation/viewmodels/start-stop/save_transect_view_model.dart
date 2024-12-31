import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/providers/user_provider.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/geo_point_entity.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/add_transect_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/get_address_from_coordinates_usecase.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/start-stop/save_transect_error_state_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/start-stop/start_stop_transect_view_model_provider.dart';

/// ViewModel responsible for saving a transect.
///
/// This class handles the logic for creating and saving transects,
/// including fetching address data from coordinates and managing error states.
class SaveTransectViewModel {
  final Ref _ref;
  final AddTransectUseCase _addTransectUseCase;
  final GetAddressFromCoordinatesUseCase _getAddressFromCoordinatesUseCase;

  /// Constructs a [SaveTransectViewModel] with the required dependencies.
  SaveTransectViewModel({
    required Ref ref,
    required AddTransectUseCase addTransectUseCase,
    required GetAddressFromCoordinatesUseCase getAddressFromCoordinatesUseCase,
  })  : _ref = ref,
        _addTransectUseCase = addTransectUseCase,
        _getAddressFromCoordinatesUseCase = getAddressFromCoordinatesUseCase;

  /// Saves a transect with the provided data.
  ///
  /// [tractor]: Indicates if a tractor was used.
  /// [people]: The number of people involved.
  /// [observations]: Any observations to include.
  /// [coordinates]: A list of geographical points defining the transect path.
  Future<void> saveTransect(
    bool tractor,
    int people,
    String observations,
    List<GeoPointEntity> coordinates,
  ) async {
    if (coordinates.isEmpty) {
      _updateErrorState(true);
      return;
    }

    final firstCoordinate = coordinates.firstOrNull;
    final lastCoordinate = coordinates.lastOrNull;

    if (firstCoordinate == null || lastCoordinate == null) {
      _updateErrorState(true);
      return;
    }

    try {
      // Address variables
      String administrativeAreaFirst = '';
      String administrativeAreaLast = '';
      String localityFirst = '';
      String localityLast = '';
      String subAdministrativeAreaFirst = '';
      String subAdministrativeAreaLast = '';

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
          _updateErrorState(true);
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
          _updateErrorState(true);
        },
      );

      final geopoints = GeoPointEntity.toGeoPointList(coordinates);

      final transect = _createTransectEntity(
        tractor,
        people,
        observations,
        geopoints,
        administrativeAreaFirst,
        administrativeAreaLast,
        localityFirst,
        localityLast,
        subAdministrativeAreaFirst,
        subAdministrativeAreaLast,
      );

      // Si no hay conexión a internet se queda pillado en el `await` y no reinicia el estado del transecto,
      // forzar el reinicio tratándolo como un success
      _handleSaveSuccess(); // TODO: only if there is not internet connection
      final response = await _addTransectUseCase.execute(transect);

      response.fold(
        (_) => _handleSaveSuccess(),
        (_) => _updateErrorState(true),
      );
    } catch (_) {
      _updateErrorState(true);
    }
  }

  /// Creates a [TransectEntity] using the provided data.
  TransectEntity _createTransectEntity(
    bool tractor,
    int people,
    String observations,
    List<GeoPoint> geopoints,
    String administrativeAreaFirst,
    String administrativeAreaLast,
    String localityFirst,
    String localityLast,
    String subAdministrativeAreaFirst,
    String subAdministrativeAreaLast,
  ) {
    return TransectEntity(
      createdAt: Timestamp.now(),
      createdBy: _ref.read(currentUserStateProvider).user?.email ?? '',
      coordinates: geopoints,
      tractor: tractor,
      informedPeople: people,
      observations: observations,
      administrativeAreaFirst: administrativeAreaFirst,
      administrativeAreaLast: administrativeAreaLast,
      localityFirst: localityFirst,
      localityLast: localityLast,
      subAdministrativeAreaFirst: subAdministrativeAreaFirst,
      subAdministrativeAreaLast: subAdministrativeAreaLast,
    );
  }

  /// Updates the error state for saving the transect.
  void _updateErrorState(bool state) {
    _ref.read(saveTransectErrorStateProvider.notifier).state = state;
  }

  /// Handles successful transect saving by resetting related state.
  void _handleSaveSuccess() {
    _updateErrorState(false);
    _ref.read(startStopTransectViewModelProvider).initializeTransect();
  }
}
