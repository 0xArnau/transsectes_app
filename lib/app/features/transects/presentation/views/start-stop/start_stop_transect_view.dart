import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transsectes_app/app/core/widgets/wave_shape_widget.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/start-stop/start_stop_transect_view_model_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/states/start-stop/transect_coordinates_state.dart';
import 'package:transsectes_app/app/features/transects/presentation/viewmodels/start-stop/start_stop_transect_view_model.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/start-stop/transect_coordinates_state_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/views/start-stop/save_transect_view.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// A stateful widget for managing the start and stop of a transect.
///
/// This view listens to the state of the transect and dynamically displays
/// different UI screens based on the state (loading, stopped, or main screen).
class StartStopTransectView extends ConsumerStatefulWidget {
  const StartStopTransectView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StartStopTransectViewState();
}

class _StartStopTransectViewState extends ConsumerState<StartStopTransectView> {
  late final StartStopTransectViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(startStopTransectViewModelProvider);
  }

  @override
  Widget build(BuildContext context) {
    final transectState = ref.watch(transectCoordinatesStateProvider);

    // Delegate the build process to specific functions
    if (transectState.isLoading) {
      return _buildLoadingScreen();
    }

    if (transectState.isStopped) {
      return const SaveTransectView();
    }

    return _buildMainScreen(transectState);
  }

  /// Builds a loading screen with a circular progress indicator.
  ///
  /// This screen is shown when the transect state is loading.
  Widget _buildLoadingScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start/Stop Transect'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// Builds the main screen when the transect is neither loading nor stopped.
  ///
  /// Displays start or stop transect buttons based on the current state.
  Widget _buildMainScreen(TransectCoordinatesState transectState) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start/Stop Transect'),
      ),
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.bottomCenter,
            child: WaveShapeWidget(),
          ),
          ListView(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              if (!transectState.isStarted && !transectState.isStopped)
                _imageTextWidget(
                  context,
                  'assets/imgs/icons/start.png',
                  MediaQuery.of(context).size.width / 2,
                  S.current.start_transect,
                  _viewModel.startTransect,
                ),
              if (transectState.isStarted && !transectState.isStopped)
                _imageTextWidget(
                  context,
                  'assets/imgs/icons/pause.png',
                  MediaQuery.of(context).size.width / 2,
                  S.current.stop_transect,
                  _viewModel.stopTransect,
                ),
            ],
          ),
        ],
      ),
    );
  }

  /// Creates a clickable widget containing an image and text for the start/stop buttons.
  ///
  /// This widget is used to display the start or stop transect action.
  ///
  /// Parameters:
  /// - `context`: The build context for the widget.
  /// - `imgSrc`: The path to the image asset for the button.
  /// - `imgSize`: The width of the image asset.
  /// - `text`: The text to display beside the image.
  /// - `action`: The function to be invoked when the button is tapped.
  ///
  /// Returns:
  /// - A widget containing the image and text, wrapped in a clickable container.
  Widget _imageTextWidget(
    BuildContext context,
    String imgSrc,
    double imgSize,
    String text,
    Function()? action,
  ) {
    return InkWell(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                imgSrc,
                width: imgSize,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
