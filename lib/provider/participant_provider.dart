import 'package:flutter/material.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/service/participant_service.dart';

class ParticipantProvider extends ChangeNotifier {
  final ParticipantService participantService;

  ParticipantProvider({
    required this.participantService,
  });

  int nextBib = 0;

  Future<List<Participant>> fetchParticipants() async {
    List<Participant> participants =
        await participantService.repository.getParticipants();
    nextBib = participants.isNotEmpty? (int.parse(participants.last.bib) + 1): 0;
    return participants;
  }

  Stream<List<Participant>> get participantsStream {
    return participantService.repository.getParticipantsStream();
  }

  Future<void> addParticipant(Participant participant) async {
    await participantService.repository
        .addParticipant(participant: participant);
    notifyListeners();
  }

  Future<void> onDelete(Participant participant) async {
    await participantService.repository.deleteParticipant(id: participant.id);
    notifyListeners();
  }

  Future<void> updateParticipant(Participant participant) async {
    await participantService.repository
        .updateParticipant(participant: participant);
    notifyListeners();
  }

  void getNextBibFromStream() async {
    final participants = await participantsStream.first;
    final maxBib = participants
        .map((p) => int.tryParse(p.bib) ?? 0)
        .fold<int>(0, (prev, curr) => curr > prev ? curr : prev);
    nextBib = maxBib + 1;
  }
}
