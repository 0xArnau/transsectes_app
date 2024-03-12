import 'package:flutter/material.dart';
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
  final List<Widget> pages = [];

  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();

    pages.addAll([
      _page1(),
      _page2(),
      _page3(),
      _page4(),
      _page5(),
      _page6(),
      _page7(),
      // _page8(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return customScaffold(
      context: context,
      title: S.current.how2transect,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      _currentPageIndex = value;
                    });
                  },
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return pages[_currentPageIndex];
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (index) => AnimatedDot(isActive: index == _currentPageIndex),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _page1() {
    return ListView(
      children: [
        _customText(S.current.how_to_1_1),
        SizedBox(height: 10),
        Image.asset('assets/imgs/explanation/1.png'),
        SizedBox(height: 10),
        _customText(S.current.how_to_1_2),
      ],
    );
  }

  Widget _page2() {
    return ListView(
      children: [
        _customText('- ' + S.current.how_to_2_1),
        SizedBox(height: 10),
        _customText('- ' + S.current.how_to_2_2),
        SizedBox(height: 10),
        _customText('- ' + S.current.how_to_2_3),
        Image.asset('assets/imgs/explanation/2.png'),
      ],
    );
  }

  Widget _page3() {
    return ListView(
      children: [
        _customText(S.current.how_to_3_1),
        SizedBox(height: 10),
        Image.asset('assets/imgs/explanation/3_1.png'),
        SizedBox(height: 10),
        _customText(S.current.how_to_3_2),
        // Image.asset('assets/imgs/explanation/3_2.png'),
      ],
    );
  }

  Widget _page4() {
    return ListView(
      children: [
        _customText(S.current.how_to_4_1),
        SizedBox(height: 30),
        _customText(S.current.how_to_4_2),
        SizedBox(height: 10),
        Image.asset('assets/imgs/explanation/4.png'),
      ],
    );
  }

  Widget _page5() {
    return ListView(
      children: [
        _customText(S.current.how_to_5_1),
        SizedBox(height: 10),
        Image.asset('assets/imgs/explanation/5.png'),
      ],
    );
  }

  Widget _page6() {
    return ListView(
      children: [
        _customText(S.current.how_to_6_1),
        SizedBox(height: 10),
        Image.asset('assets/imgs/explanation/6.png'),
        SizedBox(height: 10),
        _customText(S.current.how_to_6_2),
      ],
    );
  }

  Widget _page7() {
    return ListView(
      children: [
        _customText(S.current.how_to_7_1),
        SizedBox(height: 10),
        Image.asset('assets/imgs/explanation/7.png'),
      ],
    );
  }

  Widget _page8() {
    return Image.asset('assets/imgs/explanation/8.png', fit: BoxFit.cover);
  }

  Widget _customText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16),
      textAlign: TextAlign.center,
    );
  }
}

class AnimatedDot extends StatelessWidget {
  final bool isActive;

  const AnimatedDot({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 6,
        width: isActive ? 20 : 6,
        decoration: BoxDecoration(
          color: isActive ? kColorTitle : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
