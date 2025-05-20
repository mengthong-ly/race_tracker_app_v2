import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/model/race.dart';
import 'package:race_tracker_app/model/segment.dart';

abstract class RaceRepository {
  Future<void> refreshData();
  Future<void> setRace({required List<Participant> participants});
  Future<Race?> getRace();
  Future<void> setStartTime({required DateTime startTime});
  Future<void> setEndTime({required DateTime endTime});
  Future<void> resetRace();
  Future<void> updateRace({required Race updateRace});
  void sortParticipant();
  Future<void> setParticipantToRace({required List<Participant> participants});
  Future<Race> getCurrentRace();
  Future<void> setSegment(
      {required Segment segment,
      required Participant participant,
      required Future<void> Function(Participant participant)
          updateParticipant});
  bool get isRaceStarted;
  Future<bool> unSetSegmentForParticipant(
      {required Participant participant, required Segment segment});

  Stream<Race?> getRaceStream();
  // Future<List<Participant>> getParticipants();
  // Future<Participant?> getParticipantById({String id});
  // Future<void> addParticipant({Participant participant});
  // Future<void> updateParticipant({Participant participant});
  // Future<void> deleteParticipant({String id});
  // Future<void> banParticipant({String id});
  // Future<void> unbanParticipant({String id});
}
