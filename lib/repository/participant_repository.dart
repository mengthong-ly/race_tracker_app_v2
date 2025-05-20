import 'package:race_tracker_app/model/participant.dart';

abstract class ParticipantRepository {
  void refreshData();
  Future<List<Participant>> getParticipants();
  Future<Participant?> getParticipantById({required String id});
  Future<void> addParticipant({required Participant participant});
  Future<void> updateParticipant({required Participant participant});
  Future<void> deleteParticipant({required String id});
  Future<void> banParticipant({required String id});
  Future<void> unbanParticipant({required String id});
  Stream<List<Participant>> getParticipantsStream();
}
