import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_flutter/src/provider/gaze_tracker_provider.dart';

class InitializedFailDialog extends StatelessWidget {
  const InitializedFailDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final consumer = Get.find<GazeTrackerProvider>();
    return CupertinoAlertDialog(
      title: const Text('Failed'),
      content: Text(
          consumer.failedReason != null ? consumer.failedReason! : "unknown"),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          /// This parameter indicates this action is the default,
          /// and turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: () {
            consumer.chageIdleState();
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
