import 'package:flutter/material.dart';
import 'package:race_tracker_app/model/enum.dart';
import 'package:race_tracker_app/model/race.dart';
import 'package:race_tracker_app/service/participant_service.dart';
import 'package:race_tracker_app/service/race_service.dart';

class RaceProvider extends ChangeNotifier {

  RaceProvider({
    required this.participantService,
    required this.raceService,
  });

  RaceService raceService;
  ParticipantService participantService;
  Race? _raceModel;
  Race? get raceModel => _raceModel;

  Stream<Race?> get raceStream => raceService.repository.getRaceStream();

  // Fetch the current race from Firestore
  Future<void> getRace() async {
    _raceModel = await raceService.repository.getRace();

    // Always fetch latest participants
    final latestParticipants =
        await participantService.repository.getParticipants();

    // If there is no race or the last race is finished, create a new race
    if (_raceModel == null || _raceModel!.status == Status.finished) {
      await raceService.repository.setRace(participants: latestParticipants);
      _raceModel = await raceService.repository.getRace();
    } else {
      // If the race exists and the participant list has changed, update it
      final currentIds = _raceModel!.participants.map((p) => p.id).toSet();
      final latestIds = latestParticipants.map((p) => p.id).toSet();
      if (currentIds.length != latestIds.length ||
          !currentIds.containsAll(latestIds)) {
        await raceService.repository
            .setParticipantToRace(participants: latestParticipants);
        _raceModel = await raceService.repository.getRace();
      }
    }

    notifyListeners();
  }

  // Example: Start the race
  Future<void> startRace() async {
    if (_raceModel != null) {
      await raceService.repository.setParticipantToRace(
          participants: await participantService.repository.getParticipants());
      await raceService.repository.setStartTime(startTime: DateTime.now());
      await getRace();
    }
  }

  // Example: End the race
  Future<void> endRace() async {
    if (_raceModel != null) {
      await raceService.repository.setEndTime(endTime: DateTime.now());
      await getRace();
    }
  }

  // Example: Reset the race
  Future<void> resetRace() async {
    await raceService.repository.resetRace();
    await getRace();
  }
}
