import 'package:transsectes_app/app/features/transects/domain/usecases/get_address_from_coordinates_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/get_current_position_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/get_location_stream_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/request_location_permissions_usecase.dart';

class GpsViewModel {
  final GetAddressFromCoordinatesUseCase getAddressFromCoordinatesUseCase;
  final GetCurrentPositionUseCase getCurrentPositionUseCase;
  final GetLocationStreamUseCase getLocationStreamUseCase;
  final RequestLocationPermissionsUseCase requestLocationPermissionsUseCase;

  GpsViewModel({
    required this.getAddressFromCoordinatesUseCase,
    required this.getCurrentPositionUseCase,
    required this.getLocationStreamUseCase,
    required this.requestLocationPermissionsUseCase,
  });
}
