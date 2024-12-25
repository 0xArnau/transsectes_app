import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/features/transects/presentation/states/transect_state.dart';

// Provider for user transects
final userTransectsStateProvider =
    StateProvider<TransectState>((ref) => TransectState.initial());

// Provider for all transects
final allTransectsStateProvider =
    StateProvider<TransectState>((ref) => TransectState.initial());
