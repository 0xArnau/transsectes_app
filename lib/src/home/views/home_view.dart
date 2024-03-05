import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transsectes_app/generated/l10n.dart';
import 'package:transsectes_app/src/contact/views/contact_view.dart';
import 'package:transsectes_app/src/home/views/menu_view.dart';
import 'package:transsectes_app/src/how_to_transect/views/how_to_transect_view.dart';
import 'package:transsectes_app/src/start_stop_transecte/views/start_stop_transecte_view.dart';
import 'package:transsectes_app/src/transect_records/views/transect_records_view.dart';
import 'package:transsectes_app/src/utils/colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const path = '/';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      drawer: MenuView(),
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          ListView(
            children: [
              _imageTextWidget(
                context,
                'assets/imgs/icons/walk.png',
                MediaQuery.of(context).size.width / 3,
                S.current.how2transect,
                () => context.push(HowToTransectView.path),
              ),
              _textImageWidget(
                context,
                'assets/imgs/icons/route.png',
                MediaQuery.of(context).size.width / 2,
                S.current.start_transect,
                () => context.push(StartStopTransecteView.path),
              ),
              _imageTextWidget(
                context,
                'assets/imgs/icons/book.png',
                MediaQuery.of(context).size.width / 2.5,
                S.current.transect_records,
                () => context.push(TransectRecordsView.path),
              ),
              _textImageWidget(
                context,
                'assets/imgs/icons/contact.png',
                MediaQuery.of(context).size.width / 3.5,
                S.current.contact,
                () => context.push(ContactView.path),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: kColorBackground,
              ),
              child: SafeArea(
                child: Image.asset(
                  'assets/imgs/logo/GEPEC_EdC_OFICIAL.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: kColorBackground,
      foregroundColor: kColorTitle,
      title: const Text(
        'Transsectes APP',
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

Widget _textImageWidget(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
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
          SizedBox(width: 10),
          Image.asset(
            imgSrc,
            width: imgSize,
          ),
        ],
      ),
    ),
  );
}
