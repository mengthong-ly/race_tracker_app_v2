import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/provider/race_provider.dart';
import 'package:race_tracker_app/screen/participant/participant_view_model.dart';
import 'package:race_tracker_app/screen/participant_detail/participant_detail_view.dart';
import 'package:race_tracker_app/theme/r_color.dart';
import 'package:race_tracker_app/theme/r_text.dart';
import 'package:race_tracker_app/theme/t_constant.dart';

class ParticipantTile extends StatelessWidget {
  const ParticipantTile(
      {super.key, required this.participant, required this.viewModel});
  final ParticipantViewModel viewModel;
  final Participant participant;

  @override
  Widget build(BuildContext context) {
    final isSelected = viewModel.participantForRemoves.contains(participant);

    return GestureDetector(
      onLongPress: () {
        if (!viewModel.isSelectedForRemove) {
          viewModel.toggleSelectionMode();
          viewModel.toggleSelectedForRemove(participant);
        }
      },
      onTap: context.read<RaceProvider>().raceService.repository.isRaceStarted
          ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: RColor.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  duration: const Duration(seconds: 2),
                  content: const Text('Race Already Started'),
                ),
              );
            }
          : () {
              if (viewModel.isSelectedForRemove) {
                viewModel.toggleSelectedForRemove(participant);
              } else {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) {
                      return ParticipantDetailView(
                          participant: participant, isEdit: true);
                    },
                  ),
                );
              }
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: viewModel.isSelectedForRemove && isSelected
              ? RColor.primary.withOpacity(0.1)
              : RColor.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: RColor.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.person_rounded,
                color: RColor.primary,
              ),
            ),
            THorizontalSpacing.l,
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(participant.name,
                    style: TTextTheme.darkTextTheme.bodyMedium),
                Text(participant.bib),
              ],
            ),
            const Spacer(),
            if (viewModel.isSelectedForRemove)
              Icon(
                isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                color: RColor.primary,
              )
            else
              const Icon(Icons.navigate_next_rounded, color: RColor.primary),
          ],
        ),
      ),
    );
  }
}
