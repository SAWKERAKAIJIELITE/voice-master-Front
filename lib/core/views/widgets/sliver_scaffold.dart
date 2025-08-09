import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'back_button.dart';
import 'cupertino_sliver_app_bar.dart';

class SliverScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? trailing;
  final Widget? bottomSheet;
  final SliverChildDelegate? delegate;
  final bool showBackButton;
  final Future<void> Function()? onRefresh;

  const SliverScaffold({
    super.key,
    required this.title,
    required this.body,
    this.trailing,
    this.delegate,
    this.showBackButton = true,
    this.bottomSheet,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: bottomSheet,
      body: onRefresh != null
          ? RefreshIndicator(
              onRefresh: onRefresh!,
              child: sliver(context),
            )
          : sliver(context),
    );
  }

  Widget sliver(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverAppBar(
          leading: showBackButton
              ? context.canPop()
                  ? const AppBackButton()
                  : null
              : null,
          title: title,
          trailing: trailing,
        ),
        if (delegate == null)
          SliverFillRemaining(
            child: body,
          )
        else if (delegate != null)
          SliverList(delegate: delegate!)
      ],
    );
  }
}
