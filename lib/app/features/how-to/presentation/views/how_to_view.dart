import 'package:flutter/material.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// A view that provides a step-by-step guide on how to perform a transect.
class HowToView extends StatefulWidget {
  const HowToView({super.key});

  /// The navigation path for this view.
  static const path = '/how-to-transect';

  @override
  State<HowToView> createState() => _HowToViewState();
}

class _HowToViewState extends State<HowToView> {
  final PageController _sliderController = PageController(initialPage: 0);
  int _currentSlider = 0;

  /// List of slider widgets to display the guide steps.
  late List<Widget> _sliders;

  @override
  Widget build(BuildContext context) {
    _sliders = List.unmodifiable([
      _createSliderWidget(
        context: context,
        title: S.current.how_to_1_title,
        pre: S.current.how_to_1_1,
        post: S.current.how_to_1_2,
        image: 'assets/imgs/explanation/1.png',
      ),
      _createSliderWidget(
        context: context,
        title: S.current.how_to_2_title,
        pre: S.current.how_to_2_1,
        post: S.current.how_to_2_2,
        image: 'assets/imgs/explanation/2.png',
      ),
      _createSliderWidget(
        context: context,
        title: S.current.how_to_3_title,
        pre: S.current.how_to_3_1,
        post: S.current.how_to_3_2,
        image: 'assets/imgs/explanation/3.png',
      ),
      _createSliderWidget(
        context: context,
        title: S.current.how_to_4_title,
        pre: S.current.how_to_4_1,
        post: S.current.how_to_4_2,
        image: 'assets/imgs/explanation/4.png',
      ),
      _createSliderWidget(
        context: context,
        title: S.current.how_to_5_title,
        pre: S.current.how_to_5_1,
        image: 'assets/imgs/explanation/5.png',
      ),
      _createSliderWidget(
        context: context,
        title: S.current.how_to_6_title,
        pre: S.current.how_to_6_1,
        post: S.current.how_to_6_2,
        image: 'assets/imgs/explanation/6.png',
      ),
      _createSliderWidget(
        context: context,
        title: S.current.how_to_7_title,
        pre: S.current.how_to_7_1,
        image: 'assets/imgs/explanation/7.png',
      ),
      Semantics(
        hidden: true,
        child: Image.asset(
          'assets/imgs/explanation/8.png',
          fit: BoxFit.fitHeight,
        ),
      ),
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.how2transect),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _buildSliderView(),
            _buildIndicator(),
          ],
        ),
      ),
    );
  }

  /// Builds the page view slider.
  Widget _buildSliderView() {
    return PageView.builder(
      controller: _sliderController,
      itemCount: _sliders.length,
      itemBuilder: (context, index) => _sliders[index],
      onPageChanged: (value) {
        setState(() {
          _currentSlider = value;
        });
      },
    );
  }

  /// Builds the slider indicator at the bottom of the screen.
  ///
  /// Replaces the original indicator dots with accessible navigation buttons.
  /// Improves accessibility and ensures only relevant buttons are shown.
  ///
  /// Returns:
  /// - A Positioned widget containing the navigation buttons.
  Widget _buildIndicator() {
    final bool isFirst = _currentSlider == 0;
    final bool isLast = _currentSlider == _sliders.length - 1;

    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isFirst)
            Semantics(
              button: true,
              label: S.current.page_control_back,
              child: ElevatedButton(
                onPressed: () => _sliderController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
                child: Text(S.current.page_control_back),
              ),
            )
          else
            const SizedBox(), // Para mantener el espacio y el alineamiento

          if (!isLast)
            Semantics(
              button: true,
              label: S.current.page_control_next,
              child: ElevatedButton(
                onPressed: () => _sliderController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
                child: Text(S.current.page_control_next),
              ),
            )
          else
            const SizedBox(), // Para mantener el espacio y el alineamiento
        ],
      ),
    );
  }
}

/// Creates a widget for a single slider page.
Widget _createSliderWidget({
  required BuildContext context,
  String? title,
  String? pre,
  String? post,
  String? image,
}) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title != null) _buildTitle(title),
          if (pre != null) _buildText(context, pre),
          if (image != null) _buildImage(image),
          if (post != null) _buildText(context, post),
          const SizedBox(height: 80),
        ],
      ),
    ),
  );
}

/// Builds the title widget for the slider.
Widget _buildTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

/// Builds a text widget for the slider.
Widget _buildText(BuildContext context, String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 18,
      color: Theme.of(context).colorScheme.onSurface,
    ),
  );
}

/// Builds an image widget for the slider.
Widget _buildImage(String imagePath) {
  return Semantics(
    hidden: true,
    child: Image.asset(
      imagePath,
      fit: BoxFit.contain,
      width: double.infinity,
    ),
  );
}
