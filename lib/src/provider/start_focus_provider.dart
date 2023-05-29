import 'dart:async';

import 'package:flutter/widgets.dart';

class StartFocusProvider extends ChangeNotifier {
  double x = 0.0;
  double y = 0.0;
  double edx = 0.0;
  double edy = 0.0;
  int currentSeconds = 0;

  void onsetdxdyBoxCordinate(double xdata, double yData) {
    x = xdata;
    y = yData;
    notifyListeners();
    print(x);
    print(y);
  }

  void onsetEyesDXDY(double dx, double dy) {
    edx = dx;
    edy = dy;
    print('edx$edx');
    print('edy$edy');
  }

  void getStartingTimer(BuildContext context) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (x == edx && y == edy) {
        currentSeconds = timer.tick;
        notifyListeners();
      } else {
        timer.cancel();
        currentSeconds = 0;
      }
    });
    notifyListeners();
  }
}
