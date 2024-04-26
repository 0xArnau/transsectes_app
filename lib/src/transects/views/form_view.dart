import 'package:flutter/material.dart';
import 'package:transsectes_app/generated/l10n.dart';
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
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomSmallWaveShape(context),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                SizedBox(height: 25),
                CustomButtonTrailing(
                  hint: S.current.tractor,
                  trailing: Checkbox(
                    activeColor: kColorTitle,
                    value: tractor,
                    onChanged: (value) {
                      setState(() {
                        tractor = value ?? false;
                      });
                    },
                  ),
                ),
                SizedBox(height: 25),
                CounterButtonWidget(
                  hint: S.current.people_informed,
                  onChanged: (value) {
                    setState(() {
                      peopleInformed = value;
                    });
                  },
                ),
                SizedBox(height: 25),
                CustomTextForm(
                  hintText: S.current.observations,
                  obscureText: false,
                  prefixIcon: null,
                ),
                SizedBox(height: 25),
                Text(
                  S.current.note + ':',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '- ' + S.current.note_go_back,
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  '- ' + S.current.note_cancel,
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  '- ' + S.current.note_send,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    customButton(
                      text: S.current.cancel,
                      onTap: () {},
                    ),
                    customButton(
                      text: S.current.send,
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
