import 'package:logger/web.dart';
import 'package:race_tracker_app/model/enum.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/model/race.dart';
import 'package:race_tracker_app/model/record_segment.dart';
import 'package:race_tracker_app/model/segment.dart';
import 'package:race_tracker_app/repository/race_repository.dart';
import 'package:uuid/uuid.dart';

class MockRaceRepository extends RaceRepository {
  Race? race;
  Race? currentRace;
  Uuid uuid = const Uuid();
  final List<Race> history = [];

  @override
  bool get isRaceStarted => race?.startTime != null;

  @override
  Future<void> refreshData() {
    throw UnimplementedError();
  }

  @override
  Future<void> resetRace() async {
    if (race != null) {
      // Only add to history if the race has started and not already ended
      if (race!.startTime != null && race!.endTime == null) {
        race!.endTime = DateTime.now();
        race!.status = Status.finished;
        history.add(race!);
      }
    }
    currentRace = null;
    race = null;
  }

  @override
  Future<void> setEndTime({DateTime? endTime}) async {
    if (race != null) {
      // Only add to history if the race has started and not already ended
      if (race!.startTime != null && race!.endTime == null) {
        race!.endTime = endTime ?? DateTime.now();
        race!.status = Status.finished;
        history.add(race!);
      } else {
        // Just update endTime/status if needed, but don't add to history
        race!.endTime = endTime ?? DateTime.now();
        race!.status = Status.finished;
      }
    }
  }

  @override
  Future<void> setRace({List<Participant>? participants}) async {
    final ps = participants ?? [];
    race = Race(
      name: 'Race ${history.length + 1}',
      id: uuid.v4(),
      bibPrefix: '',
      status: Status.inactive,
      segments: [
        Segment(id: uuid.v4(), distance: 5, type: SegmentType.swimming),
        Segment(id: uuid.v4(), distance: 7.5, type: SegmentType.cycling),
        Segment(id: uuid.v4(), distance: 12, type: SegmentType.running),
      ],
      participants: ps,
    );
  }

  @override
  Future<void> setStartTime({DateTime? startTime}) async {
    if (race != null) {
      race!.startTime = startTime ?? DateTime.now();
      race!.status = Status.active;
      currentRace = race;
    }
  }

  @override
  Future<void> updateRace({required Race? updateRace}) async {
    if (race != null) {
      race = race;
      currentRace = race;
    }
  }

  @override
  Future<Race?> getRace() async {
    if (race == null) {
      await setRace();
      // Logger().d(race?.segments.length);
    }
    return race;
  }

  @override
  void sortParticipant() {
    final race = this.race; // Use the main race object
    if (race == null) return;

    // Helper to parse "hh:mm:ss" to seconds
    int parseDuration(String? duration) {
      if (duration == null) return 0;
      final parts = duration.split(':');
      if (parts.length != 3) return 0;
      final hours = int.tryParse(parts[0]) ?? 0;
      final minutes = int.tryParse(parts[1]) ?? 0;
      final seconds = int.tryParse(parts[2]) ?? 0;
      return hours * 3600 + minutes * 60 + seconds;
    }

    // 1. Get participants who have completed all segments
    final completed = race.participants
        .where((p) =>
            p.swimmingSegment?.durationForDisplay != null &&
            p.cyclingSegment?.durationForDisplay != null &&
            p.runningSegment?.durationForDisplay != null)
        .toList();

    // 2. Sort completed by total duration (fastest first)
    completed.sort((a, b) {
      final aTotal = parseDuration(a.swimmingSegment!.durationForDisplay) +
          parseDuration(a.cyclingSegment!.durationForDisplay) +
          parseDuration(a.runningSegment!.durationForDisplay);
      final bTotal = parseDuration(b.swimmingSegment!.durationForDisplay) +
          parseDuration(b.cyclingSegment!.durationForDisplay) +
          parseDuration(b.runningSegment!.durationForDisplay);
      return aTotal.compareTo(bTotal);
    });

    // 3. Get participants who have NOT completed all segments
    final notCompleted = race.participants
        .where((p) =>
            p.swimmingSegment?.durationForDisplay == null ||
            p.cyclingSegment?.durationForDisplay == null ||
            p.runningSegment?.durationForDisplay == null)
        .toList();

    // 4. Update the race participant list: completed (sorted) first, then not completed
    race.participants
      ..clear()
      ..addAll(completed)
      ..addAll(notCompleted);
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Future<void> setSegment(
      {required Participant participant,
      required Segment segment,
      required Future<void> Function(Participant participant)
          updateParticipant}) async {
    if (race != null) {
      int index = race!.participants.indexWhere((p) => p.id == participant.id);
      if (index != -1) {
        switch (segment.type) {
          case SegmentType.running:
            RecordSegment recordSegment = RecordSegment(
              id: uuid.v4(),
              participant: participant,
              startTime: participant.cyclingSegment!.startTime,
              durationForDisplay: formatDuration(DateTime.now().difference(
                  race!.participants[index].cyclingSegment!.endTime!)),
              segment: segment,
              endTime: DateTime.now(),
            );
            race!.participants[index].runningSegment = recordSegment;
            await updateParticipant(race!.participants[index]);
            sortParticipant();
            break;
          case SegmentType.cycling:
            RecordSegment recordSegment = RecordSegment(
              id: uuid.v4(),
              participant: participant,
              startTime: participant.swimmingSegment!.startTime,
              durationForDisplay: formatDuration(DateTime.now().difference(
                  race!.participants[index].swimmingSegment!.endTime!)),
              segment: segment,
              endTime: DateTime.now(),
            );
            race!.participants[index].cyclingSegment = recordSegment;
            await updateParticipant(race!.participants[index]);
            sortParticipant();
            break;
          case SegmentType.swimming:
            RecordSegment recordSegment = RecordSegment(
              startTime: race!.startTime,
              id: uuid.v4(),
              participant: participant,
              durationForDisplay:
                  formatDuration(DateTime.now().difference(race!.startTime!)),
              segment: segment,
              endTime: DateTime.now(),
            );
            race!.participants[index].swimmingSegment = recordSegment;
            await updateParticipant(race!.participants[index]);
            sortParticipant();
            break;
        }
      } else {
        Logger().d("Fail to complete Segment");
        // return false;
      }
    } else {
      Logger().d("Race is not exist");
      // return false;
    }
  }

  @override
  Future<bool> unSetSegmentForParticipant(
      {required Participant participant, required Segment segment}) async {
    if (race != null) {
      int index = race!.participants.indexWhere((p) => p == participant);
      if (index != -1) {
        switch (segment.type) {
          case SegmentType.running:
            Logger().d("record running");
            race!.participants[index].runningSegment = null;
            // await participantService.repository.updateParticipant(
            //     participant: race!.participants[index]);
            sortParticipant();
            return true;
          case SegmentType.cycling:
            Logger().d("record cycling");
            race!.participants[index].cyclingSegment = null;
            // await participantService.repository.updateParticipant(
            //     participant: race!.participants[index]);
            sortParticipant();

            return true;
          case SegmentType.swimming:
            Logger().d("record swimming");
            race!.participants[index].swimmingSegment = null;
            // await participantService.repository.updateParticipant(
            //     participant: _raceModel!.participants[index]);
            sortParticipant();

            return true;
        }
      } else {
        Logger().d("Fail to complete Segment");
        return false;
      }
    } else {
      Logger().d("Race is not exist");
      return false;
    }
  }

  @override
  Future<void> setParticipantToRace(
      {required List<Participant> participants}) async {
    if (race != null) {
      race!.participants.clear();
      race!.participants.addAll(participants);
    } else {
      // If race is null, create a new race with these participants
      await setRace(participants: participants);
    }
  }

  @override
  Future<Race> getCurrentRace() async {
    if (currentRace != null && currentRace!.status == Status.active) {
      return currentRace!;
    }
    return history.last;
  }

  Race? getLatestHistory() {
    if (history.isEmpty) return null;
    return history.last;
  }

  @override
  Stream<Race?> getRaceStream() {
    // TODO: implement getRaceStream
    throw UnimplementedError();
  }
}
