import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomSheetTitle extends StatelessWidget {
  final String title;
  final bool showCloseButton;

  const BottomSheetTitle(
      {super.key, required this.title, this.showCloseButton = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(showCloseButton)...[
          const SizedBox(width: 16,),
          const IconButton(onPressed: null,
              icon: Icon(Icons.close, color: Colors.transparent,)),
        ],
        Expanded(
          child: Text(
            textAlign: TextAlign.center,
            title,
            style: Theme
                .of(context)
                .textTheme
                .displaySmall,
          ),
        ),
        if(showCloseButton)...[
          IconButton(onPressed: () {
            context.pop();
          }, icon: const Icon(Icons.close),),
        ],
        const SizedBox(width: 16,)
      ],
    );
  }
}
