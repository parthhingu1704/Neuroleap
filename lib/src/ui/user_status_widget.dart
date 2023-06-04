import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter/src/provider/gaze_tracker_provider.dart';
import 'package:test_flutter/src/provider/user_extand_provider.dart';
import 'package:test_flutter/src/ui/gaze_point_widget.dart';

class UserSatatusWidget extends StatefulWidget {
  const UserSatatusWidget({Key? key}) : super(key: key);

  @override
  State<UserSatatusWidget> createState() => _UserSatatusWidgetState();
}

class _UserSatatusWidgetState extends State<UserSatatusWidget> {
  GlobalKey key = GlobalKey();
  double x = 0.0;
  double y = 0.0;
  @override
  void initState() {
    Get.find<UserExtandProvider>().reset();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GazeTrackerProvider>(
        // create: (context) => GazeTrackerProvider(),
        builder: (controller) {
      final consumerdata = controller.pointX;
      final consumerdatay = controller.pointY;
      return GetBuilder<UserExtandProvider>(builder: (userController) {
        return Stack(
          children: [
            Scaffold(
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
                      child: const Icon(Icons.keyboard_arrow_left_outlined,
                          color: Colors.white, size: 30),
                    ),
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          'Blink Test Case',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 24.0, right: 24, bottom: 8, top: 16),
                      child: Center(
                        child: Text(
                          "Please keep your eye into Circle and Blink every 5 second. ",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: Center(
                        key: key,
                        child: Builder(builder: (context) {
                          RenderBox box = key.currentContext?.findRenderObject()
                              as RenderBox;
                          Offset position = box.localToGlobal(Offset.zero);
                          y = position.dy;
                          x = position.dx;

                          userController.isInside(
                              (x.toInt() + 400 / 2).toInt(),
                              (y.toInt() + 400 / 2).toInt(),
                              200,
                              consumerdata.toInt(),
                              consumerdatay.toInt(),
                              context);
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

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          userController.timeString,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'Count :- ${userController.counterAdd}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    //   Container(
                    //     height: 1,
                    //     color: Colors.white24,
                    //   ),
                    //   Center(
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(top: 8.0),
                    //       child: Material(
                    //         borderRadius: BorderRadius.circular(4.0),
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Text(
                    //             // extandConsumer.currentSeconds.toString(),
                    //             '0',
                    //             style: const TextStyle(fontSize: 20),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    //   Center(
                    //     child: TextButton(
                    //       onPressed: () {
                    //         // extandConsumer.startTimeout();
                    //       },
                    //       child: const Text(
                    //         'START',
                    //         style: TextStyle(fontSize: 20),
                    //       ),
                    //     ),
                    //   ),
                    //   Center(
                    //     child: TextButton(
                    //       onPressed: () {
                    //         // extandConsumer.timerCancle();
                    //       },
                    //       child: const Text(
                    //         'STOP',
                    //         style: TextStyle(fontSize: 20),
                    //       ),
                    //     ),
                    //   ),
                    //   //   if (extandConsumer.isExtand)
                    //   const UserStatusExtendWidget()
                  ]),
            ),
            const GazePointWidget(),
          ],
        );
      });
    });
  }
}

// class UserStatusExtendWidget extends StatelessWidget {
//   const UserStatusExtendWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final consumer = Provider.of<GazeTrackerProvider>(context);
//     print(consumer.isBlink ? "Ȍ _ Ő" : "Ȕ _ Ű");
//     print(consumer.isDrowsiness ? "Yes.." : "NOPE !");

//     return Column(
//       children: [
//         // Container(
//         //     width: double.maxFinite,
//         //     height: 48,
//         //     color: Colors.white12,
//         //     child: Row(
//         //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         //       children: [
//         //         const Text(
//         //           "User Options Info",
//         //           style: style,
//         //         ),
//         //         Text(
//         //           "${(consumer.attention * 100).toInt()}%",
//         //           style: style,
//         //         )
//         //       ],
//         // )),
//         Container(
//           height: 1,
//           color: Colors.white24,
//         ),
//         // Container(
//         //   width: double.maxFinite,
//         //   height: 48,
//         //   color: Colors.white12,
//         //   child: Row(
//         //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         //     children: [
//         //       const Text(
//         //         "Blink State",
//         //         style: style,
//         //       ),
//         //       Text(
//         //         consumer.isBlink ? "Ȍ _ Ő" : "Ȕ _ Ű",
//         //         style: style,
//         //       )
//         //     ],
//         //   ),
//         // ),
//         Container(
//           height: 1,
//           color: Colors.white24,
//         ),
//         Container(
//           width: double.maxFinite,
//           height: 48,
//           color: Colors.white12,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               const Text(
//                 "Every 5 second bink your EYE ",
//               ),
//               Text(
//                 consumer.isDrowsiness ? "SuccesFully" : "Failed",
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
