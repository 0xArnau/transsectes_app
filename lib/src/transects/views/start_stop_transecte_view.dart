import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/geolocation/bloc/geolocation_bloc.dart';
import 'package:transsectes_app/src/geolocation/views/geolocation_view.dart';
import 'package:transsectes_app/src/transects/bloc/transect_bloc.dart';
import 'package:transsectes_app/src/transects/views/form_view.dart';
import 'package:transsectes_app/src/utils/Widgets/android_ios/scaffold_widget.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_small_wave_shape.dart';
import 'package:transsectes_app/src/utils/colors.dart';
import 'package:transsectes_app/src/utils/custom_snackbar.dart';

class StartStopTransecteView extends StatefulWidget {
  const StartStopTransecteView({super.key});

  static const path = '/start-stop-transect';

  @override
  State<StartStopTransecteView> createState() => _StartStopTransecteViewState();
}

class _StartStopTransecteViewState extends State<StartStopTransecteView> {
  @override
  Widget build(BuildContext context) {
    return scaffoldWidget(
      context: context,
      title: S.current.start_transect,
      body: BlocBuilder<TransectBloc, TransectState>(
        builder: (context, state) {
          return Center(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomSmallWaveShape(context),
                ),
                ListView(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    _imageTextWidget(
                      context,
                      'assets/imgs/icons/pause.png',
                      MediaQuery.of(context).size.width / 2,
                      S.current.stop_transect,
                      () {
                        if (state is TransectStarted) {
                          context.push(FormView.path);
                        } else {
                          CustomSnackbar.error(
                            context,
                            S.current.cannot_stop_transect,
                          );
                        }
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    _imageTextWidget(
                      context,
                      'assets/imgs/icons/start.png',
                      MediaQuery.of(context).size.width / 2,
                      state is TransectStarted
                          ? S.current.add_new_marks
                          : S.current.start_transect,
                      () {
                        if (state is! TransectStarted) {
                          Logger().d("StartTransect");
                          context.read<TransectBloc>().add(StartTransect());
                          Logger().d("StartBackgroundGeolocation");
                          context
                              .read<GeolocationBloc>()
                              .add(StartBackgroundGeolocation());
                          Logger().d("AddCurrentGeolocationPoint");
                          context
                              .read<GeolocationBloc>()
                              .add(AddCurrentGeolocationPoint());
                        } else {
                          context.push(GeolocationView.path);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _imageTextWidget(
  BuildContext context,
  String imgSrc,
  double imgSize,
  String text,
  Function()? goTo,
) {
  return Platform.isIOS
      ? CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: goTo,
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    imgSrc,
                    width: imgSize,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 20,
                        color: kColorText,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      : InkWell(
          onTap: goTo,
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    imgSrc,
                    width: imgSize,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 20,
                        color: kColorText,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}
