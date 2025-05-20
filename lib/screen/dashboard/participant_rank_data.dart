import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/screen/participant_result/participant_result_view.dart';
import 'package:race_tracker_app/theme/r_color.dart';
import 'package:race_tracker_app/theme/r_text.dart';
import 'package:race_tracker_app/theme/t_constant.dart';

class ParticipantRankData extends StatelessWidget {
  const ParticipantRankData({
    super.key,
    required this.participant,
    required this.index,
  });
  final int index;
  final Participant participant;

  Color get color => (participant.swimmingSegment != null &&
          participant.cyclingSegment != null &&
          participant.runningSegment != null)
      ? RColor.positive
      : RColor.warning;

  String get status => (participant.swimmingSegment != null &&
          participant.cyclingSegment != null &&
          participant.runningSegment != null)
      ? 'finished'
      : 'progress';

  void onViewRecordDetail(BuildContext context) {
    print('Mengthong: ');
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) {
          return ParticipantResultView(
            rank: index,
            participant: participant,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onViewRecordDetail(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          decoration: const BoxDecoration(
            color: RColor.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: RColor.primary.withOpacity(0.1)),
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Text(
                          index.toString(),
                          style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: RColor.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      participant.bib,
                      style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: RColor.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 3,
                          backgroundColor: color,
                        ),
                        THorizontalSpacing.s,
                        Text(
                          status,
                          style: TTextTheme.darkTextTheme.bodySmall!
                              .copyWith(color: RColor.black, fontSize: 10),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 58,
                      height: 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: RColor.primary,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        participant.swimmingSegment?.durationForDisplay ??
                            '--:--:--',
                        style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: RColor.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 58,
                      height: 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: RColor.primary,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        participant.cyclingSegment?.durationForDisplay ??
                            '--:--:--',
                        style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: RColor.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 58,
                      height: 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: RColor.primary,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        participant.runningSegment?.durationForDisplay ??
                            '--:--:--',
                        style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: RColor.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
