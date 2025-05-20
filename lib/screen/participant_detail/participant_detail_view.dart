import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:race_tracker_app/core/view_model_provider.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/screen/form/participant_form.dart';
import 'package:race_tracker_app/screen/participant_detail/participant_detail_view_model.dart';
part 'participant_detail_adaptive.dart';

class ParticipantDetailView extends StatelessWidget {
  final Participant? participant;
  final bool isEdit;

  const ParticipantDetailView(
      {super.key, this.participant, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      create: (context) => ParticipantDetailViewModel(
        participant: participant,
        isEdit: isEdit,
      ),
      builder: (context, viewModel, child) => _ParticipantDetailAdaptive(
        viewModel: viewModel,
      ),
    );
  }
}
