import 'package:flutter/material.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/auth/repositories/auth_repository.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';
import 'package:transsectes_app/src/transects/repositories/transect_repository.dart';
import 'package:transsectes_app/src/utils/Widgets/custom_scaffold.dart';

class TransectRecordsView extends StatefulWidget {
  const TransectRecordsView({super.key});

  static const path = '/transect-records';

  @override
  State<TransectRecordsView> createState() => _TransectRecordsViewState();
}

class _TransectRecordsViewState extends State<TransectRecordsView> {
  late Stream<List<TransectModel>> stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthRepository().getUserEmail().then((userEmail) {
      stream = TransectRepository().getUserTransects(userEmail).map(
          (list) => list..sort((a, b) => b.createdAt.compareTo(a.createdAt)));
    });
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<TransectModel>> stream =
        TransectRepository().getUserTransects("0xarnau@gmail.com");

    Stream<List<TransectModel>> orderedStream = stream.map((list) {
      return list..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });

    return customScaffold(
      context: context,
      title: S.current.transect_records,
      body: StreamBuilder(
        stream: orderedStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<TransectModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    snapshot.data![index].localityFirst,
                    textAlign: TextAlign.center,
                  ),
                  title: Text(
                    snapshot.data![index].createdAt
                        .toDate()
                        .toIso8601String()
                        .split('.')[0],
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(
                    snapshot.data![index].observations,
                    textAlign: TextAlign.center,
                  ),
                  trailing: const Icon(Icons.open_in_new),
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
        },
      ),
    );
  }
}
