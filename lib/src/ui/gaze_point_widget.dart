import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter/src/provider/gaze_tracker_provider.dart';
// ignore: depend_on_referenced_packages

class GazePointWidget extends StatelessWidget {
  static const circleSize = 40.0;

  const GazePointWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final consumer = Provider.of<GazeTrackerProvider>(context);
    // final startFocusProvide = Provider.of<StartFocusProvider>(context);
    //
    return GetBuilder<GazeTrackerProvider>(
        // create:(context) =>  GazeTrackerProvider(),

        builder: (controller) {
      // final data =context.read<GazeTrackerProvider>().;
      // data.onsetEyesDXDY(consumer.pointX - circleSize / 2.0, consumer.pointY - circleSize / 2.0);

      return Positioned(
        left: controller.pointX - circleSize / 2.0,
        top: controller.pointY - circleSize / 2.0,
        child: Container(
          width: circleSize,
          height: circleSize,
          decoration:
              const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        ),
      );
    });
  }
}
