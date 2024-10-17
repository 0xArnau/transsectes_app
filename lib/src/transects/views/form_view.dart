import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/geolocation/bloc/geolocation_bloc.dart';
import 'package:transsectes_app/src/transects/bloc/transect_bloc.dart';
import 'package:transsectes_app/src/utils/Widgets/android_ios/alert_dialog_widget.dart';
import 'package:transsectes_app/src/utils/Widgets/counter_button_widget.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_buttom_trailing.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_button.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_small_wave_shape.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_text_form.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class FormView extends StatefulWidget {
  const FormView({super.key});

  static const path = '/start-stop-transect/form';

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  bool tractor = false;
  int peopleInformed = 0;
  TextEditingController observations = TextEditingController();

  @override
  void dispose() {
    observations.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return customScaffold(
      context: context,
      title: S.current.transect_form,
      body: BlocBuilder<TransectBloc, TransectState>(
        builder: (context, state) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomSmallWaveShape(context),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 25),
                    CustomButtonTrailing(
                      hint: S.current.tractor,
                      trailing: Checkbox(
                        activeColor: kColorTitle,
                        value: tractor,
                        onChanged: (value) {
                          if (mounted) {
                            setState(() {
                              tractor = value ?? false;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 25),
                    CounterButtonWidget(
                      hint: S.current.people_informed,
                      onChanged: (value) {
                        if (mounted) {
                          setState(() {
                            peopleInformed = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 25),
                    CustomTextForm(
                      hintText: S.current.observations,
                      obscureText: false,
                      prefixIcon: null,
                      controller: observations,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      '${S.current.note}:',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '- ${S.current.note_go_back}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '- ${S.current.note_cancel}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '- ${S.current.note_send}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        customButton(
                          text: S.current.cancel,
                          onTap: () => AlertDialogWidget.showAlertDialog(
                            context: context,
                            title: 'Cancel transect',
                            content: S.current.cancel_transect,
                            primaryText: S.current.delete,
                            primaryFunction: () {
                              context
                                  .read<TransectBloc>()
                                  .add(CancelTransect());

                              context
                                  .read<GeolocationBloc>()
                                  .add(ResetGeolocation());
                              context.pop();
                            },
                            secondaryText: 'Cancel',
                            secondaryFunction: () {},
                          ),
                        ),
                        BlocBuilder<GeolocationBloc, GeolocationState>(
                          builder: (context, state) {
                            return customButton(
                              text: S.current.send,
                              onTap: () async {
                                if (state is GeolocationLoaded) {
                                  AlertDialogWidget.showAlertDialog(
                                    context: context,
                                    title: 'Save transect',
                                    content: S.current.save_transect,
                                    primaryText: S.current.save,
                                    primaryFunction: () {
                                      context
                                          .read<TransectBloc>()
                                          .add(StopTransect(
                                            context: context,
                                            tractor: tractor,
                                            informedPeople: peopleInformed,
                                            observations: observations.text,
                                            geolocationModel: state.geolocation,
                                          ));
                                      context
                                          .read<GeolocationBloc>()
                                          .add(ResetGeolocation());
                                      context.pop();
                                    },
                                    secondaryText: S.current.cancel,
                                    secondaryFunction: () {},
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
