import 'package:flutter/material.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class CounterButtonWidget extends StatefulWidget {
  const CounterButtonWidget({
    super.key,
    required this.hint,
    required this.onChanged,
  });

  final String hint;
  final ValueChanged<int> onChanged;

  @override
  State<CounterButtonWidget> createState() => _CounterButtonWidgetState();
}

class _CounterButtonWidgetState extends State<CounterButtonWidget> {
  int _count = 0;

  void _increment() {
    if (mounted) {
      setState(() {
        _count++;
      });
    }
    widget.onChanged.call(_count);
  }

  void _decrement() {
    if (mounted) {
      setState(() {
        if (_count > 0) _count--;
      });
    }
    widget.onChanged.call(_count);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: kColorButtons),
              color: kColorButtons,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.hint),
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: _decrement,
            ),
            Text(
              '$_count',
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _increment,
            ),
          ],
        )
      ],
    );
  }
}
