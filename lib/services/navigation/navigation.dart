import 'package:flutter/material.dart';

class AppNavigation {
  static const int _navigationMilliSeconds = 500;

  static void navigate({required BuildContext context, required Widget page}) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionDuration:
            const Duration(milliseconds: _navigationMilliSeconds),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ),
    );
  }

  static void navigateReplacement(
      {required BuildContext context, required Widget page}) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionDuration:
            const Duration(milliseconds: _navigationMilliSeconds),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ),
    );
  }

  static void navigateOffAll(
      {required BuildContext context, required Widget page}) {
    Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => page,
          transitionDuration:
              const Duration(milliseconds: _navigationMilliSeconds),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        ),
        (Route<dynamic> route) => false);
  }
}
