class Segment {
  final String id;
  final double distance;
  final SegmentType type;

  Segment({
    required this.id,
    required this.distance,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'distance': distance,
      'type': type.name, // Store enum as string
    };
  }

  factory Segment.fromJson(Map<String, dynamic> json) {
    return Segment(
      id: json['id'],
      distance: (json['distance'] as num).toDouble(),
      type: SegmentTypeHelper.fromName(json['type']),
    );
  }
}

enum SegmentType {
  swimming(label: 'Swimming'),
  cycling(label: 'Cycling'),
  running(label: 'Running');

  final String label;
  const SegmentType({required this.label});
}

// Helper for converting string to SegmentType
class SegmentTypeHelper {
  static SegmentType fromName(String name) {
    return SegmentType.values.firstWhere(
      (e) => e.name == name,
      orElse: () => SegmentType.running, // Default fallback
    );
  }
}
