import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/src/provider/gaze_tracker_provider.dart';
import 'package:test_flutter/src/provider/user_extand_provider.dart';

class UserSatatusWidget extends StatelessWidget {
  const UserSatatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final extandConsumer = Provider.of<UserExtandProvider>(context);
    const style = TextStyle(
        color: Colors.white,
        decoration: TextDecoration.none,
        fontSize: 14,
        fontWeight: FontWeight.normal);
    return Column(children: [
      Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: double.maxFinite,
          color: Colors.white12,
          child:const Padding(
            padding:  EdgeInsets.only(top:8.0,bottom: 8),
            child:  Text('Blink State Use Case', style: style,textAlign: TextAlign.center),
          )
        ),
      ),
      Container(
        height: 1,
        color: Colors.white24,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Material(
          borderRadius: BorderRadius.circular(4.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              extandConsumer.currentSeconds.toString(),
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
      Center(
        child: TextButton(
          onPressed: () {
            extandConsumer.startTimeout();
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
            extandConsumer.timerCancle();
          },
          child: const Text(
            'STOP',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      //   if (extandConsumer.isExtand)
      const UserStatusExtendWidget()
    ]);
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
