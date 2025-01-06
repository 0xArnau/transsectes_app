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
      Image.asset(
        'assets/imgs/explanation/8.png',
        fit: BoxFit.fitHeight,
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
  Widget _buildIndicator() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _sliders.length,
          (index) => Padding(
            padding: const EdgeInsets.all(3.0),
            child: _buildIndicatorDot(index),
          ),
        ),
      ),
    );
  }

  /// Builds a single dot for the slider indicator.
  Widget _buildIndicatorDot(int index) {
    final bool isActive = _currentSlider == index;
    return InkWell(
      onTap: () => _sliderController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
      child: CircleAvatar(
        radius: isActive ? 6 : 3,
        backgroundColor:
            isActive ? Theme.of(context).colorScheme.primary : Colors.grey,
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
          const SizedBox(height: 30),
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
  return Image.asset(
    imagePath,
    fit: BoxFit.contain,
    width: double.infinity,
  );
}
