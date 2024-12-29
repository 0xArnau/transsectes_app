import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/widgets/counter_button_widget.dart';
import 'package:transsectes_app/app/core/widgets/custom_buttom_trailing.dart';
import 'package:transsectes_app/app/core/widgets/custom_button.dart';
import 'package:transsectes_app/app/core/widgets/custom_text_form.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/start-stop/start_stop_transect_view_model_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/start-stop/transect_coordinates_state_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/viewmodels/start-stop/start_stop_transect_view_model.dart';
import 'package:transsectes_app/generated/l10n.dart';

class SaveTransectView extends ConsumerStatefulWidget {
  const SaveTransectView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SaveTransectViewState();
}

class _SaveTransectViewState extends ConsumerState<SaveTransectView> {
  late final StartStopTransectViewModel _startStopTransectViewModel;

  bool tractor = false;
  int peopleInformed = 0;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _startStopTransectViewModel = ref.read(startStopTransectViewModelProvider);
  }

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transectState = ref.watch(transectCoordinatesStateProvider);

    // return _buildStoppedScreen(transectState);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Inform'),
        actions: [
          TextButton(
              onPressed: _startStopTransectViewModel.startTransect,
              child: const Text('Resume'))
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

  Widget _observation() {
    return CustomTextForm(
      hintText: S.current.observations,
      obscureText: false,
      prefixIcon: null,
      controller: textEditingController,
    );
  }

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
            // TODO
          },
        ),
      ],
    );
  }
}
