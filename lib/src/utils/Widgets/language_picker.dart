import 'package:flutter/material.dart';

class CustomListWheelScrollView extends StatefulWidget {
  @override
  _CustomListWheelScrollViewState createState() =>
      _CustomListWheelScrollViewState();
}

class _CustomListWheelScrollViewState extends State<CustomListWheelScrollView> {
  late FixedExtentScrollController _controller;
  int _currentElement = 0;
  double height = 56;

  @override
  void initState() {
    super.initState();

    _controller = FixedExtentScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: height - 20,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          ListWheelScrollView.useDelegate(
            itemExtent: height,
            diameterRatio: 1,
            // useMagnifier: true,
            // magnification: 1.5,
            squeeze: 1.75,
            controller: _controller,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              setState(() {
                _currentElement = index;
              });
              //
              _controller.animateToItem(_currentElement,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);

              print(index);
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: 3,
              builder: (ctx, index) {
                return Center(
                  child: Text(
                    index == 0
                        ? "English"
                        : index == 1
                            ? "Español"
                            : "Català",
                    style: TextStyle(
                      fontSize: 32,
                      color:
                          _currentElement == index ? Colors.black : Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void showModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height / 3.5,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width / 6,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: CustomListWheelScrollView(),
            ),
          ],
        ),
      );
    },
  );
}
