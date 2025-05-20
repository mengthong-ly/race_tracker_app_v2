import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker_app/model/enum.dart';
import 'package:race_tracker_app/provider/race_provider.dart';
import 'package:race_tracker_app/screen/race/race_view_model.dart';
import 'package:race_tracker_app/theme/r_color.dart';
import 'package:race_tracker_app/theme/r_text.dart';
import 'package:race_tracker_app/theme/t_constant.dart';

class RaceTimerDisplay extends StatelessWidget {
  const RaceTimerDisplay({
    super.key,
    required this.viewModel,
    required this.context,
  });

  final RaceViewModel viewModel;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final timer = viewModel.timerController;
    return Column(
      children: [
        Row(
          children: [
            Text(
              viewModel.race?.name ?? '--',
              style: TTextTheme.darkTextTheme.titleLarge,
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: RColor.secondary.withOpacity(0.4),
                  width: 1,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Text(
                viewModel.race?.status.label ?? '',
                // widget.segment.status.label,
                // 'Not Started',
                style: TTextTheme.darkTextTheme.bodyMedium,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TVerticalSpacing.xl,
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: RColor.primary.withOpacity(0.4),
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Center(
                    child: viewModel.race?.status == Status.active
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                timer.stopTimeDisplay,
                                style: const TextStyle(
                                  fontSize: 40,
                                  color: RColor.black,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "--:--:--",
                                style: TextStyle(
                                  fontSize: 40,
                                  color: RColor.black,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          )),
              ),
              TVerticalSpacing.xxl,
            ],
          ),
        ),
      ],
    );
  }
}
