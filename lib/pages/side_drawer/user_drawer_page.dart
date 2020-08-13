import 'package:flutter/material.dart';
import 'package:jfgame/util/screen_utils.dart';
import 'package:flutter/cupertino.dart';
import './user_drag.dart';
import './agent_drag.dart';
import './active_drag.dart';
import './download_drag.dart';
import './msg_drag.dart';

class UsersDrawer extends StatefulWidget {
  UsersDrawer({Key key}) : super(key: key);

  @override
  _UsersDrawerState createState() => _UsersDrawerState();
}

class _UsersDrawerState extends State<UsersDrawer> {
  List<BottomNavigationBarItem> bottomItems;
  final List titles = ['个人中心', '代理中心', '活动中心', '信息中心', '下载中心'];
  int _currentIndex = 0;
  List<Widget> rightTopShowPage;
  List<Widget> leftShowPage;
  Map data = {'userName': 'Warren', 'money': '0.000'};

  @override
  void initState() {
    this.bottomItems = [
      BottomNavigationBarItem(
          icon: Icon(Icons.home), title: Text('${this.titles[0]}')),
      BottomNavigationBarItem(
          icon: Icon(Icons.people), title: Text('${this.titles[1]}')),
      BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard), title: Text('${this.titles[2]}')),
      BottomNavigationBarItem(
          icon: Icon(Icons.markunread), title: Text('${this.titles[3]}')),
      BottomNavigationBarItem(
          icon: Icon(Icons.font_download), title: Text('${this.titles[4]}')),
    ];

    this.rightTopShowPage = [
      UserRightDrag(data: this.data), // 用户中心
      AgentRightDrag(data: this.data), // 代理中心
      ActiveRightDrag(data: this.data), // 活动中心
      MsgRightDrag(data: this.data), // 信息中心
      DownloadRightDrag(data: this.data), // 下载中心
    ];
    this.leftShowPage = [
      UserLeftDraw(),
      AgentLeftDrag(),
      ActiveLeftDrag(),
      MsgLeftDrag(),
      DownloadleftDrag()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Container(
        color: Color.fromRGBO(0, 0, 0, .6),
        child: SafeArea(
          child: Stack(children: <Widget>[
            /// 右侧展示页
            Positioned(
                width: ScreenUtils.screenW(context) * .7,
                height: ScreenUtils.screenH(context),
                right: 0,
                // bottom: 0,
                child: Scaffold(
                  /// 上层展示内容
                  body: Container(
                    width: ScreenUtils.screenW(context) * .7,
                    child: this.rightTopShowPage[this._currentIndex],
                  ),

                  /// 底部tab
                  bottomNavigationBar: BottomNavigationBar(
                    items: this.bottomItems,
                    currentIndex: this._currentIndex,
                    type: BottomNavigationBarType.fixed,
                    fixedColor: Colors.blue,
                    onTap: (int index) {
                      setState(() {});
                      this._currentIndex = index;
                    },
                  ),
                )),

            /// 左侧蒙层展示页
            Positioned(
              left: 0,
              width: ScreenUtils.screenW(context) -
                  ScreenUtils.screenW(context) * 0.7,
              height: ScreenUtils.screenH(context),
              child: LayoutBuilder(builder: (context, containers) {
                return FlatButton(
                  // color: Colors.yellow,
                  onPressed: () {
                    print('userDrawer蒙层');
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: EdgeInsets.only(top: 15),
                      // color: Colors.blue,
                      child: Column(
                        children: <Widget>[
                          Row(
                            // crossAxisAlignment:
                            //     WrapCrossAlignment.center, // 交叉轴对其方向
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.close),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              Text(
                                '${this.titles[this._currentIndex]}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.blue,
                            height: 4,
                          ),
                          this.leftShowPage[this._currentIndex]
                        ],
                      )),
                );
              }),
            )
          ]),
        ),
      ),
    );
  }
}
