import 'package:flutter/material.dart';

class InfoChip extends StatelessWidget {
  final String title;
  final Color color;
  final Color? backgroundColor;
  const InfoChip({super.key, required this.title, required this.color, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor ?? color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color),
      ),
    );
  }
}
