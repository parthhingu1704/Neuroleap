import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_flutter/src/provider/gaze_tracker_provider.dart';

import 'package:test_flutter/src/model/app_stage.dart';
import 'package:test_flutter/src/provider/start_focus_provider.dart';
import 'package:test_flutter/src/provider/user_extand_provider.dart';
import 'package:test_flutter/src/ui/calibration_widget.dart';

import 'package:test_flutter/src/ui/camera_handle_widget.dart';
import 'package:test_flutter/src/ui/drawer_page.dart';
import 'package:test_flutter/src/ui/gaze_point_widget.dart';
import 'package:test_flutter/src/ui/initialized_fail_dialog_widget.dart';
import 'package:test_flutter/src/ui/initializing_widget.dart';
import 'package:test_flutter/src/ui/loading_circle_widget.dart';
import 'package:test_flutter/src/ui/title_widget.dart';
import 'package:test_flutter/src/ui/initialized_widget.dart';
import 'package:test_flutter/src/ui/tracking_mode_widget.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<GazeTrackerProvider>(
      create: (BuildContext context) => GazeTrackerProvider(),
    ),
    ChangeNotifierProvider<UserExtandProvider>(
      create: (BuildContext context) => UserExtandProvider(),
    ),
    ChangeNotifierProvider<StartFocusProvider>(
      create: (BuildContext context) => StartFocusProvider(),
    )
  ], child: const SampleApp()));
}

class SampleApp extends StatelessWidget {
  const SampleApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AppView(),
    );
  }
}
// import 'dart:math';

// /// check if a [point] is in a circle of a given [radius]
// bool isPointInside(Offset point, double radius) =>
//   pow(point.dx, 2) + pow(point.dy, 2) < pow(radius, 2);
class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);
  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  GlobalKey<ScaffoldState> keyData = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // final consumer = Provider.of<GazeTrackerProvider>(context);
    return ChangeNotifierProvider<GazeTrackerProvider>(
      create: (context) => GazeTrackerProvider(),
      builder: (context, child) {
        final consumer = context.watch<GazeTrackerProvider>();
        return Scaffold(
          key: keyData,
          backgroundColor: Colors.black,
          drawer: const DrawerPage(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 8, left: 8),
                child: TextButton(
                    onPressed: () {
                      keyData.currentState!.openDrawer();
                    },
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    )),
              ),
              const TitleWidget(),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Builder(
                          builder: (
                            context,
                          ) {
                            switch (consumer.state) {
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
                    if (consumer.state == GazeTrackerState.start)
                      const GazePointWidget(),
                    if (consumer.state == GazeTrackerState.initializing)
                      const LoadingCircleWidget(),
                    if (consumer.state == GazeTrackerState.calibrating)
                      const CalibrationWidget(),
                    if (consumer.failedReason != null)
                      const InitializedFailDialog()
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
