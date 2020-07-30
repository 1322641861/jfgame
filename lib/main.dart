import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import './pages/startup/startup_page.dart';

void main() {
  runApp(MyApp());
  // 横屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeLeft,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RestartWidget(
        child: MaterialApp(
      theme: ThemeData(backgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      // onGenerateRoute: onGenerateRoute, // 路由传值
      home: Scaffold(
          resizeToAvoidBottomPadding: false, // 防止键盘弹出遮挡界面或改变布局
          body: StartupPage()
          // RotatedBox(
          //   // 旋转（90*n)
          //   quarterTurns: 1,
          //   child: StartupPage(),
          // ),
          ),
    ));
  }
}

class RestartWidget extends StatefulWidget {
  final Widget child;
  // assert断言，条件为false时抛出异常（只在debug模式下有效）
  // 还可以传一个提示字符串，eg assert(x==1,'x==1了,报错')
  RestartWidget({Key key, @required this.child})
      : assert(child != null),
        super(key: key);

  static restartApp(BuildContext context) {
    final _RestartWidgetState state =
        context.ancestorStateOfType(const TypeMatcher<_RestartWidgetState>());
    state.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: widget.child,
    );
  }
}
