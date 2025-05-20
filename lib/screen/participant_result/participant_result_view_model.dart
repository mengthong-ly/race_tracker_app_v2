import 'package:race_tracker_app/core/base_view_model.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/model/race.dart';
import 'package:race_tracker_app/provider/participant_provider.dart';
import 'package:race_tracker_app/provider/race_provider.dart';

class ParticipantResultViewModel extends BaseViewModel {
  ParticipantResultViewModel({
    required this.participant,
    required this.raceProvider,
    required this.participantProvider,
    required this.rank,
  });

  final RaceProvider raceProvider;
  final ParticipantProvider participantProvider;
  final Participant participant;
  int rank;
  Race? race;

  Future<void> setRace() async {
    race = await raceProvider.raceService.repository.getCurrentRace();
  }

  int? get getRank => participant.swimmingSegment != null &&
          participant.cyclingSegment != null &&
          participant.runningSegment != null
      ? rank
      : null;

  // Add this to your ParticipantResultViewModel
  Map<String, double> getAverageDurations() {
    // Helper to parse "hh:mm:ss" to seconds
    int parseDuration(String? duration) {
      if (duration == null) return 0;
      final parts = duration.split(':');
      if (parts.length != 3) return 0;
      final h = int.tryParse(parts[0]) ?? 0;
      final m = int.tryParse(parts[1]) ?? 0;
      final s = int.tryParse(parts[2]) ?? 0;
      return h * 3600 + m * 60 + s;
    }

    final participants = raceProvider.raceModel?.participants ??
        []; // Provide this list in your ViewModel

    double avg(String segment) {
      final durations = participants
          .map((p) {
            switch (segment) {
              case 'swimming':
                return parseDuration(p.swimmingSegment?.durationForDisplay);
              case 'cycling':
                return parseDuration(p.cyclingSegment?.durationForDisplay);
              case 'running':
                return parseDuration(p.runningSegment?.durationForDisplay);
              default:
                return 0;
            }
          })
          .where((d) => d > 0)
          .toList();
      if (durations.isEmpty) return 0;
      return durations.reduce((a, b) => a + b) / durations.length;
    }

    return {
      'swimming': avg('swimming'),
      'cycling': avg('cycling'),
      'running': avg('running'),
    };
  }

  String formatDurationHHMMSS(Duration? duration) {
    if (duration == null) return '--:--:--';
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "${hours}h${minutes}min${seconds}s";
  }
}
