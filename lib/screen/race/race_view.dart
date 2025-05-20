import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker_app/core/view_model_provider.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/model/race.dart';
import 'package:race_tracker_app/model/segment.dart';
import 'package:race_tracker_app/provider/race_provider.dart';
import 'package:race_tracker_app/screen/race/participant_selection_tile.dart';
import 'package:race_tracker_app/screen/race/race_timer_display.dart';
import 'package:race_tracker_app/screen/race/race_view_model.dart';
import 'package:race_tracker_app/theme/r_color.dart';
import 'package:race_tracker_app/theme/r_text.dart';
part 'race_adaptive.dart';

class RaceView extends StatelessWidget {
  const RaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<RaceViewModel>(
      create: (context) => RaceViewModel(context: context),
      builder: (context, viewModel, child) {
        return _RaceAdaptive(viewModel: viewModel);
      },
    );
  }
}
