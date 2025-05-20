import 'package:race_tracker_app/repository/firestore/firestore_participant_repository.dart';
import 'package:race_tracker_app/repository/mock/mock_race_repository.dart';
import 'package:race_tracker_app/service/participant_service.dart';
import 'package:race_tracker_app/service/race_service.dart';

class Initializer {
  static Future<void> load() async {
    // await ParticipantService.initialize(MockParticipantRepoisitory());
    await RaceService.initializer(MockRaceRepository());
    // await RaceService.initializer(FirestoreRaceRepository());
    await ParticipantService.initialize(FirestoreParticipantRepository());
  }
}
