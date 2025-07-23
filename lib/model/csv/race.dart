import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:race_tracker_app/model/enum.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/model/segment.dart';

class Race {
  DateTime? startTime;
  DateTime? endTime;
  final String? bibPrefix;
  Status status;
  final String id;
  final String? name;

  final List<Segment> segments;
  final List<Participant> participants;

  Race({
    this.startTime,
    this.endTime,
    this.status = Status.inactive,
    required this.name,
    required this.id,
    required this.bibPrefix,
    List<Participant>? participants,
    List<Segment>? segments,
  })  : participants = participants ?? [],
        segments = segments ?? [];

  // --- Add fromJson and toJson below ---
  factory Race.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Race(
      id: doc.id,
      name: data['name'] as String?,
      bibPrefix: data['bibPrefix'] as String?,
      status: Status.values.firstWhere(
        (e) => e.name == data['status'],
        orElse: () => Status.inactive,
      ),
      startTime: data['startTime'] != null
          ? DateTime.tryParse(data['startTime'])
          : null,
      endTime:
          data['endTime'] != null ? DateTime.tryParse(data['endTime']) : null,
      segments: (data['segments'] as List<dynamic>?)
              ?.map((e) => Segment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      participants: (data['participants'] as List<dynamic>?)
              ?.map((e) => Participant.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bibPrefix': bibPrefix,
      'status': status.name,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'segments': segments.map((e) => e.toJson()).toList(),
      'participants': participants.map((e) => e.toJson()).toList(),
    };
  }

  double sumAllDistances() {
    double totalDistance = 0.0;
    for (var segment in segments) {
      totalDistance += segment.distance;
    }
    return totalDistance;
  }

  double percentageOfFinishedParticipants() {
    if (participants.isEmpty) {
      return 0.0;
    }
    int finishedCount = 0;
    for (var participant in participants) {
      if (participant.runningSegment?.endTime != null &&
          participant.cyclingSegment?.endTime != null &&
          participant.swimmingSegment?.endTime != null) {
        finishedCount++;
      }
    }
    return (finishedCount / participants.length) * 100;
  }

  double percentageOfSingleParticipantBeatOtherOnSwimming(
      Participant participant) {
    int count = 0;

    for (var otherParticipant in participants) {
      if (otherParticipant != participant &&
          otherParticipant.swimmingSegment?.endTime != null &&
          participant.swimmingSegment?.endTime != null &&
          otherParticipant.swimmingSegment!.endTime!
              .isAfter(participant.swimmingSegment!.endTime!)) {
        count++;
      }
    }

    return (1 - (count / (participants.length - 1))) * 100;
  }

  int countFinishedParticipants() {
    int count = 0;
    for (var participant in participants) {
      if (participant.runningSegment?.endTime != null &&
          participant.cyclingSegment?.endTime != null &&
          participant.swimmingSegment?.endTime != null) {
        count++;
      }
    }
    return count;
  }

  int countGirlParticipants() {
    int count = 0;
    for (var participant in participants) {
      if (participant.gender == Gender.female) {
        count++;
      }
    }
    return count;
  }

  int countBoyParticipants() {
    int count = 0;
    for (var participant in participants) {
      if (participant.gender == Gender.male) {
        count++;
      }
    }
    return count;
  }

  int countKidParticipants() {
    int count = 0;
    for (var participant in participants) {
      if (participant.age < 16) {
        count++;
      }
    }
    return count;
  }
}
