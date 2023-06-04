import 'dart:async';
import 'package:flutter/widgets.dart';

class StartFocusProvider extends ChangeNotifier {
  String timeString = "00:00";
  Stopwatch stopwatch = Stopwatch();
  Timer? timer;

  void isInside(int circlex, int circley, int rad, int x, int y) {
    if ((x - circlex) * (x - circlex) + (y - circley) * (y - circley) <=
        rad * rad) {
      start();
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
