import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:test_flutter/src/provider/gaze_tracker_provider.dart';

class UserExtandProvider extends GetxController {
  bool isExtand = false;
  String timeString = "00:00";
  Stopwatch stopwatch = Stopwatch();
  Timer? timer;
  int counterAdd = 0;

  Timer? timerr;
  final int timerMaxSeconds = 60;
  int currentSeconds = 0;

//   void isInside(
//       int circlex, int circley, int rad, int x, int y, BuildContext context) {
//     if ((x - circlex) * (x - circlex) + (y - circley) * (y - circley) <=
//         rad * rad) {
//       start();
//       if ((stopwatch.elapsed.inSeconds % 60) % 5 == 0) {
//         print('DONE');
//         final provider = Get.find<GazeTrackerProvider>();
//         // provider.isBlink ||
//         if (provider.isDrowsiness) {
//           counterAdd += 1;
//         }
//       }
//     } else {
//       stop();
//     }
//   }

  void isInside() {
    final provider = Get.find<GazeTrackerProvider>();
    if (provider.isDrowsiness || provider.isBlink) {
      counterAdd += 1;
    }
  }

  void start() {
    stopwatch.start();
    timer = Timer.periodic(const Duration(seconds: 1), updater);
  }

  void updater(Timer t) {
    if (stopwatch.isRunning) {
      timeString =
          (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
              ":" +
              (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    }
  }

  void stop() {
    timer?.cancel();
    stopwatch.stop();
  }

  void reset() {
    timer?.cancel();
    stopwatch.reset();
    timeString = "00:00";
    counterAdd = 0;
    stopwatch.stop();
  }

  void _stateUpdate() {
    update();
  }
}
// ((stopwatch.elapsed.inSeconds % 60) % 4 == 0) ||
//           (stopwatch.elapsed.inSeconds % 60) % 5 == 0 ||