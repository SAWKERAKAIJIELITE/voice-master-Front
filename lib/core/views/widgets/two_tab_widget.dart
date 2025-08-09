import 'package:flutter/material.dart';

class TwoTabWidget extends StatefulWidget {
  final Function(bool) onChanged;
  final String titleFirst;
  final String titleSecond;

  const TwoTabWidget(
      {super.key,
      required this.onChanged,
      required this.titleFirst,
      required this.titleSecond});

  @override
  State<TwoTabWidget> createState() => _TwoTabWidgetState();
}

class _TwoTabWidgetState extends State<TwoTabWidget> {
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FA),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            alignment: isFirst ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                        spreadRadius: -2,
                        color: const Color(0xFF171717).withOpacity(0.06)),
                    BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                        spreadRadius: -2,
                        color: const Color(0xFF171717).withOpacity(0.1))
                  ]),
              width: MediaQuery.of(context).size.width / 2 - 16,
              // margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              margin: const EdgeInsets.all(4),
              child: Text(
                '',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: const Color(0xFF475569)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFirst = true;
                      widget.onChanged(isFirst);
                    });
                  },
                  child: Text(
                    widget.titleFirst,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: isFirst ? null : const Color(0xFF475569),
                        fontWeight: isFirst ? FontWeight.w700 : null),
                    textAlign: TextAlign.center,
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isFirst = false;
                      widget.onChanged(isFirst);
                    });
                  },
                  child: Text(
                    widget.titleSecond,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: !isFirst ? null : const Color(0xFF475569),
                        fontWeight: !isFirst ? FontWeight.w700 : null),
                    textAlign: TextAlign.center,
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
