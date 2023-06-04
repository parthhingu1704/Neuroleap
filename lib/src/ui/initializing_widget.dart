import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter/src/provider/gaze_tracker_provider.dart';


class InitializingWidget extends StatelessWidget {
  const InitializingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final consumer = Provider.of<GazeTrackerProvider>(context);
    return GetBuilder<GazeTrackerProvider>(
        builder: (controller) {
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
                  controller.initGazeTracker();
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
