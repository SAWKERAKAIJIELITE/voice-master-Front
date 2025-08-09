import 'package:flutter/material.dart';

class ExpansionWidget extends StatefulWidget {
  final String title;
  final Widget child;
  final Widget? leading;
  final Widget? trailing;

  const ExpansionWidget({
    super.key,
    required this.title,
    required this.child,
    this.leading,
    this.trailing,
  });

  @override
  State<ExpansionWidget> createState() => _ExpansionWidgetState();
}

class _ExpansionWidgetState extends State<ExpansionWidget> {
  bool isOpened = false;
  final dataKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: dataKey,
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  // if (isOpened == false) {
                  //   widget.onPressed!();
                  // }
                  isOpened = !isOpened;
                  setState(() {});
                  if (isOpened) {
                    Future.delayed(const Duration(milliseconds: 50), () {
                      Scrollable.ensureVisible(dataKey.currentContext!);
                    });
                  }
                },
                child: ListTile(
                  title: Text(widget.title),
                  leading: widget.leading,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.trailing ?? const SizedBox(),
                      Transform.rotate(
                        angle: isOpened ? 4.72 : 0,
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(visible: isOpened, child: widget.child)
        ],
      ),
    );
  }
}
