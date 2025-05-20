import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker_app/core/base_view_model.dart';
import 'package:race_tracker_app/model/enum.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/model/race.dart';
import 'package:race_tracker_app/provider/race_provider.dart';
import 'package:race_tracker_app/screen/race/race_timer_controller.dart';

class RaceViewModel extends BaseViewModel {
  final BuildContext context;
  late final RaceTimerController timerController;

  RaceViewModel({required this.context}) {
    timerController = RaceTimerController(
      raceProvider: context.read<RaceProvider>(),
    );
  }

  Race? get race => context.read<RaceProvider>().raceModel;
  bool get isReady => race != null;
  // bool get isRaceStarted => timerController.isRaceStarted;
  bool get isRaceStarted =>
      context.read<RaceProvider>().raceModel?.status == Status.active;

  Future<Race?> init() async {
    await context.read<RaceProvider>().getRace();
    Race? race =
        await context.read<RaceProvider>().raceService.repository.getRace();
    if (isRaceStarted) {
      timerController.start();
    }
    if (race != null) {
      notifyListeners();
      return race;
    }
    return null;
  }

  void startRace() async {
    await context
        .read<RaceProvider>()
        .raceService
        .repository
        .setStartTime(startTime: DateTime.now());
    timerController.start();
    notifyListeners();
  }

  void stopRace() async {
    await context.read<RaceProvider>().resetRace();
    timerController.stop();
    notifyListeners();
  }

  void resetRace() {
    context.read<RaceProvider>().raceModel!.startTime = null;
    context.read<RaceProvider>().raceModel!.endTime = null;
    timerController.stop();
    notifyListeners();
  }

  List<Participant> sortedParticipantsForDisplay(
      List<Participant> participants) {
    // Clone the list to avoid mutating the original
    final cloned = List<Participant>.from(participants);

    // Split into unfinished and finished
    final unfinished = cloned
        .where((p) =>
            p.swimmingSegment?.durationForDisplay == null ||
            p.cyclingSegment?.durationForDisplay == null ||
            p.runningSegment?.durationForDisplay == null)
        .toList();

    final finished = cloned
        .where((p) =>
            p.swimmingSegment?.durationForDisplay != null &&
            p.cyclingSegment?.durationForDisplay != null &&
            p.runningSegment?.durationForDisplay != null)
        .toList();

    // (Optional) Sort finished by total duration, fastest first
    int parseDuration(String? duration) {
      if (duration == null) return 0;
      final parts = duration.split(':');
      if (parts.length != 3) return 0;
      final h = int.tryParse(parts[0]) ?? 0;
      final m = int.tryParse(parts[1]) ?? 0;
      final s = int.tryParse(parts[2]) ?? 0;
      return h * 3600 + m * 60 + s;
    }

    finished.sort((a, b) {
      final aTotal = parseDuration(a.swimmingSegment!.durationForDisplay) +
          parseDuration(a.cyclingSegment!.durationForDisplay) +
          parseDuration(a.runningSegment!.durationForDisplay);
      final bTotal = parseDuration(b.swimmingSegment!.durationForDisplay) +
          parseDuration(b.cyclingSegment!.durationForDisplay) +
          parseDuration(b.runningSegment!.durationForDisplay);
      return aTotal.compareTo(bTotal);
    });

    // Combine: unfinished first, then finished
    return [...unfinished, ...finished];
  }

  @override
  void dispose() {
    timerController.dispose();
    super.dispose();
  }
}
