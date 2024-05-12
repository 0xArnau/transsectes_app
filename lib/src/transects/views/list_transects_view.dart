import 'package:flutter/material.dart';
import 'package:transsectes_app/src/transects/models/transect_model.dart';
import 'package:transsectes_app/src/transects/views/transect_view.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class ListTransectsView extends StatefulWidget {
  final Stream<List<TransectModel>> transects;
  final String filter;
  const ListTransectsView({
    super.key,
    required this.transects,
    this.filter = '',
  });

  static const path = '/transect-records';

  @override
  State<ListTransectsView> createState() => _ListTransectsViewState();
}

class _ListTransectsViewState extends State<ListTransectsView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.transects.map((event) {
        return event
            .where((element) =>
                element.localityFirst
                    .toLowerCase()
                    .contains(widget.filter.toLowerCase()) ||
                element.createdAt
                    .toDate()
                    .toIso8601String()
                    .toLowerCase()
                    .contains(widget.filter.toLowerCase()))
            .toList();
      }),
      builder:
          (BuildContext context, AsyncSnapshot<List<TransectModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: kColorTitle,
            ),
          );
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
