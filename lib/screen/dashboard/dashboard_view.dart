
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker_app/core/view_model_provider.dart';
import 'package:race_tracker_app/model/enum.dart';
import 'package:race_tracker_app/model/race.dart';
import 'package:race_tracker_app/model/segment.dart';
import 'package:race_tracker_app/provider/race_provider.dart';
import 'package:race_tracker_app/screen/dashboard/dashboard_view_model.dart';
import 'package:race_tracker_app/screen/dashboard/participant_rank_data.dart';
import 'package:race_tracker_app/screen/dashboard/splits_table.dart';
import 'package:race_tracker_app/theme/r_color.dart';
import 'package:race_tracker_app/theme/r_text.dart';
import 'package:race_tracker_app/theme/t_constant.dart';

part 'dashboard_adaptive.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<DashboardViewModel>(create: (context) {
      return DashboardViewModel(
        raceProvider: context.read<RaceProvider>(),
      );
    }, builder: (context, viewModel, child) {
      return  _DashboardAdaptive(
        viewModel: viewModel,
      );
    });
  }
}
