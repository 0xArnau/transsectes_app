import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:transsectes_app/generated/l10n.dart';
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

    // DocumentFileSavePlus()
    //     .saveFile(
    //       Uint8List.fromList(utf8.encode(csv)),
    //       fileName,
    //       "text/csv",
    //     )
    //     .then((_) =>
    //         CustomSnackbar.info(context, "${S.current.file_saved} $fileName "))
    //     .onError(
    //         (error, stackTrace) => CustomSnackbar.error(context, "$error"));

    // final Directory? downloadsDir = await getDownloadsDirectory();

    String fileLocation = "${S.current.file_saved} $fileName ";
    if (Platform.isAndroid) {
      fileLocation =
          "${S.current.file_saved} 'Files > Menu > device name > Android > data > cat.gepec.transsectes_app > files > $fileName'";
    } else if (Platform.isIOS) {
      fileLocation =
          "${S.current.file_saved} 'Files > Browse > On My iPhone > Transsectes $fileName'";
    }

    await FileSaver.instance
        .saveFile(
          name: fileName,
          // filePath: downloadsDir?.path,
          bytes: Uint8List.fromList(utf8.encode(csv)),
          mimeType: MimeType.csv,
        )
        .then((_) => CustomSnackbar.info(context, fileLocation))
        .onError(
            (error, stackTrace) => CustomSnackbar.error(context, "$error"));

    // await FileSaver.instance.saveFile({
    //   required String name,
    //   Uint8List? bytes,
    //   File? file,
    //   String? filePath,
    //   LinkDetails? link,
    //   String ext = "",
    //   MimeType mimeType = MimeType.other,
    //   String? customMimeType,
    //   Dio? dioClient,
    //   Uint8List Function(Uint8List)? transformDioResponse,
    //   });
  }
}
