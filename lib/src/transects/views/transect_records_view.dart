import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/transects/bloc/transect_bloc.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class TransectRecordsView extends StatelessWidget {
  const TransectRecordsView({super.key});

  static const path = '/transect-records';

  @override
  Widget build(BuildContext context) {
    return customScaffold(
      context: context,
      title: S.current.transect_records,
      body: BlocBuilder<TransectBloc, TransectState>(
        builder: (context, state) {
          Logger().i(state);

          if (state is TransectInitial) {
            return Center(
              child: CircularProgressIndicator(
                color: kColorTitle,
              ),
            );
          }

          if (state is TransectLoaded) {
            if (state.transects.length == 0)
              return Center(child: Text("No elements found"));

            return ListView.builder(
              itemCount: state.transects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    state.transects[index].createdAt.toDate().toIso8601String(),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    state.transects[index].observations,
                    textAlign: TextAlign.center,
                  ),
                  onTap: () {
                    // Go to a dedicated screen where users can see all information and map
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>,
                    //   ),
                    // );
                  },
                );
              },
            );
          }

          return Center(child: Text("Someting went wrong"));
        },
      ),
    );
  }
}
