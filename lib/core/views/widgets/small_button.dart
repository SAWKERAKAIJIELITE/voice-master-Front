import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    super.key,
    required this.title,
    this.borderColor,
    this.backgroundColor,
    this.onPressed,
    this.icon, this.radius=8, this.textStyle, this.padding,
  });

  final String title;
  final Color? borderColor;
  final Color? backgroundColor;
  final Function()? onPressed;
  final double radius;
  final Widget? icon;
  final TextStyle? textStyle;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Container(
        padding: padding??const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            color: backgroundColor??Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: borderColor??Colors.transparent)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style:textStyle?? Theme.of(context).textTheme.titleSmall,
            ),
            if (icon != null) ...[
              const SizedBox(
                width: 8,
              ),
              icon!
            ]
          ],
        ),
      ),
    );
  }
}
