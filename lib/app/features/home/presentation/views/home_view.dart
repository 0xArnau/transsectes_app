import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transsectes APP"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Image.asset(
          'assets/imgs/logo/GEPEC_EdC_OFICIAL_blanc.png',
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
