import 'package:race_tracker_app/core/base_view_model.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/provider/participant_provider.dart';
import 'package:race_tracker_app/provider/race_provider.dart';

class ParticipantViewModel extends BaseViewModel {
  ParticipantViewModel({
    required this.participantProvider,
    required this.raceProvider,
  });

  List<Participant> participantForRemoves = [];
  bool isSelectedForRemove = false;

  ParticipantProvider participantProvider;
  RaceProvider raceProvider;

  void onCancelRemove() {
    isSelectedForRemove = false;
    participantForRemoves.clear();
    notifyListeners();
  }

  void toggleSelectionMode() {
    isSelectedForRemove = !isSelectedForRemove;
    if (!isSelectedForRemove) {
      participantForRemoves.clear();
    }
    notifyListeners();
  }

  void toggleSelectedForRemove(Participant participant) {
    if (participantForRemoves.contains(participant)) {
      participantForRemoves.remove(participant);
    } else {
      participantForRemoves.add(participant);
    }
    notifyListeners();
  }

  Future<void> removeParticipants() async {
    for (Participant participantForRemove in participantForRemoves) {
      await participantProvider.onDelete(participantForRemove);
    }
    participantForRemoves.clear();
    isSelectedForRemove = false;
    notifyListeners();
  }
}
