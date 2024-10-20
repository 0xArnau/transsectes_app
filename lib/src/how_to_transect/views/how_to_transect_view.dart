import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/utils/Widgets/android_ios/scaffold_widget.dart';

class HowToTransectView extends StatefulWidget {
  const HowToTransectView({super.key});

  static const path = '/how-to-transect';

  @override
  State<HowToTransectView> createState() => _HowToTransectViewState();
}

class _HowToTransectViewState extends State<HowToTransectView> {
  @override
  void initState() {
    super.initState();
  }

  final PageController _sliderController = PageController(initialPage: 0);

  int _currentSlider = 0;

  final List<Widget> _sliders = [
    _sliderWidget(
      title: S.current.how_to_1_title,
      pre: S.current.how_to_1_1,
      post: S.current.how_to_1_2,
      image: 'assets/imgs/explanation/1.png',
    ),
    _sliderWidget(
      title: S.current.how_to_2_title,
      pre: S.current.how_to_2_1,
      post: S.current.how_to_2_2,
      image: 'assets/imgs/explanation/2.png',
    ),
    _sliderWidget(
      title: S.current.how_to_3_title,
      pre: S.current.how_to_3_1,
      post: S.current.how_to_3_2,
      image: 'assets/imgs/explanation/3.png',
    ),
    _sliderWidget(
      title: S.current.how_to_4_title,
      pre: S.current.how_to_4_1,
      post: S.current.how_to_4_2,
      image: 'assets/imgs/explanation/4.png',
    ),
    _sliderWidget(
      title: S.current.how_to_5_title,
      pre: S.current.how_to_5_1,
      image: 'assets/imgs/explanation/5.png',
    ),
    _sliderWidget(
      title: S.current.how_to_6_title,
      pre: S.current.how_to_6_1,
      post: S.current.how_to_6_2,
      image: 'assets/imgs/explanation/6.png',
    ),
    _sliderWidget(
      title: S.current.how_to_7_title,
      pre: S.current.how_to_7_1,
      image: 'assets/imgs/explanation/7.png',
    ),
    Image.asset(
      'assets/imgs/explanation/8.png',
      fit: BoxFit.fitHeight,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return scaffoldWidget(
      context: context,
      title: S.current.how2transect,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _sliderController,
              itemCount: _sliders.length,
              itemBuilder: ((context, index) {
                return _sliders[index];
              }),
              onPageChanged: (value) {
                setState(() {
                  _currentSlider = value;
                });
              },
            ),
            Platform.isIOS
                ? Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(
                          _sliders.length,
                          (index) => CupertinoButton(
                            padding:
                                EdgeInsets.zero, // Elimina el padding del botón
                            onPressed: () {
                              _sliderController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: CircleAvatar(
                              radius: _currentSlider == index ? 6 : 3,
                              backgroundColor: _currentSlider == index
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(
                          _sliders.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: InkWell(
                              onTap: () {
                                _sliderController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: CircleAvatar(
                                radius: _currentSlider == index ? 6 : 3,
                                backgroundColor: _currentSlider == index
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget _customText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16),
      textAlign: TextAlign.center,
    );
  }
}

Widget _sliderWidget({
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
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (pre != null)
            Text(
              pre,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          if (image != null)
            Image.asset(
              image,
              fit: BoxFit.fitWidth,
              width: double.infinity,
            ),
          if (post != null)
            Text(
              post,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}
