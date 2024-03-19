import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';
import 'package:transsectes_app/src/utils/colors.dart';

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

  @override
  Widget build(BuildContext context) {
    return customScaffold(
      context: context,
      title: S.current.how2transect,
      body: SafeArea(
        child: IntroductionScreen(
          showDoneButton: true,
          showNextButton: true,
          showBackButton: true,
          isProgress: false,
          baseBtnStyle: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(kColorTitle),
            surfaceTintColor: MaterialStateProperty.all<Color>(kColorTitle),
            overlayColor: MaterialStateProperty.all<Color>(
              Color.fromRGBO(
                kColorTitle.red,
                kColorTitle.green,
                kColorTitle.blue,
                .2,
              ),
            ),
          ),
          back: Theme.of(context).platform == TargetPlatform.iOS
              ? const Icon(Icons.arrow_back_ios)
              : const Icon(Icons.arrow_back),
          next: Theme.of(context).platform == TargetPlatform.iOS
              ? const Icon(Icons.arrow_forward_ios)
              : const Icon(Icons.arrow_forward),
          done: const Icon(Icons.done),
          onDone: () {
            context.pop();
          },
          pages: [
            myPageViewModel(
              title: S.current.how_to_1_title,
              textBefore: S.current.how_to_1_1,
              textAfter: S.current.how_to_1_2,
              image: 'assets/imgs/explanation/1.png',
            ),
            myPageViewModel(
              title: S.current.how_to_2_title,
              textBefore: S.current.how_to_2_1,
              textAfter: S.current.how_to_2_2,
              image: 'assets/imgs/explanation/2.png',
            ),
            myPageViewModel(
              title: S.current.how_to_3_title,
              textBefore: S.current.how_to_3_1,
              textAfter: S.current.how_to_3_2,
              image: 'assets/imgs/explanation/3.png',
            ),
            myPageViewModel(
              title: S.current.how_to_4_title,
              textBefore: S.current.how_to_4_1,
              textAfter: S.current.how_to_4_2,
              image: 'assets/imgs/explanation/4.png',
            ),
            myPageViewModel(
              title: S.current.how_to_5_title,
              textBefore: S.current.how_to_5_1,
              textAfter: '',
              image: 'assets/imgs/explanation/5.png',
            ),
            myPageViewModel(
              title: S.current.how_to_6_title,
              textBefore: S.current.how_to_6_1,
              textAfter: S.current.how_to_6_2,
              image: 'assets/imgs/explanation/6.png',
            ),
            myPageViewModel(
              title: S.current.how_to_7_title,
              textBefore: S.current.how_to_7_1,
              textAfter: '',
              image: 'assets/imgs/explanation/7.png',
            ),
            myPageViewModel(
              title: S.current.how_to_8_title,
              textBefore: '',
              textAfter: '',
              image: 'assets/imgs/explanation/8.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget _customText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16),
      textAlign: TextAlign.center,
    );
  }
}

PageViewModel myPageViewModel({
  required String title,
  required String textBefore,
  required String textAfter,
  required String image,
}) =>
    PageViewModel(
      title: title,
      bodyWidget: Column(
        children: [
          Text(
            textBefore,
            style: const TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.justify,
          ),
          Image.asset(image),
          Text(
            textAfter,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
