import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AppBackButton extends StatelessWidget {
  final Color? color;
  final bool showBackText;

  const AppBackButton({super.key, this.color, this.showBackText = true});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        context.pop();
      },
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.rotate(
            angle: context.locale.languageCode == 'ar' ? pi : 0,
            child: SvgPicture.asset(
              "assets/images/icon_back.svg",
              color: color,
            ),
          ),
          if (showBackText) ...[
            const SizedBox(
              width: 4,
            ),
            Text(
              'back'.tr(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: color),
            )
          ]
        ],
      ),
    );
  }
}
