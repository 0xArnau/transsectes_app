import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/widgets/float_snackbar.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/records/detail_transect_view_model_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/records/transect_list_view_model_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/records/transect_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/viewmodels/records/detail_transect_view_model.dart';
import 'package:transsectes_app/app/features/transects/presentation/viewmodels/records/transect_list_view_model.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// A view for downloading transects grouped by their locality.
class DownloadTransectsView extends ConsumerStatefulWidget {
  const DownloadTransectsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DownloadTransectsViewState();
}

class _DownloadTransectsViewState extends ConsumerState<DownloadTransectsView> {
  /// ViewModel instance for handling business logic and state management.
  late DetailTransectViewModel _detailTransectViewModel;
  late TransectListViewModel _transectListViewModel;

  @override
  void initState() {
    super.initState();

    // Initialize the ViewModel
    _detailTransectViewModel = ref.read(detailTransectViewModelProvider);
    _transectListViewModel = ref.read(transectListViewModelProvider);

    // Fetch transects after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _transectListViewModel.executeGetAllTransects();
    });
  }

  @override
  Widget build(BuildContext context) {
    final allTransectState = ref.watch(allTransectsStateProvider);

    final isLoading = allTransectState.isLoading;
    final errorMessage = allTransectState.errorMessage;

    if (errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showSnackbar(context, errorMessage, true);
      });
    }

    return StreamBuilder<List<TransectEntity>>(
      stream: allTransectState.transects,
      builder: (context, snapshot) {
        if (isLoading || snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return  Center(child: Text(S.current.failedToLoadTransects));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return  Center(child: Text(S.current.noTransectsAvailable));
        }

        final groupedTransects = _groupTransectsByLocality(snapshot.data!);

        return ListView(
          children: groupedTransects.entries.map((entry) {
            return _buildTransectCard(
              context: context,
              locality: entry.key,
              transects: entry.value,
            );
          }).toList(),
        );
      },
    );
  }

  /// Groups a list of transects by their locality.
  ///
  /// - [transects]: The list of transects to group.
  /// - Returns: A map where the key is the locality and the value is the list of transects in that locality.
  Map<String, List<TransectEntity>> _groupTransectsByLocality(
      List<TransectEntity> transects) {
    final Map<String, List<TransectEntity>> grouped = {};
    for (final transect in transects) {
      grouped.putIfAbsent(transect.localityFirst, () => []).add(transect);
    }
    return grouped;
  }

  /// Builds a card widget for a group of transects.
  ///
  /// - [context]: The build context.
  /// - [locality]: The locality of the transects.
  /// - [transects]: The list of transects in the locality.
  /// - Returns: A card widget displaying the locality and options for downloading transects.
  Widget _buildTransectCard({
    required BuildContext context,
    required String locality,
    required List<TransectEntity> transects,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      surfaceTintColor: Theme.of(context).colorScheme.tertiary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text('${transects.length}'),
        ),
        title: Text(locality),
        trailing: IconButton(
          icon: const Icon(Icons.download),
          onPressed: () => _save(context, transects, locality),
        ),
      ),
    );
  }

  /// Saves the transects as a CSV file and shows a snackbar with the result.
  ///
  /// - [context]: The build context.
  /// - [transects]: The list of transects to save.
  /// - [locality]: The locality associated with the transects.
  void _save(
    BuildContext context,
    List<TransectEntity> transects,
    String locality,
  ) async {
    final response =
        await _detailTransectViewModel.saveTransectsAsCsv(transects, locality);

    response.fold(
      (okMessage) => _showSnackbar(context, okMessage, false),
      (error) =>
          _showSnackbar(context, S.current.errorWhileSavingTransects, true),
    );
  }

  /// Displays a snackbar with a message.
  ///
  /// - [context]: The build context.
  /// - [message]: The message to display.
  /// - [isError]: Whether the snackbar represents an error (true) or success (false).
  void _showSnackbar(BuildContext context, String message, bool isError) {
    if (context.mounted) {
      floatSnackbar(
        context: context,
        message: message,
        isError: isError,
      );
    }
  }
}
