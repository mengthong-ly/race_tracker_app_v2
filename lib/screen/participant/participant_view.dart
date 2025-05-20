import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker_app/core/view_model_provider.dart';
import 'package:race_tracker_app/model/enum.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/provider/participant_provider.dart';
import 'package:race_tracker_app/provider/race_provider.dart';
import 'package:race_tracker_app/screen/participant/participant_tile.dart';
import 'package:race_tracker_app/screen/participant/participant_view_model.dart';
import 'package:race_tracker_app/screen/participant_detail/participant_detail_view.dart';
import 'package:race_tracker_app/theme/r_color.dart';
import 'package:race_tracker_app/theme/r_text.dart';
import 'package:race_tracker_app/theme/t_constant.dart';

part 'participant_adaptive.dart';

class ParticipantView extends StatelessWidget {
  const ParticipantView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ParticipantViewModel>(
      create: (context) => ParticipantViewModel(
        participantProvider: context.read<ParticipantProvider>(),
        raceProvider: context.read<RaceProvider>(),
      ),
      builder: (context, viewModel, child) {
        return  _ParticipantAdaptive(
          participantViewModel: viewModel,
        );
      },
    );
  }
}
