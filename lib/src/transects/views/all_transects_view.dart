import 'package:flutter/material.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';
import 'package:transsectes_app/src/transects/repositories/transects/transect_repository.dart';
import 'package:transsectes_app/src/transects/views/transect_view.dart';

class AllTransectsView extends StatefulWidget {
  const AllTransectsView({super.key});

  static const path = '/transect-records';

  @override
  State<AllTransectsView> createState() => _AllTransectsViewState();
}

class _AllTransectsViewState extends State<AllTransectsView> {
  late Stream<List<TransectModel>> stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    stream = TransectRepository().getAllTransects().map(
        (list) => list..sort((a, b) => b.createdAt.compareTo(a.createdAt)));
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<TransectModel>> stream = TransectRepository().getAllTransects();

    Stream<List<TransectModel>> orderedStream = stream.map((list) {
      return list..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    });

    return StreamBuilder(
      stream: orderedStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<TransectModel>> snapshot) {
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TransectView(transect: snapshot.data![index]),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
