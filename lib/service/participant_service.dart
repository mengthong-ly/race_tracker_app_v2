import 'package:race_tracker_app/repository/participant_repository.dart';

class ParticipantService {
  static ParticipantService? _instance;

  final ParticipantRepository repository;
  ParticipantService._privateInstance({required this.repository});

  static Future<void> initialize(
      ParticipantRepository participantRepository) async {
    if (_instance == null) {
      _instance = ParticipantService._privateInstance(
          repository: participantRepository);
    } else {
      throw Exception("ParticipantService is already initialized");
    }
  }
  static ParticipantService get instance {
    if (_instance == null) {
      throw Exception("ParticipantService is not initialized");
    }
    return _instance!;
  }
}
