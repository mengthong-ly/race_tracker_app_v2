import 'package:flutter/material.dart';
import 'package:race_tracker_app/theme/r_color.dart';
import 'package:race_tracker_app/theme/r_text.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: RColor.primary),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        title,
        style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: RColor.black,
        ),
      ),
    );
  }
}