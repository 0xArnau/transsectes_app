import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/shared/presentation/states/user_state.dart';

/// Provider for UserState
final currentUserStateProvider =
    StateProvider<UserState>((ref) => UserState.initial());
