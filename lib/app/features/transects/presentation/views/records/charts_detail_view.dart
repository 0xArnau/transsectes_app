import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
  final List<_PieData> pieData = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      pieData.add(_PieData(
        'Number of Transects (${widget.numberOfTransects})',
        widget.numberOfTransects,
        '${widget.numberOfTransects}',
      ));
      pieData.add(_PieData(
        'Informed People (${widget.informedPeople})',
        widget.informedPeople,
        '${widget.informedPeople}',
      ));
      pieData.add(_PieData(
        'Tractor Count (${widget.tractorCount})',
        widget.tractorCount,
        '${widget.tractorCount}',
      ));
      pieData.add(_PieData(
        'No Tractor Count (${widget.noTractorCount})',
        widget.noTractorCount,
        '${widget.noTractorCount}',
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(child: Center(child: _circularChart())),
    );
  }

  Widget _circularChart() {
    return SfCircularChart(
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          alignment: ChartAlignment.center,
          textStyle: TextStyle(fontSize: 18),
          iconHeight: 20,
          iconWidth: 20,
          overflowMode: LegendItemOverflowMode.wrap,
        ),
        series: <PieSeries<_PieData, String>>[
          PieSeries<_PieData, String>(
            explode: true,
            explodeIndex: null,
            dataSource: pieData,
            xValueMapper: (_PieData data, _) => data.xData,
            yValueMapper: (_PieData data, _) => data.yData,
            // dataLabelMapper: (_PieData data, _) => data.text,
            // dataLabelSettings: DataLabelSettings(
            //   isVisible: true,
            //   textStyle: TextStyle(fontSize: 18),
            // ),
          ),
        ]);
  }
}

class _PieData {
  _PieData(this.xData, this.yData, this.text);
  final String xData;
  final num yData;
  String? text;
}
