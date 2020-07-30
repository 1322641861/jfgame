import 'dart:async';

import 'package:flutter/material.dart';
import '../container_tab.dart';
import '../../util/screen_utils.dart';

class StartupPage extends StatefulWidget {
  StartupPage({Key key}) : super(key: key);

  @override
  _StartupPageState createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  var container = ContainerTab();
  bool _show = true;
  @override
  Widget build(BuildContext context) {
    print('启动');
    return Stack(
      // Stack层叠式分布，定位
      children: <Widget>[
        Offstage(
          // offstage为true时控件隐藏
          child: container,
          offstage: this._show,
        ),
        Offstage(
          // 启动页
          child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment(0.0, 0.0), // Alignment.center
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: ScreenUtils.screenH(context) / 5,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage('assets/images/ic_launcher.png'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          '请稍等，启动中。。。',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                // 屏幕安全区域（有些手机边边不是方的，有圆角遮挡）
                SafeArea(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(right: 30, top: 20),
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
                        child: CountDownWidget(// 倒计时启动
                            onCountDownFinishCallBack: (bool value) {
                          if (value) {
                            setState(() {
                              this._show = false;
                            });
                          }
                        }),
                        decoration: BoxDecoration(
                            color: Color(0xffEDEDED),
                            borderRadius: BorderRadius.circular(10)),
                        // borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      ),
                    ),
                    // Padding( // 底部图片
                    //   padding: EdgeInsets.only(bottom: 40),
                    //   child: null,
                    // )
                  ],
                ))
              ],
            ),
          ),
          offstage: !this._show,
        ),
      ],
    );
  }
}

// 倒计时
class CountDownWidget extends StatefulWidget {
  final Function onCountDownFinishCallBack;
  CountDownWidget({Key key, @required this.onCountDownFinishCallBack})
      : super(key: key);

  @override
  _CountDownWidgetState createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  var _seconds = 3;
  Timer _timer;
  @override
  void initState() {
    super.initState();
    this._startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('${this._seconds}', style: TextStyle(fontSize: 17.0)),
    );
  }

  void _startTimer() {
    // Timer.periodic 周期定时器
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {}); // 必须加，刷新定时器。下面的逻辑可不放setState里面
      if (_seconds <= 1) {
        widget.onCountDownFinishCallBack(true);
        this._cancelTimer();
        return;
      }
      _seconds--;
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
  }
}
