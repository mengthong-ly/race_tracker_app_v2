import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/web.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/repository/participant_repository.dart';

class FirestoreParticipantRepository extends ParticipantRepository {
  final _collection = FirebaseFirestore.instance.collection('participants');

  @override
  void refreshData() {
    // Not needed for Firestore, as we use streams.
  }

  @override
  Future<List<Participant>> getParticipants() async {
    final snapshot = await _collection.get();
    return snapshot.docs.map((doc) => Participant.fromFirestore(doc)).toList();
  }

  @override
  Stream<List<Participant>> getParticipantsStream() {
    return _collection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Participant.fromFirestore(doc)).toList());
  }

  @override
  Future<Participant?> getParticipantById({required String id}) async {
    final doc = await _collection.doc(id).get();
    if (doc.exists) {
      return Participant.fromFirestore(doc);
    }
    return null;
  }

  @override
  Future<void> addParticipant({required Participant participant}) async {
    await _collection.doc(participant.id).set(participant.toJson());
  }

  @override
  Future<void> updateParticipant({required Participant participant}) async {
    try {
      await _collection.doc(participant.id).update(participant.toJson());
    } catch (e) {
      Logger().d(participant.toJson());
      Logger().d(e);
    }
  }

  @override
  Future<void> deleteParticipant({required String id}) async {
    await _collection.doc(id).delete();
  }

  @override
  Future<void> banParticipant({required String id}) async {
    await _collection.doc(id).update({'isBanned': true});
  }

  @override
  Future<void> unbanParticipant({required String id}) async {
    await _collection.doc(id).update({'isBanned': false});
  }
}
