import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/app/core/errors/data_error.dart';
import 'package:transsectes_app/app/core/results/result.dart';
import 'package:transsectes_app/app/features/transects/domain/datasources/file_datasource.dart';
import 'package:transsectes_app/app/features/transects/domain/entities/transect_entity.dart';
import 'package:transsectes_app/generated/l10n.dart';

/// Implementation of the [FileDatasource] interface to save reports as CSV files.
class FileDatasourceImpl implements FileDatasource {
  @override
  Future<Result<String, DataError>> saveReportsAsCsv({
    required List<TransectEntity> reports,
    required String locality,
  }) async {
    try {
      // Generate the file name using the locality and current date
      final fileName =
          'transsectes_app-$locality-${DateTime.now().toIso8601String()}.csv';

      // Initialize rows for the CSV, with the first row being the header
      final List<List<dynamic>> rows = _generateCsvHeader();

      // Add the reports data to the CSV rows
      rows.addAll(_generateCsvRows(reports));

      // Convert the rows into a CSV string
      final String csv = const ListToCsvConverter().convert(rows);

      // Save the file in the appropriate directory based on the platform
      return await _saveCsvFile(fileName, csv);
    } catch (error, stackTrace) {
      Logger().e([error, stackTrace]);
      // Handle errors and return a failure result
      return Result.failure(LocalError(LocalErrorType.unknown));
    }
  }

  /// Generates the header for the CSV file.
  List<List<dynamic>> _generateCsvHeader() {
    return [
      [
        'createdBy',
        'updatedAt',
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
      ]
    ];
  }

  /// Generates the data rows for the CSV file based on the [reports].
  List<List<dynamic>> _generateCsvRows(List<TransectEntity> reports) {
    return reports.map((report) {
      String coordinatesStr = report.coordinates
          .map((geoPoint) =>
              '[${geoPoint.latitude.toString()}, ${geoPoint.longitude.toString()}]')
          .join(', ');

      return [
        report.createdBy,
        report.updatedAt,
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
      ];
    }).toList();
  }

  /// Saves the generated CSV file to the appropriate location based on the platform.
  Future<Result<String, DataError>> _saveCsvFile(
      String fileName, String csv) async {
    String fileLocation = _getFileLocation(fileName);

    try {
      await FileSaver.instance.saveFile(
        name: fileName,
        bytes: Uint8List.fromList(utf8.encode(csv)),
        mimeType: MimeType.csv,
      );

      // Return success result if file saving is successful
      return Result.success(fileLocation);
    } catch (error, stackTrace) {
      Logger().e([error, stackTrace]);
      // Return failure result if an error occurs, with a DataError
      return Result.failure(LocalError(LocalErrorType.unknown));
    }
  }

  /// Returns the file location message based on the platform.
  String _getFileLocation(String fileName) {
    if (Platform.isAndroid) {
      return "${S.current.file_saved} 'Files > Menu > device name > Android > data > cat.gepec.transsectes_app > files > $fileName'";
    } else if (Platform.isIOS) {
      return "${S.current.file_saved} 'Files > Browse > On My iPhone > Transsectes $fileName'";
    } else {
      return '${S.current.file_saved} $fileName'; // Default for other platforms
    }
  }
}
