import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:race_tracker_app/app.dart';
import 'package:race_tracker_app/provider/participant_provider.dart';
import 'package:race_tracker_app/provider/race_provider.dart';
import 'package:race_tracker_app/provider/record_segment_provider.dart';
import 'package:race_tracker_app/provider/segment_provider.dart';
import 'package:race_tracker_app/service/participant_service.dart';
import 'package:race_tracker_app/service/race_service.dart';
import 'package:race_tracker_app/theme/t_theme.dart';
import 'initializer.dart' deferred as initializer show Initializer;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializer.loadLibrary();
  await initializer.Initializer.load();
  runApp(const RaceTrackingApp());
}

class RaceTrackingApp extends StatelessWidget {
  const RaceTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SegmentProvider()),
        ChangeNotifierProvider(create: (_) => RecordSegmentProvider()),
        ChangeNotifierProvider(
          create: (_) => ParticipantProvider(
              participantService: ParticipantService.instance),
        ),
        ChangeNotifierProvider(
            create: (_) => RaceProvider(
                participantService: ParticipantService.instance,
                raceService: RaceService.instance)),
      ],
      child: MaterialApp(
        theme: TTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const App(),
      ),
    );
  }
}
