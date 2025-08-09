import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/go_router.dart';
import 'main_button.dart';

class ErrorView extends StatelessWidget {
  final String error;
  final bool showTitle;
  final Function() onRetry;

  const ErrorView(
      {super.key,
      required this.error,
      required this.onRetry,
      this.showTitle = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: (error == 'Unauthenticated.')
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showTitle)
            Text('please_login_to_access_this_feature'.tr(),
                style: Theme.of(context).textTheme.displayLarge,textAlign: TextAlign.center,),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 40,
            width: 170,
            child: MainButton(
              title: 'login'.tr(),
              onPressed: (){
                // context.push(NamedRoutes.signin);
              },
              buttonType: ButtonType.outlined,
            ),
          )
        ],
      )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showTitle)
                  Text('an_error_occurred'.tr(),
                      style: Theme.of(context).textTheme.displayLarge),
                Text(
                  error,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 40,
                  width: 170,
                  child: MainButton(
                    title: 'retry'.tr(),
                    onPressed: onRetry,
                    buttonType: ButtonType.outlined,
                    icon: const Padding(
                      padding: EdgeInsetsDirectional.only(start: 8),
                      child: Icon(Icons.refresh),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
