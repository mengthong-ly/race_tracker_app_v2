import 'package:flutter/material.dart';
import 'package:race_tracker_app/theme/r_color.dart';
import 'package:race_tracker_app/theme/r_text.dart';

class InfoRow extends StatelessWidget {
  final String leftTitle;
  final String leftSubtitle;
  final String rightTitle;
  final String rightSubtitle;

  const InfoRow({
    super.key,
    required this.leftTitle,
    required this.leftSubtitle,
    required this.rightTitle,
    required this.rightSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  leftTitle,
                  style: TTextTheme.darkTextTheme.titleMedium!.copyWith(
                    fontSize: 18,
                    color: RColor.black,
                  ),
                ),
                Text(
                  leftSubtitle,
                  style: TTextTheme.darkTextTheme.bodyMedium!.copyWith(
                    color: RColor.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  rightTitle,
                  style: TTextTheme.darkTextTheme.titleMedium!.copyWith(
                    fontSize: 18,
                    color: RColor.black,
                  ),
                ),
                Text(
                  rightSubtitle,
                  style: TTextTheme.darkTextTheme.bodyMedium!.copyWith(
                    color: RColor.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
