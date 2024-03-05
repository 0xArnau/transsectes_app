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
      drawer: MenuView(),
      backgroundColor: kColorBackground,
      appBar: _buildAppBar(),
      body: ListView(
        children: [],
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
