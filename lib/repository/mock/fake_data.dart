import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/model/enum.dart';

class FakeData {
  static List<Participant> fakeParticipants = List.generate(69, (index) {
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
