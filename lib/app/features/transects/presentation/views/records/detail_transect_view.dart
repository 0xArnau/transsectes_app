import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/widgets/custom_button.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/records/detail_transect_view_model_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/viewmodels/records/detail_transect_view_model.dart';
import 'package:transsectes_app/app/features/transects/presentation/views/records/google_maps_view.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// A view displaying detailed information about a specific transect.
class DetailTransectView extends ConsumerStatefulWidget {
  /// The transect entity to display details for.
  final TransectEntity transect;

  /// Creates an instance of [DetailTransectView].
  const DetailTransectView({
    super.key,
    required this.transect,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailTransectViewState();
}

class _DetailTransectViewState extends ConsumerState<DetailTransectView> {
  /// ViewModel instance for handling business logic and state management.
  late DetailTransectViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = ref.read(detailTransectViewModelProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _save(context, [widget.transect], widget.transect.localityFirst);
            },
            icon: const Icon(Icons.download),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.update),
          // ),
        ],
        title: Text(S.current.transect_detail),
      ),
      body: Center(
        child: ListView(
          children: [
            _listTile(
              title: S.current.transect_date,
              value: widget.transect.createdAt.toDate().toIso8601String(),
            ),
            _listTile(
              title: S.current.transect_author,
              value: widget.transect.createdBy,
            ),
            _listTileGeo(
              title: S.current.transect_administrative_are,
              value1: widget.transect.administrativeAreaFirst,
              value2: widget.transect.administrativeAreaLast,
            ),
            _listTileGeo(
              title: S.current.transect_subadministrative_are,
              value1: widget.transect.subAdministrativeAreaFirst,
              value2: widget.transect.subAdministrativeAreaLast,
            ),
            _listTileGeo(
              title: S.current.transect_locality,
              value1: widget.transect.localityFirst,
              value2: widget.transect.localityLast,
            ),
            _listTile(
              title: S.current.transect_people_informed,
              value: widget.transect.informedPeople.toString(),
            ),
            _listTile(
              title: S.current.transect_tractor,
              value: widget.transect.tractor.toString(),
            ),
            _listTile(
              title: S.current.transect_observations,
              value: widget.transect.observations,
            ),
            _openMap(
              context: context,
              transectEntity: widget.transect,
            ),
          ],
        ),
      ),
    );
  }

  /// Creates a list tile with a single value.
  ///
  /// - [title]: The title to display.
  /// - [value]: The value to display.
  Widget _listTile({required String title, required String value}) {
    return ListTile(
      leading: Text(title),
      title: Text(
        value,
        textAlign: TextAlign.end,
      ),
    );
  }

  /// Creates a list tile for displaying geographical information.
  ///
  /// - [title]: The title to display.
  /// - [value1]: The first value to display (start).
  /// - [value2]: The second value to display (end).
  Widget _listTileGeo({
    required String title,
    required String value1,
    required String value2,
  }) {
    return ListTile(
      leading: Text(title),
      title: value1 == value2
          ? Text(
              value1,
              textAlign: TextAlign.right,
            )
          : SizedBox(
              height: 48,
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$value1 (inici)',
                      textAlign: TextAlign.right,
                    ),
                    Text(
                      '$value2 (final)',
                      textAlign: TextAlign.right,
                    )
                  ],
                ),
              ),
            ),
    );
  }

  /// Creates a button to open a map view for the transect.
  ///
  /// - [context]: The build context.
  /// - [transectEntity]: The transect entity to display on the map.
  Widget _openMap(
      {required BuildContext context, required TransectEntity transectEntity}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomButton(
        text: S.current.open_map,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return GoogleMapsView(transectEntity: transectEntity);
              },
            ),
          );
        },
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
    final response = await _viewModel.saveTransectsAsCsv(transects, locality);

    response.fold(
      (okMessage) => {
        _snackbar(
          context,
          okMessage,
          false,
        ),
      },
      (error) => {
        _snackbar(
          context,
          'Error while saving the transects',
          true,
        )
      },
    );
  }

  /// Displays a snackbar with a message.
  ///
  /// - [context]: The build context.
  /// - [message]: The message to display.
  /// - [isError]: Whether the snackbar represents an error (true) or success (false).
  void _snackbar(BuildContext context, String message, bool isError) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 30),
          showCloseIcon: true,
          closeIconColor:
              isError ? Colors.black : Theme.of(context).colorScheme.onSurface,
          content: Text(
            message,
            style: TextStyle(
              color: isError
                  ? Colors.black
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
          backgroundColor: isError
              ? Colors.redAccent
              : Theme.of(context).colorScheme.surface,
        ),
      );
    }
  }
}
