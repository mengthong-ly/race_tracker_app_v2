import 'package:logger/web.dart';
import 'package:race_tracker_app/model/enum.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/repository/mock/fake_data.dart';
import 'package:race_tracker_app/repository/participant_repository.dart';

class MockParticipantRepoisitory extends ParticipantRepository {
  List<Participant> fakeParticipant =
      List<Participant>.from(FakeData.fakeParticipants);

  @override
  Future<List<Participant>> getParticipants() async {
    // Return the current in-memory list, not a new one
    return fakeParticipant;
  }

  @override
  void refreshData() {
    fakeParticipant = List.generate(69, (index) {
      return Participant(
        id: '$index',
        bib: (index + 1).toString().padLeft(3, '0'),
        age: (18 + (index % 30)),
        name: 'parti $index',
        email: 'participant$index@example.com',
        phone: '01234567${index.toString().padLeft(2, '0')}',
        createdAt: DateTime.now(),
        gender: index % 2 == 0 ? Gender.male : Gender.female,
        isBanned: index % 10 == 0,
        runningSegment: null,
        cyclingSegment: null,
        swimmingSegment: null,
      );
    });
  }

  @override
  Future<void> addParticipant({required Participant participant}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    fakeParticipant.add(participant);
  }

  @override
  Future<void> banParticipant({required String id}) async {
    int index = fakeParticipant.indexWhere((p) => p.id == id);
    if (index != -1) {
      fakeParticipant[index].isBanned = true;
    }
  }

  @override
  Future<void> deleteParticipant({required String id}) async {
    fakeParticipant.removeWhere((p) => p.id == id);
  }

  @override
  Future<Participant?> getParticipantById({required String id}) async {
    try {
      return fakeParticipant.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> unbanParticipant({required String id}) async {
    int index = fakeParticipant.indexWhere((p) => p.id == id);
    if (index != -1) {
      fakeParticipant[index].isBanned = false;
    }
  }

  @override
  Future<void> updateParticipant({required Participant participant}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    int index = fakeParticipant.indexWhere((p) => p.id == participant.id);
    if (index != -1) {
      fakeParticipant[index] = participant;
      Logger().d(fakeParticipant[index].name);
    }
  }

  @override
  Stream<List<Participant>> getParticipantsStream() {
    throw UnimplementedError();
  }
}
