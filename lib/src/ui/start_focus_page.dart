import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/src/provider/start_focus_provider.dart';

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
    await Future.delayed(const Duration(seconds: 5)).then((value) {
      RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      y = position.dy;
      x = position.dx;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<StartFocusProvider>(context, listen: false)
            .onsetdxdyBoxCordinate(x - 80 / 2, y - 80 / 2);

        Provider.of<StartFocusProvider>(context, listen: false)
            .getStartingTimer(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final extandConsumer = Provider.of<StartFocusProvider>(context);

    const style = TextStyle(
        color: Colors.white,
        decoration: TextDecoration.none,
        fontSize: 14,
        fontWeight: FontWeight.normal);
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: double.maxFinite,
            color: Colors.white12,
            child: const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8),
              child: Text('Start Focus State Case',
                  style: style, textAlign: TextAlign.center),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          child: Container(
            key: key,
            height: 80,
            width: 80,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
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
      ],
    );
  }
}
