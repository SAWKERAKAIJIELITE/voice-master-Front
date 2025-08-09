import 'package:flutter/material.dart';
import 'loader_widget.dart';

class MainButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonType buttonType;
  final Widget? icon;
  final Color? color;
  final Color? borderColor;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final OutlinedBorder? shape;

  const MainButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.isLoading = false,
      this.buttonType = ButtonType.elevated,
      this.icon,
      this.color,
      this.borderColor, this.padding, this.shape, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.elevated:
        return SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor??Theme.of(context).colorScheme.primary,
                padding: padding,
                shape: shape,
                foregroundColor: Colors.white),
            onPressed: onPressed,
            child: isLoading
                ? const LoaderWidget(
                    color: Colors.white,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (title.isNotEmpty)
                        Text(
                          title,
                        ),
                      const SizedBox(width: 4,),
                      icon ?? const SizedBox(),

                    ],
                  ),
          ),
        );
      case ButtonType.outlined:
        return SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: padding,
              shape: shape,
              foregroundColor: color,
              backgroundColor: backgroundColor,
              side: BorderSide(
                  color: borderColor ?? Theme.of(context).colorScheme.secondary),
            ),
            onPressed: onPressed,
            child: isLoading
                ? const LoaderWidget(
                    color: Colors.black,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (title.isNotEmpty)
                        Text(
                          title,
                        ),
                      const SizedBox(width: 4,),
                      icon ?? const SizedBox(),
                    ],
                  ),
          ),
        );
    }
  }
}

enum ButtonType { elevated, outlined }
