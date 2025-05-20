import 'package:race_tracker_app/model/participant.dart';

class CsvExporter {
  static String exportParticipantsToCsv(List<Participant> participants) {
    // CSV header
    final headers = [
      'id',
      'bib',
      'name',
      'age',
      'gender',
      'nation',
      'email',
      'phone',
      'createdAt',
      'isBanned',
      'status',
    ];
    final buffer = StringBuffer();
    buffer.writeln(headers.join(','));

    for (final p in participants) {
      buffer.writeln([
        p.id,
        p.bib,
        p.name,
        p.age,
        p.gender?.name ?? '',
        p.nation.name,
        p.email ?? '',
        p.phone,
        p.createdAt.toIso8601String(),
        p.isBanned,
        p.status,
      ].map((e) => '"$e"').join(','));
    }
    return buffer.toString();
  }

  static String exportRankedParticipantsToCsv(List<Participant> participants) {
    // CSV header
    final headers = [
      'id',
      'bib',
      'name',
      'age',
      'gender',
      'nation',
      'email',
      'phone',
      'createdAt',
      'isBanned',
      'status',
      'Rank'
      'Swimming Time',
      'Cycling Time',
      'Running Time',
    ];
    final buffer = StringBuffer();
    buffer.writeln(headers.join(','));

    for (int i = 0; i < participants.length; i++) {
       buffer.writeln([
        participants[i].id,
        participants[i].bib,
        participants[i].name,
        participants[i].age,
        participants[i].gender?.name ?? '',
        participants[i].nation.name,
        participants[i].email ?? '',
        participants[i].phone,
        participants[i].createdAt.toIso8601String(),
        participants[i].isBanned,
        participants[i].status,
        i + 1,
        participants[i].swimmingSegment?.durationForDisplay,
        participants[i].cyclingSegment?.durationForDisplay,
        participants[i].runningSegment?.durationForDisplay,
      ].map((e) => '"$e"').join(','));
      // i is the index (starting from 0)
    }
    
    // for (final p in participants) {
      // buffer.writeln([
      //   p.id,
      //   p.bib,
      //   p.name,
      //   p.age,
      //   p.gender?.name ?? '',
      //   p.nation.name,
      //   p.email ?? '',
      //   p.phone,
      //   p.createdAt.toIso8601String(),
      //   p.isBanned,
      //   p.status,

      // ].map((e) => '"$e"').join(','));
    // }
    return buffer.toString();
  }
}
