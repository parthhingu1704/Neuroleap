import 'dart:async';

import 'package:flutter/widgets.dart';

class UserExtandProvider with ChangeNotifier {
  bool isExtand = false;

  void changeIsExtand() {
    isExtand = !isExtand;
    notifyListeners();
  }

  Timer? timerr;
  final int timerMaxSeconds = 60;
  int currentSeconds = 0;
  startTimeout() {
    timerr = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentSeconds = timer.tick;
      if (timer.tick >= timerMaxSeconds) timer.cancel();
      notifyListeners();
    });
  }

  timerCancle() {
    currentSeconds = 0;
    timerr?.cancel();
    notifyListeners();
  
  }
}
