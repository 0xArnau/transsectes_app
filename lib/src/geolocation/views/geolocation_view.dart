import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/geolocation/bloc/geolocation_bloc.dart';
import 'package:transsectes_app/src/geolocation/controller/geolocation_controller.dart';
import 'package:transsectes_app/src/utils/Widgets/android_ios/button_filled_widget.dart';
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
      title: S.current.add_new_geopoint,
      body: BlocBuilder<GeolocationBloc, GeolocationState>(
        builder: (context, state) {
          if (state is GeolocationLoaded) {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                      itemCount: state.geolocation.geopoint.length,
                      itemBuilder: (context, index) {
                        return Text(
                          "${state.geolocation.geopoint[index].latitude}, ${state.geolocation.geopoint[index].longitude}",
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                  Center(
                    child: ButtonFilledWidget(
                      action: () {
                        GeolocationController.getLocation().then((value) {
                          Logger().d([value.latitude, value.longitude]);

                          context.read<GeolocationBloc>().add(
                                AddGeolocationPoint(
                                  geoPoint:
                                      GeoPoint(value.latitude, value.longitude),
                                ),
                              );
                        });
                      },
                      icon: const Icon(Icons.plus_one),
                      text: S.current.add_new_geopoint,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is GeolocationInitial) {
            return const Center(
              child: CircularProgressIndicator(
                color: kColorTitle,
              ),
            );
          }

          return Center(child: Text(S.current.something_wrong_try_again));
        },
      ),
    );
  }
}
