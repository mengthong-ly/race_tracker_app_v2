import 'package:flutter/material.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/model/race.dart';
import 'package:race_tracker_app/model/segment.dart';
import 'package:race_tracker_app/screen/dashboard/dashboard_view_model.dart';
import 'package:race_tracker_app/theme/r_color.dart';
import 'package:race_tracker_app/theme/r_text.dart';

class SplitsTable extends StatelessWidget {
  const SplitsTable(
      {super.key,
      required this.race,
      required this.segmentType,
      required this.viewModel});
  final SegmentType segmentType;
  final Race race;
  final DashboardViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final List<Participant> participants = [];
    viewModel.reversedParticipants().map((participant) {
      switch (segmentType) {
        case SegmentType.running:
          if (participant.runningSegment != null) {
            participants.add(participant);
          }
          break;
        case SegmentType.cycling:
          if (participant.cyclingSegment != null) {
            participants.add(participant);
          }
          break;
        case SegmentType.swimming:
          if (participant.swimmingSegment != null) {
            participants.add(participant);
          }
          break;
      }
    }).toList();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Bib',
                style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: RColor.black,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: Text(
                'Pace',
                style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: RColor.black,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              child: Text(
                'Passing',
                style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: RColor.black,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        ...participants.map(
          (participant) {
            return buildRow(participant, segmentType);
          },
        )
      ],
    );
  }

  Widget buildRow(Participant participant, SegmentType segment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: Text(
              participant.bib,
              style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: RColor.black,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: Text(
              switch (segment) {
                SegmentType.running => participant.runningSegment != null
                    ? viewModel.calculateSpeed(
                        participant.runningSegment!.durationForDisplay,
                        participant.runningSegment!.segment.distance)
                    : '--',
                SegmentType.cycling => participant.cyclingSegment != null
                    ? viewModel.calculateSpeed(
                        participant.cyclingSegment!.durationForDisplay,
                        participant.cyclingSegment!.segment.distance)
                    : '--',
                SegmentType.swimming => participant.runningSegment != null
                    ? viewModel.calculateSpeed(
                        participant.swimmingSegment!.durationForDisplay,
                        participant.swimmingSegment!.segment.distance)
                    : '--',
              },
              style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: RColor.black,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              height: 5,
              decoration: BoxDecoration(
                color: RColor.primary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Expanded(
            child: Text(
              switch (segment) {
                SegmentType.running =>
                  (participant.runningSegment?.durationForDisplay ?? '').toString(),
                SegmentType.cycling =>
                  (participant.cyclingSegment?.durationForDisplay ?? '').toString(),
                SegmentType.swimming =>
                  (participant.swimmingSegment?.durationForDisplay ?? '').toString(),
              },
              style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: RColor.black,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
