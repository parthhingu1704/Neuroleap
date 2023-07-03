import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_flutter/src/model/app_stage.dart';
import 'package:test_flutter/src/model/gazetracker_method_string.dart';

class GazeTrackerProvider extends GetxController {
  dynamic state;
  // dev_t7cgx69k5dukohxx6scw332y1f5tmqqzqib5jj50
  static const licenseKey =
      'dev_t7cgx69k5dukohxx6scw332y1f5tmqqzqib5jj50'; // Please enter the key value for development issued by the SeeSo.io
  final _channel = const MethodChannel('samples.flutter.dev/tracker');
  String? failedReason;
  // gaze X,Y
  var pointX = 0.0;
  var pointY = 0.0;
  int showTestTestButton = 0;
  // calibration
  double progress = 0.0;
  var caliX = 0.0;
  var caliY = 0.0;
  bool hasCaliData = false;
  double attention = 0.0;
  bool isUserOption = false;
//   bool isUserOption = false;

  int calibrationType = 5;
  bool isDrowsiness = false;
  bool isBlink = false;
  bool savedCalibrationData = false;
  GazeTrackerProvider() {
    state = GazeTrackerState.first;
    setMessageHandler();
    checkCamera();
  }

  void setMessageHandler() {
    _channel.setMethodCallHandler((call) async {
      //   debugPrint("setMessageHandler : ${call.method}");
      if (call.method == "onGaze") {
        final xy = call.arguments;
        _onGaze(xy[0] as double, xy[1] as double);
      } else if (call.method == "getInitializedResult") {
        debugPrint("argument : ${call.arguments}");
        _getInitializedResult(call.arguments);
      } else if (call.method == "onStatus") {
        _onTrackingStatus(call.arguments);
        debugPrint('onStatus');
      } else if (call.method == "onCalibrationNext") {
        _onCalibrationNext(call.arguments);
        debugPrint('onCalibrationNext');
      } else if (call.method == "onCalibrationProgress") {
        _onCalibrationProgress(call.arguments);
        debugPrint('onCalibrationProgress');
      } else if (call.method == "onCalibrationFinished") {
        _onCalibrationFinished();
        debugPrint('onCalibrationFinished');
      } else if (call.method == "onDrowsiness") {
        _onDrowsiness(call.arguments);
      } else if (call.method == "onAttention") {
        _onAttentions(call.arguments);
        debugPrint('onAttention');
      } else if (call.method == "onBlink") {
        _onBlink(call.arguments);
        debugPrint('onBlink');
      }
    });
  }

  void changeUserStatusOption(bool isOption) {
    isUserOption = isOption;
    _stateUpdate();
  }

  void changeCalibrationType(int cType) {
    calibrationType = cType;
    _stateUpdate();
  }

  void _onAttentions(dynamic result) {
    if (state != GazeTrackerState.calibrating) {
      attention = result[0];
      _stateUpdate();
    }
  }

  void _onDrowsiness(dynamic result) {
    if (state != GazeTrackerState.calibrating) {
      isDrowsiness = result[0];
      debugPrint(isDrowsiness.toString());
      _stateUpdate();
    }
  }

  void _onBlink(dynamic reuslt) {
    if (state != GazeTrackerState.calibrating) {
      isBlink = reuslt[0];
      debugPrint(isBlink.toString());
      _stateUpdate();
    }
  }

  void _onTrackingStatus(dynamic result) {
    if (result == null) {
      _setTrackerState(GazeTrackerState.start);
    } else {
      _setTrackerState(GazeTrackerState.initialized);
    }
  }

  void _onCalibrationNext(dynamic result) {
    if (state != GazeTrackerState.calibrating) {
      _setTrackerState(GazeTrackerState.calibrating);
    }
    caliX = result[0];
    caliY = result[1];
    _channel.invokeMethod(MethodString.startCollectSamples.convertedText);
    _stateUpdate();

  }

  void _onCalibrationProgress(dynamic result) {
    progress = result[0];
    _stateUpdate();
    print(progress);
  }

  void _onCalibrationFinished() {
    hasCaliData = true;
    _setTrackerState(GazeTrackerState.start);
    _stateUpdate();
  }

  void _onGaze(double x, double y) {
    debugPrint("gaze x : $x, y: $y");
    pointX = x;
    pointY = y;
    _stateUpdate();
  }

  void _getInitializedResult(dynamic result) {
    debugPrint("_getInitializedResult result = ${result[0]}");
    if (result[0] == 1) {
      _setTrackerState(GazeTrackerState.initialized);
    } else {
      failedReason = "Init Failed error code ${result[1]}";
      _stateUpdate();
    }
  }

  Future<void> checkCamera() async {
    final isGrated = await Permission.camera.isGranted;
    if (isGrated) {
      _setTrackerState(GazeTrackerState.idle);
    }
  }

  Future<void> handleCamera() async {
    final status = await Permission.camera.request();
    debugPrint(status.isGranted.toString());
    if (status.isGranted) {
      _setTrackerState(GazeTrackerState.idle);
    }
  }

  Future<void> initGazeTracker() async {
    failedReason = null;
    _setTrackerState(GazeTrackerState.initializing);
    final String result = await _channel.invokeMethod(
        MethodString.initGazeTracker.convertedText, {
      'license': licenseKey,
      'useStatusOption': isUserOption ? "true" : "false"
    });
    debugPrint('result : $result');
    changeUserStatusOption(true);
    _stateUpdate();
  }

  void deinitGazeTracker() {
    _channel.invokeMethod(MethodString.deinitGazeTracker.convertedText, {});
    _setTrackerState(GazeTrackerState.idle);
  }

  void startTracking() {
    _channel.invokeMethod(MethodString.startTracking.convertedText);

    _stateUpdate();
  }

  void stopTracking() {
    _channel.invokeMethod(MethodString.stopTracking.convertedText);
    showTestTestButton = 0;

    _stateUpdate();
  }

  void _setTrackerState(GazeTrackerState state) {
    this.state = state;
    _stateUpdate();
  }

  void startCalibration() {
    _channel.invokeMethod(
        MethodString.startCalibration.convertedText, calibrationType);
        _stateUpdate();
    
  }

  void saveCalibrationData() {
    hasCaliData = false;
    savedCalibrationData = true;
    _channel.invokeMethod(MethodString.saveCalibrationData.convertedText);
    _stateUpdate();
  }

  void chageIdleState() {
    failedReason = null;
    _setTrackerState(GazeTrackerState.idle);
  }

  void _stateUpdate() {
    update();
  }
}
