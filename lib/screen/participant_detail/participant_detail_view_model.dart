import 'package:race_tracker_app/core/base_view_model.dart';
import 'package:race_tracker_app/model/participant.dart';

class ParticipantDetailViewModel extends BaseViewModel {
  final Participant? participant;
  final bool isEdit;
  
  ParticipantDetailViewModel({
    this.participant,
    this.isEdit = false,
  });


  

}
