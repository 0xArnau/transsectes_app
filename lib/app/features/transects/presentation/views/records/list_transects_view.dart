import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/app/core/providers/user_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/transect_list_view_model_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/viewmodels/transect_list_view_model.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/transect_provider.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';
import 'package:transsectes_app/app/features/transects/presentation/views/records/detail_transect_view.dart';

/// A view that displays a list of transects.
///
/// This view fetches either the user's specific transects or all transects
/// depending on the value of the [viewAll] parameter.
class ListTransectsView extends ConsumerStatefulWidget {
  /// A flag to determine whether to fetch all transects or only the user's transects.
  ///
  /// If `true`, fetches all transects. If `false`, fetches only the user's transects.
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

    // Use StreamBuilder to handle the Stream of transects
    return StreamBuilder<List<TransectEntity>>(
      stream: widget.viewAll
          ? allTransectState.transects // Stream from all transects
          : userTransectState.transects, // Stream from user-specific transects
      builder: (context, snapshot) {
        // Show loading indicator while data is being fetched
        if (isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // Handle different connection states of the stream
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show error message if the stream encountered an error
        if (snapshot.hasError) {
          return const Center(child: Text('Failed to load transects.'));
        }

        // If the snapshot has no data or the list is empty, show a "No transects available" message
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No transects available'));
        }

        // Get the list of transects from the stream
        final transects = snapshot.data!;

        // Display the list of transects using a ListView
        return ListView.builder(
          itemCount: transects.length,
          itemBuilder: (context, index) {
            return _itemCard(transects[index]);
          },
        );
      },
    );
  }

  /// Builds a card widget to display a single transect.
  ///
  /// The card displays the transect's locality and other relevant information.
  Widget _itemCard(TransectEntity transect) {
    final hasDifferentLocalities =
        transect.localityFirst != transect.localityLast;

    final date = transect.createdAt.toDate();

    final formattedDate =
        '${date.year}-${date.month}-${date.day}T${date.hour}:${date.minute}';

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Text(
          hasDifferentLocalities
              ? '${transect.localityFirst} - ${transect.localityLast}'
              : transect.localityFirst,
        ),
        title: Text(
          formattedDate,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(transect.observations),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailTransectView(transect: transect),
            ),
          );
        },
      ),
    );
  }
}
