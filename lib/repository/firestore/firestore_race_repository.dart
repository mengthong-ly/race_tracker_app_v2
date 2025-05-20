import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:race_tracker_app/model/enum.dart';
import 'package:race_tracker_app/model/race.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/model/record_segment.dart';
import 'package:race_tracker_app/model/segment.dart';
import 'package:race_tracker_app/repository/race_repository.dart';

class FirestoreRaceRepository extends RaceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _raceCollection = 'races';
  final String _currentRaceDoc = 'current';

  DocumentReference get _raceDoc =>
      _firestore.collection(_raceCollection).doc(_currentRaceDoc);

  @override
  Stream<Race?> getRaceStream() {
    return _raceDoc.snapshots().map((doc) {
      if (!doc.exists) return null;
      return Race.fromFirestore(doc);
    });
  }

  @override
  Future<Race?> getRace() async {
    final doc = await _raceDoc.get();
    if (!doc.exists) return null;
    return Race.fromFirestore(doc);
  }

  @override
  Future<Race> getCurrentRace() async {
    final doc = await _raceDoc.get();
    if (!doc.exists) throw Exception('No current race');
    return Race.fromFirestore(doc);
  }

  @override
  bool get isRaceStarted {
    // This is not reactive, but you can use the stream for real-time status.
    throw UnimplementedError('Use getRaceStream for real-time status.');
  }

  @override
  Future<void> refreshData() async {
    // No-op for Firestore, as we use streams.
  }

  @override
  Future<void> resetRace() async {
    // Optionally archive the race before deleting
    final doc = await _raceDoc.get();
    if (doc.exists) {
      // You can add archiving logic here if needed
      await _raceDoc.delete();
    }
  }

  @override
  Future<void> setEndTime({required DateTime endTime}) async {
    await _raceDoc.update({
      'endTime': endTime.toIso8601String(),
      'status': 'finished',
    });
  }

  @override
  Future<void> setParticipantToRace(
      {required List<Participant> participants}) async {
    await _raceDoc.update({
      'participants': participants.map((p) => p.toJson()).toList(),
    });
  }

  @override
  Future<void> setRace({required List<Participant> participants}) async {
    final race = Race(
      id: _currentRaceDoc,
      name: 'Race',
      bibPrefix: '',
      status: Status.inactive,
      segments: [
        Segment(id: '1', distance: 5, type: SegmentType.swimming),
        Segment(id: '2', distance: 7.5, type: SegmentType.cycling),
        Segment(id: '3', distance: 12, type: SegmentType.running),
      ],
      participants: participants,
    );
    await _raceDoc.set(race.toJson());
  }

  @override
  Future<void> setSegment({
    required Segment segment,
    required Participant participant,
    required Future<void> Function(Participant participant) updateParticipant,
  }) async {
    final doc = await _raceDoc.get();
    if (!doc.exists) return;
    final race = Race.fromFirestore(doc);
    final idx = race.participants.indexWhere((p) => p.id == participant.id);
    if (idx == -1) return;

    final now = DateTime.now();
    switch (segment.type) {
      case SegmentType.swimming:
        if (race.participants[idx].swimmingSegment == null) {
          final start = race.startTime ?? now;
          final recordSegment = RecordSegment(
            id: segment.id,
            participant: participant,
            startTime: start,
            endTime: now,
            durationForDisplay: _formatDuration(now.difference(start)),
            segment: segment,
          );
          race.participants[idx].swimmingSegment = recordSegment;
          await updateParticipant(race.participants[idx]);
        }
        break;
      case SegmentType.cycling:
        final swimSeg = race.participants[idx].swimmingSegment;
        if (swimSeg != null && race.participants[idx].cyclingSegment == null) {
          final start = swimSeg.endTime ?? now;
          final recordSegment = RecordSegment(
            id: segment.id,
            participant: participant,
            startTime: start,
            endTime: now,
            durationForDisplay: _formatDuration(now.difference(start)),
            segment: segment,
          );
          race.participants[idx].cyclingSegment = recordSegment;
          await updateParticipant(race.participants[idx]);
        }
        break;
      case SegmentType.running:
        final cycleSeg = race.participants[idx].cyclingSegment;
        if (cycleSeg != null && race.participants[idx].runningSegment == null) {
          final start = cycleSeg.endTime ?? now;
          final recordSegment = RecordSegment(
            id: segment.id,
            participant: participant,
            startTime: start,
            endTime: now,
            durationForDisplay: _formatDuration(now.difference(start)),
            segment: segment,
          );
          race.participants[idx].runningSegment = recordSegment;
          await updateParticipant(race.participants[idx]);
        }
        break;
    }
    await updateRace(updateRace: race);
  }

  @override
  Future<void> setStartTime({required DateTime startTime}) async {
    await _raceDoc.update({
      'startTime': startTime.toIso8601String(),
      'status': Status.active.name,
    });
  }

  @override
  void sortParticipant() {
    // Sorting is handled in Dart after fetching, not in Firestore
  }

  @override
  Future<bool> unSetSegmentForParticipant({
    required Participant participant,
    required Segment segment,
  }) async {
    final doc = await _raceDoc.get();
    if (!doc.exists) return false;
    final race = Race.fromFirestore(doc);
    final idx = race.participants.indexWhere((p) => p.id == participant.id);
    if (idx == -1) return false;

    switch (segment.type) {
      case SegmentType.running:
        race.participants[idx].runningSegment = null;
        break;
      case SegmentType.cycling:
        race.participants[idx].cyclingSegment = null;
        break;
      case SegmentType.swimming:
        race.participants[idx].swimmingSegment = null;
        break;
    }
    await updateRace(updateRace: race);
    return true;
  }

  @override
  Future<void> updateRace({required Race updateRace}) async {
    await _raceDoc.set(updateRace.toJson());
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }
}
