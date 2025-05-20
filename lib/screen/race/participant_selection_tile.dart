import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/model/segment.dart';
import 'package:race_tracker_app/provider/participant_provider.dart';
import 'package:race_tracker_app/provider/race_provider.dart';
import 'package:race_tracker_app/theme/r_color.dart';
import 'package:race_tracker_app/theme/r_text.dart';

class ParticipantSelectionTile extends StatefulWidget {
  const ParticipantSelectionTile({
    super.key,
    required this.index,
    required this.participant,
    required this.segment,
    required this.isSelectable,
    this.segmentEndTime,
  });
  final bool isSelectable;
  final int index;
  final Participant participant;
  final Segment segment;
  final DateTime? segmentEndTime;

  @override
  State<ParticipantSelectionTile> createState() =>
      _ParticipantSelectionTileState();
}

class _ParticipantSelectionTileState extends State<ParticipantSelectionTile> {
  bool isChecked = false;
  bool isLoading = false;

  bool get isSegmentFinished {
    switch (widget.segment.type) {
      case SegmentType.running:
        return widget.participant.runningSegment != null;
      case SegmentType.cycling:
        return widget.participant.cyclingSegment != null;
      case SegmentType.swimming:
        return widget.participant.swimmingSegment != null;
    }
  }

  Widget buildLoading(Widget child) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 2,
              backgroundColor: RColor.primary,
              valueColor: AlwaysStoppedAnimation<Color>(RColor.white),
            ),
          )
        : child;
  }

  @override
  Widget build(BuildContext context) {
    return isSegmentFinished && !isLoading
        ? buildFinishedBib()
        : buildLoading(
            GestureDetector(
              onTap: widget.isSelectable
                  ? () async {
                      setState(() {
                        isLoading = true;
                      });
                      await context
                          .read<RaceProvider>()
                          .raceService
                          .repository
                          .setSegment(
                            participant: widget.participant,
                            segment: widget.segment,
                            updateParticipant: context.read<ParticipantProvider>().updateParticipant
                          );
                      if (!mounted) return;
                      setState(() {
                        isLoading = false;
                      });
                    }
                  : null,
              child:
                  widget.isSelectable ? buildInProgressBib() : buildBlurBib(),
            ),
          );
  }

  Widget buildFinishedBib() {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        await context
            .read<RaceProvider>()
            .raceService
            .repository
            .unSetSegmentForParticipant(
                participant: widget.participant, segment: widget.segment);
        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: RColor.primary.withOpacity(0.4),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: RColor.primary.withOpacity(0.2),
        ),
        child: Stack(
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  (widget.participant.bib).toString(),
                  style: TTextTheme.darkTextTheme.bodyMedium!.copyWith(
                    color: RColor.primary,
                  ),
                ),
              ),
            ),
            const Positioned(
              right: 4,
              top: 4,
              child: Icon(
                Icons.check_circle_rounded,
                color: RColor.primary,
                size: 20,
              ),
            ),
            Positioned(
              right: 0,
              left: 33,
              bottom: 0,
              child: Text(
                switch (widget.segment.type) {
                  SegmentType.running =>
                    widget.participant.runningSegment!.durationForDisplay ??
                        '--',
                  SegmentType.cycling =>
                    widget.participant.cyclingSegment!.durationForDisplay ??
                        '--',
                  SegmentType.swimming =>
                    widget.participant.swimmingSegment!.durationForDisplay ??
                        '--',
                },
                style: TTextTheme.darkTextTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildInProgressBib() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: RColor.primary.withOpacity(0.4),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          (widget.participant.bib).toString(),
          style: TTextTheme.darkTextTheme.bodyMedium!.copyWith(
            color: RColor.black.withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  Container buildBlurBib() {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border.all(
          color: RColor.primary.withOpacity(0.4),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    (widget.participant.bib).toString(),
                    style: TTextTheme.darkTextTheme.bodyMedium!.copyWith(
                      color: RColor.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                color: RColor.primary.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
