import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/model/segment.dart';

class RecordSegment {
  final String id;
  final Segment segment;
  final Participant participant;
  DateTime? startTime;
  DateTime? endTime;
  final String? durationForDisplay;

  RecordSegment({
    this.durationForDisplay,
    this.endTime,
    required this.startTime,
    required this.id,
    required this.participant,
    required this.segment,
  });

  factory RecordSegment.fromJson(Map<String, dynamic> json) {
    return RecordSegment(
      id: json['id'] as String,
      segment: Segment.fromJson(json['segment'] as Map<String, dynamic>),
      participant:
          Participant.fromJson(json['participant'] as Map<String, dynamic>),
      startTime: json['startTime'] != null
          ? DateTime.tryParse(json['startTime'])
          : null,
      endTime:
          json['endTime'] != null ? DateTime.tryParse(json['endTime']) : null,
      durationForDisplay: json['durationForDisplay'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'segment': segment.toJson(),
      'participant': participant.toJson(),
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'durationForDisplay': durationForDisplay,
    };
  }

  Duration? getDurationAsSecond() {
    if (startTime != null && endTime != null) {
      final Duration duration = endTime!.difference(startTime!);
      return duration;
    }
    return null;
  }
}
