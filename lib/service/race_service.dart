import 'package:race_tracker_app/repository/race_repository.dart';

class RaceService {
  RaceService._privateInstance({required this.repository});

  final RaceRepository repository;
  static RaceService? _instance;

  static Future<void> initializer(RaceRepository repository) async {
    if(_instance == null){
      _instance = RaceService._privateInstance(repository: repository);
    } else {
      throw Exception("RaceService is already initialized");
    }
  }

  static RaceService get instance {
    if (_instance == null) {
      throw Exception("RaceService is not initialized");
    }
    return _instance!;
  }

}
