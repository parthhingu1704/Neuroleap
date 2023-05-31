import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/src/provider/gaze_tracker_provider.dart';
import 'package:test_flutter/src/provider/user_extand_provider.dart';
import 'package:test_flutter/src/ui/gaze_point_widget.dart';

class UserSatatusWidget extends StatelessWidget {
  const UserSatatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final extandConsumer = Provider.of<UserExtandProvider>(context);
    const style = TextStyle(
        color: Colors.white,
        decoration: TextDecoration.none,
        fontSize: 14,
        fontWeight: FontWeight.normal);
    return ChangeNotifierProvider<GazeTrackerProvider>(
      create: (context) => GazeTrackerProvider(),
      builder: (context,child) {
        return Stack(
          children: [
            Provider<UserExtandProvider>(
              create: (context) => UserExtandProvider(),
              builder: (context,child) {
                return Scaffold(
backgroundColor: Colors.black,
                  body: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    
                    SizedBox(height:MediaQuery.of(context).padding.top+8 ,),
                               TextButton(onPressed: () {
                                 Navigator.pop(context);
                               }, child: const Icon(Icons.keyboard_arrow_left_outlined,color: Colors.white,size: 30),),
                             const   Center(
                                  child: Padding(
                                    padding:  EdgeInsets.only(top:4.0),
                                    child: Text('Blink Test Case',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),textAlign:TextAlign.center,),
                                  ),
                                ),
                                const SizedBox(height: 24,),
                    Container(
                      height: 1,
                      color: Colors.white24,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              // extandConsumer.currentSeconds.toString(),
                              '0',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          
                          // extandConsumer.startTimeout();
                        },
                        child: const Text(
                          'START',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // extandConsumer.timerCancle();
                        },
                        child: const Text(
                          'STOP',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    //   if (extandConsumer.isExtand)
                    const UserStatusExtendWidget()
                  ]),
                );
              }
            ),
            const  GazePointWidget(),
          ],
        );
      }
    );
  }
}

class UserStatusExtendWidget extends StatelessWidget {
  const UserStatusExtendWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final consumer = Provider.of<GazeTrackerProvider>(context);
    print(consumer.isBlink ? "Ȍ _ Ő" : "Ȕ _ Ű");
    print(consumer.isDrowsiness ? "Yes.." : "NOPE !");
    const style = TextStyle(
        color: Colors.white,
        decoration: TextDecoration.none,
        fontSize: 14,
        fontWeight: FontWeight.normal);
    return Column(
      children: [
        // Container(
        //     width: double.maxFinite,
        //     height: 48,
        //     color: Colors.white12,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         const Text(
        //           "User Options Info",
        //           style: style,
        //         ),
        //         Text(
        //           "${(consumer.attention * 100).toInt()}%",
        //           style: style,
        //         )
        //       ],
        // )),
        Container(
          height: 1,
          color: Colors.white24,
        ),
        // Container(
        //   width: double.maxFinite,
        //   height: 48,
        //   color: Colors.white12,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       const Text(
        //         "Blink State",
        //         style: style,
        //       ),
        //       Text(
        //         consumer.isBlink ? "Ȍ _ Ő" : "Ȕ _ Ű",
        //         style: style,
        //       )
        //     ],
        //   ),
        // ),
        Container(
          height: 1,
          color: Colors.white24,
        ),
        Container(
          width: double.maxFinite,
          height: 48,
          color: Colors.white12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Every 5 second bink your EYE :-",
                style: style,
              ),
              Text(
                consumer.isDrowsiness ? "SuccesFully" : "Failed",
                style: style,
              )
            ],
          ),
        )
      ],
    );
  }
}
