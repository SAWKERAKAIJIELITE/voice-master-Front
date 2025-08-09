import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/color_light_scheme.dart';

class AuthScaffold extends StatelessWidget {
  final Widget middle;
  final Widget child;

  const AuthScaffold({super.key, required this.middle, required this.child});

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpened = MediaQuery.of(context).viewInsets.bottom != 0;
    return Theme(
      data: Theme.of(context).copyWith(
          inputDecorationTheme: InputDecorationTheme(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: lightColorScheme.outline),
                  borderRadius: BorderRadius.circular(8)))),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: isKeyboardOpened
            ? null
            : AppBar(
                toolbarHeight: 100,
              ),
        body: Column(
          children: [
            if (isKeyboardOpened)
              const SizedBox(
                height: 32,
              )
            else
              middle,
            Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 16),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(28),
                          topLeft: Radius.circular(28)),
                      color: Colors.white),
                  child: child,
                ))
          ],
        ),
      ),
    );
  }
}
