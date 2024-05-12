import 'dart:convert';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:flutter/material.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';
import 'package:transsectes_app/src/utils/custom_snackbar.dart';

class FileIOController {
  /// Saves a list of [TransectModel] objects to a CSV file (using [csv.ListToCsvConverter]) in the device storage.
  ///
  /// The [reports] list contains the data to be written to the CSV file.
  /// The [context] is required to display a snackbar with the result of the operation.
  static void saveReports2CSV({
    required BuildContext context,
    required List<TransectModel> reports,
    required String locality,
  }) async {
    late String csv;
    final fileName =
        "transsectes_app-$locality-${DateTime.now().toIso8601String()}.csv";
    List<List<dynamic>> rows = [];

    rows.add([
      'createdBy',
      'createdAt',
      'administrativeAreaFirst',
      'administrativeAreaLast',
      'subAdministrativeAreaFirst',
      'subAdministrativeAreaLast',
      'localityFirst',
      'localityLast',
      'informedPeople',
      'tractor',
      'observations',
      'coordinates',
    ]);

    for (var report in reports) {
      String coordinatesStr = report.coordinates
          .map((geoPoint) =>
              "[${geoPoint.latitude.toString()}, ${geoPoint.longitude.toString()}]")
          .join(", ");

      rows.add([
        report.createdBy,
        report.createdAt.toDate().toIso8601String(),
        report.administrativeAreaFirst,
        report.administrativeAreaLast,
        report.subAdministrativeAreaFirst,
        report.subAdministrativeAreaLast,
        report.localityFirst,
        report.localityLast,
        report.informedPeople,
        report.tractor,
        report.observations,
        coordinatesStr,
      ]);
    }

    csv = const ListToCsvConverter().convert(rows);

    DocumentFileSavePlus()
        .saveFile(
          Uint8List.fromList(utf8.encode(csv)),
          fileName,
          "text/csv",
        )
        .then((_) => CustomSnackbar.info(context, "File saved: $fileName "))
        .onError(
            (error, stackTrace) => CustomSnackbar.error(context, "$error"));
  }
}
