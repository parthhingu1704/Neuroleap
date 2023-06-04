import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/src/provider/gaze_tracker_provider.dart';
import 'package:test_flutter/src/provider/start_focus_provider.dart';
import 'package:test_flutter/src/ui/gaze_point_widget.dart';

class StartFocusTestCase extends StatefulWidget {
  const StartFocusTestCase({Key? key}) : super(key: key);

  @override
  State<StartFocusTestCase> createState() => _StartFocusTestCaseState();
}

class _StartFocusTestCaseState extends State<StartFocusTestCase> {
  GlobalKey key = GlobalKey();
  double x = 0.0;
  double y = 0.0;
  @override
  void initState() {
    context.read<StartFocusProvider>().reset();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GazeTrackerProvider>(
        create: (context) => GazeTrackerProvider(),
        builder: (context, child) {
          final consumerdata = context.watch<GazeTrackerProvider>().pointX;
          final consumerdatay = context.watch<GazeTrackerProvider>().pointY;

          return Consumer<StartFocusProvider>(
              builder: (context, startFocusProvider, child) {
            return Stack(
              children: [
                Provider<StartFocusProvider>(
                    create: (context) => StartFocusProvider(),
                    builder: (context, child) {
                      return Scaffold(
                        backgroundColor: Colors.black,
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).padding.top + 8,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                  Icons.keyboard_arrow_left_outlined,
                                  color: Colors.white,
                                  size: 30),
                            ),
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 4.0),
                                child: Text(
                                  'Start Focus Test Case',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                key: key,
                                child: Builder(builder: (context) {
                                  RenderBox box = key.currentContext
                                      ?.findRenderObject() as RenderBox;
                                  Offset position =
                                      box.localToGlobal(Offset.zero);
                                  y = position.dy;
                                  x = position.dx;

                                  startFocusProvider.isInside(
                                      (x.toInt() + 400 / 2).toInt(),
                                      (y.toInt() + 400 / 2).toInt(),
                                      200,
                                      consumerdata.toInt(),
                                      consumerdatay.toInt());
                                  return Container(
                                    height: 400,
                                    width: 400,
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                  );
                                }),
                              ),
                            ),
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    startFocusProvider.timeString,
                                    style: const TextStyle(
                                        fontSize: 24, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                const GazePointWidget(),
              ],
            );
          });
        });
  }
}
