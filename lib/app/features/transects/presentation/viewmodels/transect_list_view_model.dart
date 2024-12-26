import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/get_all_transects_usecase.dart';
import 'package:transsectes_app/app/features/transects/domain/usecases/get_user_transects_usecase.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/transect_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/states/transect_state.dart';

/// ViewModel specific to the transects list view.
///
/// This ViewModel manages the loading and updating of the transects list
/// and focuses on the logic required for the view displaying the transects.
class TransectListViewModel {
  final Ref ref;
  final GetAllTransectsUseCase getAllTransectsUseCase;
  final GetUserTransectsUseCase getUserTransectsUseCase;

  /// Constructor for [TransectListViewModel].
  ///
  /// [ref] is used to access Riverpod providers.
  /// [getAllTransectsUseCase] is the use case to fetch all transects.
  /// [getUserTransectsUseCase] is the use case to fetch a user's transects.
  TransectListViewModel({
    required this.ref,
    required this.getAllTransectsUseCase,
    required this.getUserTransectsUseCase,
  });

  /// Retrieves the current state of the user's transects.
  TransectState get userTransectState => ref.watch(userTransectsStateProvider);

  /// Retrieves the current state of all transects.
  TransectState get allTransectState => ref.watch(allTransectsStateProvider);

  /// Executes the use case to fetch all transects and updates the state provider.
  Future<void> executeGetAllTransects() async {
    try {
      _updateAllTransectState((state) => state.copyWith(isLoading: true));

      final result = getAllTransectsUseCase.execute();

      await result.fold(
        (transects) async {
          _updateAllTransectState(
            (state) => state.copyWith(
              isLoading: false,
              transects: transects,
              okMessage: 'All transects loaded successfully.',
            ),
          );
        },
        (error) {
          _updateAllTransectState(
            (state) => state.copyWith(
              isLoading: false,
              errorMessage: 'Failed to load transects.',
            ),
          );
        },
      );
    } catch (e) {
      Logger().e(e);
      _updateAllTransectState(
        (state) => state.copyWith(
          isLoading: false,
          errorMessage: 'An unexpected error occurred.',
        ),
      );
    }
  }

  /// Executes the use case to fetch transects for a specific user and updates the state provider.
  Future<void> executeGetUserTransects(String? userEmail) async {
    try {
      _updateUserTransectState((state) => state.copyWith(isLoading: true));

      final result = getUserTransectsUseCase.execute(userEmail);

      await result.fold(
        (transects) async {
          _updateUserTransectState(
            (state) => state.copyWith(
              isLoading: false,
              transects: transects,
              okMessage: "User's transects loaded successfully.",
            ),
          );
        },
        (error) {
          _updateUserTransectState(
            (state) => state.copyWith(
              isLoading: false,
              errorMessage: 'Failed to load user transects.',
            ),
          );
        },
      );
    } catch (e) {
      Logger().e(e);
      _updateUserTransectState(
        (state) => state.copyWith(
          isLoading: false,
          errorMessage: 'An unexpected error occurred.',
        ),
      );
    }
  }

  /// Clears the error and success messages from both state providers.
  void clearMessages() {
    _updateUserTransectState(
      (state) => state.copyWith(
        errorMessage: null,
        okMessage: null,
      ),
    );
    _updateAllTransectState(
      (state) => state.copyWith(
        errorMessage: null,
        okMessage: null,
      ),
    );
  }

  /// Updates the state of user-specific transects.
  void _updateUserTransectState(
      TransectState Function(TransectState) updateFn) {
    final currentState = ref.read(userTransectsStateProvider);
    ref.read(userTransectsStateProvider.notifier).state =
        updateFn(currentState);
  }

  /// Updates the state of all transects.
  void _updateAllTransectState(TransectState Function(TransectState) updateFn) {
    final currentState = ref.read(allTransectsStateProvider);
    ref.read(allTransectsStateProvider.notifier).state = updateFn(currentState);
  }
}
