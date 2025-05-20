import 'package:logger/web.dart';
import 'package:race_tracker_app/core/base_view_model.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/model/race.dart';
import 'package:race_tracker_app/provider/race_provider.dart';
import 'package:race_tracker_app/repository/mock/mock_race_repository.dart';

class DashboardViewModel extends BaseViewModel {
  DashboardViewModel({
    required this.raceProvider,
  }) {
    // Listen to provider changes and update race
    raceProvider.addListener(_onRaceProviderChanged);
    race = raceProvider.raceModel;
  }

  final RaceProvider raceProvider;
  Race? race;

  void _onRaceProviderChanged() {
    race = raceProvider.raceModel;
    notifyListeners();
  }

  @override
  void dispose() {
    raceProvider.removeListener(_onRaceProviderChanged);
    super.dispose();
  }

  Future<void> getRace() async {
    race = await raceProvider.raceService.repository.getCurrentRace();
  }

  List<Participant> reversedParticipants() {
    return race?.participants.toList() ?? [];
  }

  String calculatePace(String? duration, double distanceKm) {
    Logger().d(duration);
    Logger().d(distanceKm);
    if (duration == null || distanceKm == 0) return '--';
    final parts = duration.split(':');
    if (parts.length != 3) return '--';
    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;
    final seconds = int.tryParse(parts[2]) ?? 0;
    final totalSeconds = hours * 3600 + minutes * 60 + seconds;
    final paceSeconds = (totalSeconds / distanceKm).round();
    final paceMinutes = (paceSeconds ~/ 60).toString().padLeft(2, '0');
    final paceRemSeconds = (paceSeconds % 60).toString().padLeft(2, '0');
    return '$paceMinutes:$paceRemSeconds';
  }

  String calculateSpeed(String? duration, double distanceKm) {
    if (duration == null || distanceKm == 0) return '--';
    final parts = duration.split(':');
    if (parts.length != 3) return '--';
    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;
    final seconds = int.tryParse(parts[2]) ?? 0;
    final totalHours = hours + (minutes / 60) + (seconds / 3600);
    if (totalHours == 0) return '--';
    final speed = distanceKm / totalHours;
    return speed.toStringAsFixed(0);
  }

  Race? get latestHistory {
    // Only works if using MockRaceRepository
    final repo = raceProvider.raceService.repository;
    if (repo is MockRaceRepository) {
      return repo.getLatestHistory();
    }
    return null;
  }
}
