import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker_app/core/view_model_provider.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/provider/participant_provider.dart';
import 'package:race_tracker_app/provider/race_provider.dart';
import 'package:race_tracker_app/screen/participant_result/info_row.dart';
import 'package:race_tracker_app/screen/participant_result/info_text_row.dart';
import 'package:race_tracker_app/screen/participant_result/participant_result_view_model.dart';
import 'package:race_tracker_app/screen/participant_result/section_label.dart';
import 'package:race_tracker_app/screen/participant_result/segment_card.dart';
import 'package:race_tracker_app/theme/r_color.dart';
import 'package:race_tracker_app/theme/r_text.dart';
import 'package:race_tracker_app/theme/t_constant.dart';

part 'participant_result_adaptive.dart';

class ParticipantResultView extends StatelessWidget {
  const ParticipantResultView({super.key, required this.participant, required this.rank});
  final Participant participant;
  final int rank;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ParticipantResultViewModel>(create: (context) {
      return ParticipantResultViewModel(
        raceProvider: context.read<RaceProvider>(),
        participantProvider: context.read<ParticipantProvider>(),
        participant: participant,
        rank: rank,
      );
    }, builder: (context, viewModel, child) {
      return _ParticipantResultAdaptive(
        
        viewModel: viewModel,
      );
    });
  }
}
