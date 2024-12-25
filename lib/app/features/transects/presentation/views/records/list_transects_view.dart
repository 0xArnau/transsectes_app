import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/app/core/providers/user_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/transect_list_view_model_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/viewmodels/transect_list_view_model.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/transect_provider.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';

/// A view that displays a list of transects.
///
/// This view fetches either the user's specific transects or all transects
/// depending on the value of the [viewAll] parameter.
class ListTransectsView extends ConsumerStatefulWidget {
  /// A flag to determine whether to fetch all transects or only the user's transects.
  final bool viewAll;

  /// Creates an instance of [ListTransectsView].
  ///
  /// The [viewAll] parameter is used to decide if all transects or only the user's transects should be fetched.
  const ListTransectsView({super.key, this.viewAll = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ListTransectsViewState();
}

class _ListTransectsViewState extends ConsumerState<ListTransectsView> {
  late TransectListViewModel _viewModel;

  @override
  void initState() {
    Logger().d('_ListTransectsViewState initialized');

    super.initState();

    // Initialize the ViewModel
    _viewModel = ref.read(transectListViewModelProvider);

    // Fetch transects after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchTransects();
    });
  }

  /// Fetches the transects based on the user's status and the [viewAll] flag.
  ///
  /// - If [viewAll] is false, fetches the user's specific transects.
  /// - If [viewAll] is true and the user is a technician, fetches all transects.
  void _fetchTransects() {
    final userState = ref.read(currentUserStateProvider);

    if (userState.user != null) {
      _viewModel.executeGetUserTransects(userState.user!.email);
    }

    if (widget.viewAll && userState.user?.isTechnician == true) {
      _viewModel.executeGetAllTransects();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Observe the user-specific transects state
    final userTransectState = ref.watch(userTransectsStateProvider);

    // Observe the state for all transects
    final allTransectState = ref.watch(allTransectsStateProvider);

    // Determine which state to display based on `viewAll`
    final isLoading = widget.viewAll
        ? allTransectState.isLoading
        : userTransectState.isLoading;

    final transects = widget.viewAll
        ? allTransectState.transects
        : userTransectState.transects;

    final errorMessage = widget.viewAll
        ? allTransectState.errorMessage
        : userTransectState.errorMessage;

    // Show snackbar if there's an error message
    if (errorMessage != null) {
      Future.delayed(Duration.zero, () {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.redAccent,
            ),
          );

          _viewModel.clearMessages();
        }
      });
    }

    // Build the UI
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : transects.isEmpty
            ? const Center(child: Text('No transects available'))
            : ListView.builder(
                itemCount: transects.length,
                itemBuilder: (context, index) {
                  TransectEntity transect = transects[index];
                  return ListTile(
                    title: Text(transect.createdBy),
                    subtitle: const Text('Transect Details...'),
                  );
                },
              );
  }
}
