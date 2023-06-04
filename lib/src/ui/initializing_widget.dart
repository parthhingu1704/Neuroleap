import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/src/provider/gaze_tracker_provider.dart';

class InitializingWidget extends StatelessWidget {
  const InitializingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final consumer = Provider.of<GazeTrackerProvider>(context);
    return Consumer<GazeTrackerProvider>(
        builder: (context, gazeTracker, child) {
      return Column(
        children: <Widget>[
          const Text('You need to init GazeTracker first',
              style: TextStyle(
                  color: Colors.white24,
                  fontSize: 10,
                  decoration: TextDecoration.none)),
          Container(
            height: 10,
          ),
          Container(
            width: double.maxFinite,
            color: Colors.white12,
            child: TextButton(
                onPressed: () {
                  gazeTracker.initGazeTracker();
                },
                child: const Text(
                  'Initialize   GazzeTracker',
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Container(
            width: double.maxFinite,
            height: 1,
            color: Colors.white24,
          ),
        ],
      );
    });
  }
}
