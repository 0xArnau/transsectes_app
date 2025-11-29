import 'package:flutter_riverpod/legacy.dart';
import 'package:transsectes_app/app/features/transects/presentation/states/records/transect_state.dart';

// Provider for user transects
final userTransectsStateProvider =
    StateProvider<TransectState>((ref) => TransectState.initial());

// Provider for all transects
final allTransectsStateProvider =
    StateProvider<TransectState>((ref) => TransectState.initial());
