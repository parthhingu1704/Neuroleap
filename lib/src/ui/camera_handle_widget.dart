import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter/src/provider/gaze_tracker_provider.dart';

class CameraHandleWidget extends StatelessWidget {
  const CameraHandleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GazeTrackerProvider>(builder: (controller) {
      return Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'We must have cmaera permission!',
              style: TextStyle(
                  color: Colors.white24,
                  fontSize: 10,
                  decoration: TextDecoration.none),
            ),
          ),
          Container(
            width: double.maxFinite,
            color: Colors.white12,
            child: TextButton(
                onPressed: () {
                  controller.handleCamera();
                },
                child: const Text(
                  'Click here to request cmaera authorization',
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      );
    });
  }
}
