import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/widgets/counter_button_widget.dart';
import 'package:transsectes_app/app/core/widgets/custom_buttom_trailing.dart';
import 'package:transsectes_app/app/core/widgets/custom_button.dart';
import 'package:transsectes_app/app/core/widgets/custom_text_form.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/start-stop/save_transect_view_model_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/start-stop/start_stop_transect_view_model_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/start-stop/transect_coordinates_state_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/viewmodels/start-stop/save_transect_view_model.dart';
import 'package:transsectes_app/app/features/transects/presentation/viewmodels/start-stop/start_stop_transect_view_model.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// A view for saving transect information.
///
/// This view provides a form for users to input details about a transect,
/// including whether a tractor was used, the number of people informed,
/// and any observations. It integrates with the [SaveTransectViewModel]
/// to handle saving the transect.
class SaveTransectView extends ConsumerStatefulWidget {
  /// Constructs a [SaveTransectView].
  const SaveTransectView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SaveTransectViewState();
}

class _SaveTransectViewState extends ConsumerState<SaveTransectView> {
  late final StartStopTransectViewModel _startStopTransectViewModel;
  late final SaveTransectViewModel _viewModel;

  /// Whether a tractor was used.
  bool tractor = false;

  /// The number of people informed during the transect.
  int peopleInformed = 0;

  /// Controller for the observation input field.
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _startStopTransectViewModel = ref.read(startStopTransectViewModelProvider);
    _viewModel = ref.read(saveTransectViewModelProvider);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Inform'),
        actions: [
          TextButton(
            onPressed: _startStopTransectViewModel.startTransect,
            child: const Text('Resume'),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ListView(
            children: [
              const SizedBox(height: 25),
              _tractor(),
              const SizedBox(height: 25),
              _people(),
              const SizedBox(height: 25),
              _observation(),
              const SizedBox(height: 25),
              _saveOrRemove(),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the widget for selecting whether a tractor was used.
  Widget _tractor() {
    return CustomButtonTrailing(
      hint: S.current.tractor,
      trailing: Checkbox(
        activeColor: Theme.of(context).colorScheme.tertiary,
        value: tractor,
        onChanged: (value) {
          if (mounted) {
            setState(() {
              tractor = value ?? false;
            });
          }
        },
      ),
    );
  }

  /// Builds the widget for selecting the number of people informed.
  Widget _people() {
    return CounterButtonWidget(
      hint: S.current.people_informed,
      onChanged: (value) {
        if (mounted) {
          setState(() {
            peopleInformed = value;
          });
        }
      },
    );
  }

  /// Builds the widget for entering observations about the transect.
  Widget _observation() {
    return CustomTextForm(
      hintText: S.current.observations,
      obscureText: false,
      prefixIcon: null,
      controller: textEditingController,
    );
  }

  /// Builds the widgets for saving or canceling the transect.
  Widget _saveOrRemove() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButton(
          text: S.current.cancel,
          onTap: () {
            _startStopTransectViewModel.initializeTransect();
          },
          isADestructiveAction: true,
        ),
        CustomButton(
          text: S.current.save,
          onTap: () {
            _viewModel.saveTransect(
              tractor,
              peopleInformed,
              textEditingController.text,
              ref.read(transectCoordinatesStateProvider).coordinates,
            );
          },
        ),
      ],
    );
  }
}
