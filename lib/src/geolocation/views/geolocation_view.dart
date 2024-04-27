import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/src/geolocation/bloc/geolocation_bloc.dart';
import 'package:transsectes_app/src/geolocation/controller/geolocation_controller.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class GeolocationView extends StatefulWidget {
  const GeolocationView({super.key});

  static const path = '/start-stop-transect/add-geopoint';

  @override
  State<GeolocationView> createState() => _GeolocationViewState();
}

class _GeolocationViewState extends State<GeolocationView> {
  @override
  Widget build(BuildContext context) {
    Logger().d("GeolocationView");
    return customScaffold(
      context: context,
      title: 'Add a new geo point',
      body: BlocBuilder<GeolocationBloc, GeolocationState>(
        builder: (context, state) {
          if (state is GeolocationLoaded) {
            return Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  GeolocationController.getLocation().then((value) {
                    Logger().d([value.latitude, value.longitude]);
                  });
                },
                icon: Icon(Icons.plus_one),
                label: Text("Add a new geopoint"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: kColorTitle,
                  surfaceTintColor: kColorTitle,
                ),
              ),
            );
          }

          if (state is GeolocationInitial) {
            return Center(
              child: CircularProgressIndicator(
                color: kColorTitle,
              ),
            );
          }

          return Center(child: Text("Someting went wrong"));
        },
      ),
    );
  }
}
