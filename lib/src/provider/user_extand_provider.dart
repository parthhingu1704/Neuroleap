import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/src/provider/gaze_tracker_provider.dart';

class UserExtandProvider with ChangeNotifier {
  bool isExtand = false;
  String timeString = "00:00";
  Stopwatch stopwatch = Stopwatch();
  Timer? timer;
  int counterAdd = 0;

  void changeIsExtand() {
    isExtand = !isExtand;
    notifyListeners();
  }

  Timer? timerr;
  final int timerMaxSeconds = 60;
  int currentSeconds = 0;
//   startTimeout() {
//     timerr = Timer.periodic(const Duration(seconds: 1), (timer) {
//       //   currentSeconds = timer.tick;
//       //   if (timer.tick >= timerMaxSeconds) timer.cancel();
//       notifyListeners();
//     });
//   }

//   timerCancle() {
//     currentSeconds = 0;
//     timerr?.cancel();
//     notifyListeners();
//   }

  void isInside(
      int circlex, int circley, int rad, int x, int y, BuildContext context) {
    if ((x - circlex) * (x - circlex) + (y - circley) * (y - circley) <=
        rad * rad) {
      start();
      if (((stopwatch.elapsed.inSeconds % 60) % 4 == 0) ||
          (stopwatch.elapsed.inSeconds % 60) % 5 == 0 ||
          (stopwatch.elapsed.inSeconds % 60) % 6 == 0) {
        print('DONE');
        final provider = Provider.of<GazeTrackerProvider>(context);
        if (provider.isBlink || provider.isDrowsiness) {
          counterAdd += 1;
        }
      }
    } else {
      stop();
    }
  }

  void start() {
    stopwatch.start();
    timer = Timer.periodic(const Duration(seconds: 1), update);
  }

  void update(Timer t) {
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
    stopwatch.stop();
  }
}
