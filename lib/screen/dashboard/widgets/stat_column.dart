import 'package:flutter/material.dart';
import 'package:race_tracker_app/theme/r_color.dart';
import 'package:race_tracker_app/theme/r_text.dart';


class StatColumn extends StatelessWidget {
  final String value;
  final String label;

  const StatColumn({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TTextTheme.darkTextTheme.bodyMedium!.copyWith(
            fontSize: 22,
            color: RColor.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: TTextTheme.darkTextTheme.bodySmall!.copyWith(fontSize: 10),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}