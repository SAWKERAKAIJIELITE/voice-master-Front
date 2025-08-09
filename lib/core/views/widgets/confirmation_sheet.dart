import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'main_button.dart';

class ConfirmationSheet extends StatefulWidget {
  final String yesText;
  final String noText;
  final Function() onYes;
  final Function() onNo;
  final String message;
  final String assetPath;

  const ConfirmationSheet(
      {super.key,
      required this.yesText,
      required this.noText,
      required this.onYes,
      required this.onNo,
      required this.message,
      required this.assetPath});

  @override
  State<ConfirmationSheet> createState() => _ConfirmationSheetState();
}

class _ConfirmationSheetState extends State<ConfirmationSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Image.asset(
            widget.assetPath,
            height: 135,
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              widget.message,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: MainButton(
                    icon: SvgPicture.asset('assets/images/icon_yes.svg'),
                    title: widget.yesText,
                    onPressed: widget.onYes),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: MainButton(
                  title: widget.noText,
                  onPressed: widget.onNo,
                  icon:
                      SvgPicture.asset('assets/images/icon_no.svg'),
                  borderColor: Theme.of(context).colorScheme.primary,
                  color: Theme.of(context).colorScheme.primary,
                  buttonType: ButtonType.outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
