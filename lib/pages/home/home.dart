import 'package:flutter/material.dart';
import 'package:jfgame/util/screen_utils.dart';
import '../auth/login_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          width: ScreenUtils.screenW(context) * .5,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Home'),
              RaisedButton(
                  child: Text('登陆'),
                  onPressed: () {
                    // Navigator.pushNamed(context, '/login');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  }),
              RaisedButton(
                  child: Text('底部弹框'),
                  onPressed: () {
                    // bottomSheetDrawer(context);
                  }),
            ],
          )),
    );
  }
}
