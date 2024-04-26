import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/transects/views/form_view.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';
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
  bool startedTransect = false;

  @override
  Widget build(BuildContext context) {
    return customScaffold(
      context: context,
      title: S.current.start_transect,
      body: Center(
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
                    if (startedTransect) {
                      context.push(FormView.path);

                      setState(() {
                        startedTransect =
                            false; // TODO: this varaible should change the value inside de FormView not outside
                      });
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
                  S.current.start_transect,
                  () {
                    if (startedTransect) {
                      CustomSnackbar.error(
                        context,
                        S.current.cannot_start_transect,
                      );
                    } else {
                      setState(() {
                        startedTransect = true;
                      });
                    }
                  },
                ),
              ],
            ),
          ],
        ),
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
  return InkWell(
    onTap: goTo,
    child: Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              imgSrc,
              width: imgSize,
            ),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
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
