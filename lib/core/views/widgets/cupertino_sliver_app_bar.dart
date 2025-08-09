import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoSliverAppBar extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;
  const CupertinoSliverAppBar({super.key, required this.title, this.leading, this.trailing});

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      alwaysShowMiddle: false,
      leading: leading,
      trailing: trailing,
      largeTitle: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
      middle: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
