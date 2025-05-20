import 'package:flutter/material.dart';
import 'package:race_tracker_app/theme/r_color.dart';

class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: RColor.primary,
          width: 1,
        ),
      ),
      child: Text(text),
    );
  }
}
