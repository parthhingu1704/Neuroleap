import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:test_flutter/src/provider/gaze_tracker_provider.dart';

class GazePointWidget extends StatelessWidget {
  static const circleSize = 40.0;

  const GazePointWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final consumer = Provider.of<GazeTrackerProvider>(context);
    // final startFocusProvide = Provider.of<StartFocusProvider>(context);
    // 
    return Consumer<GazeTrackerProvider>(
      // create:(context) =>  GazeTrackerProvider(),

      builder: (context,consumer,child) {
        // final data =context.read<GazeTrackerProvider>().;
    // data.onsetEyesDXDY(consumer.pointX - circleSize / 2.0, consumer.pointY - circleSize / 2.0);

        return Positioned(
          left: consumer.pointX - circleSize / 2.0,
          top: consumer.pointY - circleSize / 2.0,
          child: Container(
            width: circleSize,
            height: circleSize,
            decoration:
                const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          ),
        );
      }
    );
  }
}
