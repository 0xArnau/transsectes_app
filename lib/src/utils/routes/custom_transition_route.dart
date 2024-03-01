import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomTransitionRoute {
  static CustomTransitionPage transition({required view}) {
    return CustomTransitionPage(
      child: view,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }
}
