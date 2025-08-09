import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final String? svgIcon;
  final Color? color;
  final Function() onPressed;

  const ActionButton(
      {super.key,
      required this.title,
      this.svgIcon,
      this.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              foregroundColor: color ?? Theme.of(context).colorScheme.tertiary,
              backgroundColor: color?.withOpacity(0.1),
              side: BorderSide(
                  color: color ?? Theme.of(context).colorScheme.tertiary),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (svgIcon != null) ...[
                SvgPicture.asset('assets/images/$svgIcon.svg'),
                const SizedBox(
                  width: 4,
                )
              ],
              Text(title),
            ],
          )),
    );
  }
}
