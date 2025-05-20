import 'dart:async';
import 'package:flutter/material.dart';
import 'package:race_tracker_app/provider/race_provider.dart';

class RaceTimerController extends ChangeNotifier {
  String stopTimeDisplay = "00:00:00";
  Timer? _timer;
  final RaceProvider raceProvider;

  RaceTimerController({required this.raceProvider});

  bool get isRaceStarted => raceProvider.raceService.repository.isRaceStarted;

  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateDisplay();
    });
    _updateDisplay();
  }

  void stop() {
    _timer?.cancel();
    _updateDisplay();
  }

  void _updateDisplay() {
    if (raceProvider.raceModel?.startTime != null && raceProvider.raceModel?.endTime == null) {
      final elapsed = DateTime.now().difference(raceProvider.raceModel!.startTime!);
      stopTimeDisplay = _formatDuration(elapsed);
    } else if (raceProvider.raceModel?.startTime != null && raceProvider.raceModel!.endTime != null) {
      final elapsed = raceProvider.raceModel!.endTime!.difference(raceProvider.raceModel!.startTime!);
      stopTimeDisplay = _formatDuration(elapsed);
    } else {
      stopTimeDisplay = "00:00:00";
    }
    notifyListeners();
  }

  String _formatDuration(Duration d) {
    final hours = d.inHours.toString().padLeft(2, '0');
    final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
