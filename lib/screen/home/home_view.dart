import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker_app/core/view_model_provider.dart';
import 'package:race_tracker_app/model/participant.dart';
import 'package:race_tracker_app/provider/participant_provider.dart';
import 'package:race_tracker_app/provider/race_provider.dart';
import 'package:race_tracker_app/screen/home/home_view_model.dart';
import 'package:race_tracker_app/screen/participant/participant_view.dart';
import 'package:race_tracker_app/screen/participant/participant_view_model.dart';
import 'package:race_tracker_app/screen/race/race_view.dart';
import 'package:race_tracker_app/theme/r_color.dart';
import 'package:race_tracker_app/theme/r_text.dart';
import 'package:race_tracker_app/theme/t_constant.dart';

part 'home_adaptive.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>(
      create: (context) => HomeViewModel(),
      builder: (context, viewModel, child) => const _HomeAdaptive(),
    );
  }
}
