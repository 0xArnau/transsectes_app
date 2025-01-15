import 'package:flutter/material.dart';
import 'package:transsectes_app/app/features/transects/presentation/views/records/charts_list_view.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// A widget that displays a list of options for viewing metrics grouped by different time ranges.
/// The user can tap on any of these options (yearly, monthly, weekly, or daily) to navigate
/// to the corresponding charts page.
class ChartsView extends StatelessWidget {
  const ChartsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _itemCard('yearly', context, null),
        _itemCard('monthly', context, null),
        _itemCard('weekly', context, S.current.weeklySubtitle),
        _itemCard('daily', context, null),
      ],
    );
  }

  /// Builds a card widget for each time range option.
  ///
  /// The card displays the time range label (e.g., 'yearly', 'monthly', etc.) and navigates to
  /// the corresponding [ChartsListView] when tapped.
  ///
  /// The [label] parameter specifies the time range (yearly, monthly, weekly, or daily).
  /// The [context] parameter is used to navigate to the corresponding [ChartsListView].
  Widget _itemCard(String label, BuildContext context, String? subtitle) {
    final Map<String, String> translations = {
      'yearly': S.current.yearly,
      'monthly': S.current.monthly,
      'weekly': S.current.weekly,
      'daily': S.current.daily,
    };

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          translations[label] ?? S.current.unknown,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          // Navigates to the ChartsListView with the selected time range label.
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChartsListView(label: label),
              ),
            );
          }
        },
      ),
    );
  }
}
