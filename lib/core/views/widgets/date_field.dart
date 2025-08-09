import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DateField extends StatelessWidget {
  final TextEditingController controller;
  final Function(DateTime) onChanged;
  final String? hint;
  final DateTime? firstDate;
  final DateTime? initialDate;
  final DateTime? lastDate;

  const DateField(
      {super.key,
      required this.controller,
      required this.onChanged,
      this.hint, this.firstDate, this.initialDate, this.lastDate});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hint ?? 'date'.tr(),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
                'assets/images/icon_appointments_calendar.svg'),
          )),
      onTap: () async {
        DateTime? date = await showDatePicker(
            context: context,
            firstDate: firstDate ?? DateTime.now(),
            initialDate: initialDate,
            lastDate:
                lastDate ?? DateTime.now().add(const Duration(days: 365)));
        if (date != null) {
          onChanged(date);
          controller.text =
              DateFormat('dd MMMM , y', context.locale.languageCode)
                  .format(date);
        }
      },
      readOnly: true,
    );
  }
}
