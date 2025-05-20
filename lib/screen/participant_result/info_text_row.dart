import 'package:flutter/material.dart';
import 'package:race_tracker_app/theme/r_color.dart';
import 'package:race_tracker_app/theme/r_text.dart';

class InfoTextRow extends StatelessWidget {
  final String label;
  final String value;
  const InfoTextRow({super.key, required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TTextTheme.darkTextTheme.bodyMedium!.copyWith(
            color: RColor.primary.withOpacity(0.7),
          ),
        ),
        Text(value, style: TTextTheme.darkTextTheme.bodyMedium),
      ],
    );
  }
}
