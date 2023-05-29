import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_flutter/src/provider/gaze_tracker_provider.dart';

import 'package:test_flutter/src/model/app_stage.dart';
import 'package:test_flutter/src/provider/start_focus_provider.dart';
import 'package:test_flutter/src/provider/user_extand_provider.dart';
import 'package:test_flutter/src/ui/calibration_widget.dart';

import 'package:test_flutter/src/ui/camera_handle_widget.dart';
import 'package:test_flutter/src/ui/gaze_point_widget.dart';
import 'package:test_flutter/src/ui/initialized_fail_dialog_widget.dart';
import 'package:test_flutter/src/ui/initializing_widget.dart';
import 'package:test_flutter/src/ui/loading_circle_widget.dart';
import 'package:test_flutter/src/ui/title_widget.dart';
import 'package:test_flutter/src/ui/initialized_widget.dart';
import 'package:test_flutter/src/ui/tracking_mode_widget.dart';

void main() {
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (BuildContext context) => GazeTrackerProvider(),),
      ChangeNotifierProvider(
          create: (BuildContext context) => UserExtandProvider(),),
           ChangeNotifierProvider(
          create: (BuildContext context) => StartFocusProvider(),)
    ], child: const AppView(),),);
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);
  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    final consumer = Provider.of<GazeTrackerProvider>(context);
    return Consumer<GazeTrackerProvider>(
        builder: (context, gazetracker, child) {
      return Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const TitleWidget(),
                  Consumer<GazeTrackerProvider>(
                    builder: (context, gazetracker, child) {
                      switch (gazetracker.state) {
                        case GazeTrackerState.first:
                          return const CameraHandleWidget();
                        case GazeTrackerState.idle:
                          return const InitializingWidget();
                        case GazeTrackerState.initialized:
                          return const InitializedWidget();
                        case GazeTrackerState.start:
                        case GazeTrackerState.calibrating:
                          return const TrackingModeWidget();
                        default:
                          return const InitializingWidget();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          if (consumer.state == GazeTrackerState.start) const GazePointWidget(),
          if (consumer.state == GazeTrackerState.initializing)
            const LoadingCircleWidget(),
          if (consumer.state == GazeTrackerState.calibrating)
            const CalibrationWidget(),
          if (consumer.failedReason != null) const InitializedFailDialog()
        ],
      );
    },);
  }
}
