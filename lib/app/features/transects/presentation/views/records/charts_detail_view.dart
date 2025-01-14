import 'package:flutter/material.dart';

class ChartsDetailView extends StatefulWidget {
  const ChartsDetailView({
    super.key,
    required this.title,
    required this.numberOfTransects,
    required this.informedPeople,
    required this.tractorCount,
    required this.noTractorCount,
  });

  final String title;
  final int numberOfTransects;
  final int informedPeople;
  final int tractorCount;
  final int noTractorCount;

  @override
  State<ChartsDetailView> createState() => _ChartsDetailViewState();
}

class _ChartsDetailViewState extends State<ChartsDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
