import 'package:flutter/material.dart';
import 'package:test_flutter/src/ui/start_focus_page.dart';
import 'package:test_flutter/src/ui/user_status_widget.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding:  EdgeInsets.only(top:MediaQuery.of(context).padding.top+16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 48,
            ),
            Divider(
              color: Theme.of(context).dividerColor,
              thickness: 1,
            ),
      TextButton(onPressed: () {
        
        Navigator.push(context, MaterialPageRoute(builder: (context) => StartFocusTestCase(),),
        );
      },child: Text('Test Case 1 (Eye Focus)',style: TextStyle(fontSize: 16),),),
TextButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserSatatusWidget(),));
      },child: Text('Test Case 2 (Blink)',style: TextStyle(fontSize: 16),),),
          ],
        ),
      ),
    );
  }
}