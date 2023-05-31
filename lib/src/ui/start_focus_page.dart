import 'dart:async';
import 'dart:math';

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
  int currentSeconds = 0;
  @override
  void initState() {
    _getCircledxdy();
    super.initState();
  }

  void _getCircledxdy() async {
    // await Future.delayed(const Duration(seconds: 5)).then((value) {
    //   RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
    //   Offset position = box.localToGlobal(Offset.zero);
    //   y = position.dy;
    //   x = position.dx;
    //   print(x);
    //   print(y);
      // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   Provider.of<StartFocusProvider>(context, listen: false)
      //       .onsetdxdyBoxCordinate(x - 80 / 2, y - 80 / 2);

      //   Provider.of<StartFocusProvider>(context, listen: false)
      //       .getStartingTimer(context);
      // });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // final extandConsumer = context.read<StartFocusProvider>().currentSeconds;
    // Provider.of<StartFocusProvider>(context,listen: false);

    // const style = TextStyle(
    //     color: Colors.white,
    //     decoration: TextDecoration.none,
    //     fontSize: 14,
    //     fontWeight: FontWeight.normal);
    return  
    
    ChangeNotifierProvider<GazeTrackerProvider>(
      create: (context) => GazeTrackerProvider(),
      builder: (context,child) {
        // print(context.read<GazeTrackerProvider>().pointX);
        //         print(isPointInside(Offset(96.36363636363637, 161.8181818181818), 100));

        return Stack(
          children: [
            Provider<StartFocusProvider>(
              create: (context) => StartFocusProvider(),
              builder: (context,child) {
                return Scaffold(
                  backgroundColor: Colors.black,
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     SizedBox(height:MediaQuery.of(context).padding.top+8 ,),
                     TextButton(onPressed: () {
                       Navigator.pop(context);
                     }, child: const Icon(Icons.keyboard_arrow_left_outlined,color: Colors.white,size: 30),),
                   const   Center(
                        child: Padding(
                          padding:  EdgeInsets.only(top:4.0),
                          child: Text('Start Focus Test Case',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),textAlign:TextAlign.center,),
                        ),
                      ),
                      const SizedBox(height: 24,),
                      Center(
                        // key: key,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Container(
                            key: key,
                            height: 200,
                            width: 200,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                     
                    ],
                  ),
                );
              }
            ),
          const  GazePointWidget(),
          ],
        );
      }
    );
  }
  bool isPointInside(Offset point, double radius) =>
  pow(point.dx, 2) + pow(point.dy, 2) < pow(radius, 2);
}
