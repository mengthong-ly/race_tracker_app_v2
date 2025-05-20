import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:race_tracker_app/theme/r_color.dart';
import 'package:race_tracker_app/theme/r_text.dart';

class SegmentCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String duration;
  final String label;

  const SegmentCard({
    super.key,
    required this.icon,
    required this.color,
    required this.duration,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      width: MediaQuery.of(context).size.width * 0.66,
      height: MediaQuery.of(context).size.width * 0.36,
      decoration: BoxDecoration(
        color: RColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Positioned.fill(
              right: -200,
              child: Icon(
                icon,
                color: color.withOpacity(0.1),
                size: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12)),
                    alignment: Alignment.center,
                    child: Icon(
                      FontAwesomeIcons.stopwatch,
                      color: color,
                      size: 20,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        duration,
                        style: TTextTheme.darkTextTheme.bodyLarge!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: color,
                        ),
                      ),
                      Text(
                        label,
                        style: TTextTheme.darkTextTheme.bodyLarge!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: RColor.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
