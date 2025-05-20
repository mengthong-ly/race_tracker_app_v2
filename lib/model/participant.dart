import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:race_tracker_app/model/enum.dart';
import 'package:race_tracker_app/model/record_segment.dart';

class Participant {
  final String id;
  final String bib;
  final int age;
  final String name;
  final String? email;
  final String phone;
  final DateTime createdAt;
  final Nation nation;
  final Gender? gender;

  RecordSegment? runningSegment;
  RecordSegment? cyclingSegment;
  RecordSegment? swimmingSegment;

  bool isBanned;

  Participant({
    this.nation = Nation.cn,
    required this.id,
    this.email,
    required this.createdAt,
    required this.gender,
    required this.age,
    required this.name,
    required this.bib,
    required this.phone,
    this.isBanned = false,
    this.runningSegment,
    this.cyclingSegment,
    this.swimmingSegment,
  });

  // Add this factory constructor
  factory Participant.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Participant(
      id: doc.id, // Always use doc.id for Firestore documents
      bib: data['bib'] ?? '',
      age: data['age'] ?? 0,
      name: data['name'] ?? '',
      email: data['email'],
      phone: data['phone'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      nation: Nation.values.firstWhere(
        (e) => e.name == (data['nation'] ?? 'cn'),
        orElse: () => Nation.cn,
      ),
      gender: data['gender'] != null
          ? Gender.values.firstWhere(
              (e) => e.name == data['gender'],
              orElse: () => Gender.male,
            )
          : null,
      isBanned: data['isBanned'] ?? false,
      // You may need to handle segments if you store them in Firestore
      runningSegment: null,
      cyclingSegment: null,
      swimmingSegment: null,
    );
  }

  factory Participant.fromJson(Map<String, dynamic> data) {
    return Participant(
      id: data['id'] ?? '', // Make sure to store 'id' in your Firestore doc
      bib: data['bib'] ?? '',
      age: data['age'] ?? 0,
      name: data['name'] ?? '',
      email: data['email'],
      phone: data['phone'] ?? '',
      createdAt: data['createdAt'] is Timestamp
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.tryParse(data['createdAt'] ?? '') ?? DateTime.now(),
      nation: Nation.values.firstWhere(
        (e) => e.name == (data['nation'] ?? 'cn'),
        orElse: () => Nation.cn,
      ),
      gender: data['gender'] != null
          ? Gender.values.firstWhere(
              (e) => e.name == data['gender'],
              orElse: () => Gender.male,
            )
          : null,
      isBanned: data['isBanned'] ?? false,
      runningSegment: data['runningSegment'] != null
          ? RecordSegment.fromJson(data['runningSegment'])
          : null,
      cyclingSegment: data['cyclingSegment'] != null
          ? RecordSegment.fromJson(data['cyclingSegment'])
          : null,
      swimmingSegment: data['swimmingSegment'] != null
          ? RecordSegment.fromJson(data['swimmingSegment'])
          : null,
    );
  }

  // Add this method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bib': bib,
      'age': age,
      'name': name,
      'email': email,
      'phone': phone,
      'createdAt': createdAt,
      'nation': nation.name,
      'gender': gender?.name,
      'isBanned': isBanned,
      // Add segments if you want to store them
    };
  }

  String get status {
    if (runningSegment != null &&
        cyclingSegment != null &&
        swimmingSegment != null) {
      return 'finished';
    } else {
      return 'progress';
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Participant &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
