import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';
import 'package:transsectes_app/app/features/transects/presentation/providers/charts/chart_view_model_provider.dart';
import 'package:transsectes_app/app/features/transects/presentation/viewmodels/charts/charts_view_model.dart';
import 'package:transsectes_app/app/features/transects/presentation/views/records/charts_detail_view.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// A widget that displays a list of metrics for transects based on a time range.
class ChartsListView extends ConsumerStatefulWidget {
  /// Creates a [ChartsListView] widget.
  ///
  /// The [label] parameter is used to specify the time range for grouping metrics.
  const ChartsListView({super.key, required this.label});

  final String label;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChartsListViewState();
}

class _ChartsListViewState extends ConsumerState<ChartsListView> {
  bool showCharts = false;
  late ChartsViewModel chartsViewModel;

  @override
  void initState() {
    super.initState();

    // Initialize the chartsViewModel
    chartsViewModel = ref.read(chartsViewModelProvider);
    chartsViewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(child: _buildBody()),
    );
  }

  /// Builds the [AppBar] widget for the screen.
  ///
  /// It contains the title 'Metrics' and a button to toggle the visibility of charts.
  AppBar _buildAppBar() {
    final Map<String, String> translations = {
      'yearly': S.current.yearly,
      'monthly': S.current.monthly,
      'weekly': S.current.weekly,
      'daily': S.current.daily,
    };

    return AppBar(
      title: Text(
        '${S.current.metrics} (${translations[widget.label] ?? S.current.unknown})',
      ),
      actions: [
        TextButton(
          onPressed: _toggleChartsVisibility,
          child: Text(showCharts ? S.current.list : S.current.chart),
        ),
      ],
    );
  }

  /// Toggles the visibility of the charts.
  ///
  /// This function is triggered when the "Charts" button is pressed in the [AppBar].
  void _toggleChartsVisibility() {
    setState(() {
      showCharts = !showCharts;
    });
  }

  /// Builds the main body of the screen which displays the list of transects' metrics.
  ///
  /// It uses a [StreamBuilder] to listen for changes in transect data and updates the UI accordingly.
  Widget _buildBody() {
    return StreamBuilder<List<TransectEntity>>(
      stream: chartsViewModel.transectsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return _buildError(snapshot.error.toString());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _buildEmptyDataMessage();
        }

        return _buildMetricsList(snapshot.data!);
      },
    );
  }

  /// Builds a widget to display an error message.
  ///
  /// This is used when there is an error in the data stream.
  Widget _buildError(String error) {
    return Center(child: Text('Error: $error'));
  }

  /// Builds a widget to display a message when no data is available.
  ///
  /// This is used when the data stream is empty or null.
  Widget _buildEmptyDataMessage() {
    return const Center(child: Text('No data available.'));
  }

  /// Builds a list view with metrics based on the given transects data.
  ///
  /// It uses a [FutureBuilder] to process and display metrics grouped by the specified time range.
  Widget _buildMetricsList(List<TransectEntity> transects) {
    return FutureBuilder<Map<String, Map<String, int>>>(
      future: chartsViewModel.processMetricsByTimeRange(
        transects: transects,
        range: widget.label,
      ),
      builder: (context, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (futureSnapshot.hasError) {
          return _buildError(futureSnapshot.error.toString());
        }

        if (!futureSnapshot.hasData || futureSnapshot.data!.isEmpty) {
          return _buildEmptyDataMessage();
        }

        final items = futureSnapshot.data!;

        if (showCharts) return _buildMetricsListChart(items);

        return _buildMetricsListView(items);
      },
    );
  }

  /// Builds a [SfCartesianChart] (Line chart) to display the metrics.
  ///
  /// This chart shows four lines representing the number of transects, informed people,
  /// tractor count, and no tractor count for each group in the data.
  Widget _buildMetricsListChart(Map<String, Map<String, int>> items) {
    final List<_ChartData> chartData = [];

    // Process items to convert into chart data
    items.forEach((key, metrics) {
      chartData.add(_ChartData(
        key,
        metrics['numberOfTransects'] ?? 0,
        metrics['informedPeople'] ?? 0,
        metrics['tractorCount'] ?? 0,
        metrics['noTractorCount'] ?? 0,
      ));
    });

    return SfCartesianChart(
      // title: ChartTitle(text: 'Metrics Overview'),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        alignment: ChartAlignment.center,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: S.current.timeRange),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: S.current.counts),
        interval: 10, // Adjust based on your data range
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      // series: [],
      series: <CartesianSeries<_ChartData, String>>[
        LineSeries<_ChartData, String>(
          name: S.current.numberOfTransects,
          dataSource: chartData,
          xValueMapper: (_ChartData data, _) => data.label,
          yValueMapper: (_ChartData data, _) => data.numberOfTransects,
          markerSettings: const MarkerSettings(isVisible: true),
        ),
        LineSeries<_ChartData, String>(
          name: S.current.informedPeople,
          dataSource: chartData,
          xValueMapper: (_ChartData data, _) => data.label,
          yValueMapper: (_ChartData data, _) => data.informedPeople,
          markerSettings: const MarkerSettings(isVisible: true),
        ),
        LineSeries<_ChartData, String>(
          name: S.current.tractorCount,
          dataSource: chartData,
          xValueMapper: (_ChartData data, _) => data.label,
          yValueMapper: (_ChartData data, _) => data.tractorCount,
          markerSettings: const MarkerSettings(isVisible: true),
        ),
        LineSeries<_ChartData, String>(
          name: S.current.noTractorCount,
          dataSource: chartData,
          xValueMapper: (_ChartData data, _) => data.label,
          yValueMapper: (_ChartData data, _) => data.noTractorCount,
          markerSettings: const MarkerSettings(isVisible: true),
        ),
      ],
    );
  }

  /// Builds a [ListView] for the given metrics.
  ///
  /// It creates a list item for each key in the metrics map and displays the associated data.
  Widget _buildMetricsListView(Map<String, Map<String, int>> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final key = items.keys.elementAt(index);
        final metrics = items[key]!;
        return _itemCard(key, metrics);
      },
    );
  }

  /// Builds a card widget to display a single transect's metrics.
  ///
  /// The card displays the transect's key and its metrics, such as:
  /// - numberOfTransects
  /// - informedPeople
  /// - tractorCount
  /// - noTractorCount
  ///
  /// This widget is used to show individual items in the metrics list.
  Widget _itemCard(String key, Map<String, int> metrics) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Text(
          key,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${S.current.numberOfTransects}: ${metrics['numberOfTransects'] ?? 0}',
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              '${S.current.informedPeople}: ${metrics['informedPeople'] ?? 0}',
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              '${S.current.tractorCount}: ${metrics['tractorCount'] ?? 0}',
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              '${S.current.noTractorCount}: ${metrics['noTractorCount'] ?? 0}',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        onTap: () {
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChartsDetailView(
                  title: key,
                  numberOfTransects: metrics['numberOfTransects'] ?? 0,
                  informedPeople: metrics['informedPeople'] ?? 0,
                  tractorCount: metrics['tractorCount'] ?? 0,
                  noTractorCount: metrics['noTractorCount'] ?? 0,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

/// Model class for chart data.
class _ChartData {
  _ChartData(this.label, this.numberOfTransects, this.informedPeople,
      this.tractorCount, this.noTractorCount);

  final String label;
  final int numberOfTransects;
  final int informedPeople;
  final int tractorCount;
  final int noTractorCount;
}
