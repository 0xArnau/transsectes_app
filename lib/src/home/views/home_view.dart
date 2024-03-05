import 'package:flutter/material.dart';
import 'package:transsectes_app/src/home/views/menu_view.dart';
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
                'Com fer un transsecte',
              ),
              _textImageWidget(
                context,
                'assets/imgs/icons/route.png',
                MediaQuery.of(context).size.width / 2,
                'Inicia un transsecte',
              ),
              _imageTextWidget(
                context,
                'assets/imgs/icons/book.png',
                MediaQuery.of(context).size.width / 2.5,
                'Registres de transsectes',
              ),
              _textImageWidget(
                context,
                'assets/imgs/icons/contact.png',
                MediaQuery.of(context).size.width / 3.5,
                'Contacta',
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
) {
  return Container(
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
  );
}

Widget _textImageWidget(
  BuildContext context,
  String imgSrc,
  double imgSize,
  String text,
) {
  return Container(
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
  );
}
