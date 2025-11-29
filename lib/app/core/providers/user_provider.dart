import 'package:flutter_riverpod/legacy.dart';
import 'package:transsectes_app/app/core/states/user_state.dart';

/// Provider for UserState
final currentUserStateProvider =
    StateProvider<UserState>((ref) => UserState.initial());
