import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top:0,bottom: 0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom:4.0),
                child: Title(
                    color: const Color(0xFF000000),
                    child: const Text(
                      'SeeSo Sample',
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontSize: 24),
                    ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top:4.0),
                child: Divider(
                  color: Colors.grey[800],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top:12,bottom: 12),
                child: Text(
                  "Follow steps below to experience gaze tracking",
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w300,
                      fontSize: 16),
                ),
              ),
            ]));
  }
}
