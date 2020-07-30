import 'package:flutter/material.dart';
import '../auth/login_page.dart';
import '../../router.dart';

class BattingPage extends StatefulWidget {
  BattingPage({Key key}) : super(key: key);

  @override
  _BattingPageState createState() => _BattingPageState();
}

class _BattingPageState extends State<BattingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        children: <Widget>[
          Text('batting'),
          RaisedButton(
              child: Text('登陆'),
              onPressed: () {
                // Navigator.pushNamed(context, '/login');
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              })
        ],
      ),
    ));
  }
}
