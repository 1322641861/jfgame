import 'package:flutter/material.dart';
import './batting/batting_page.dart';
import './chat/chat_page.dart';
import './figure/figure_page.dart';
import './hall/hall_page.dart';
import './lottery/lottery_page.dart';
import 'package:flutter/cupertino.dart';

/// App最外层容器，控制底部Tab Nav
class ContainerTab extends StatefulWidget {
  ContainerTab({Key key}) : super(key: key);

  @override
  _ContainerTabState createState() => _ContainerTabState();
}

class _ContainerTabState extends State<ContainerTab> {
  final List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home), title: Text('投注记录')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.time_solid), title: Text('开奖记录')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('聊天')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.circle_filled), title: Text('路子图')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home), title: Text('彩票大厅')),
  ];
  int _selectIndex = 0;
  List<Widget> pages;
  @override
  void initState() {
    super.initState();
    this.pages = [
      BattingPage(), // 投注记录
      LotteryPage(), // 开奖记录
      ChatPage(), // 聊天
      FigurePage(), // 路子图
      HallPage(), // 彩票大厅
    ];
  }

  Widget _getPagesWidget(int index) {
    return Offstage(
        offstage: this._selectIndex != index,
        child: TickerMode(
          enabled: this._selectIndex == index,
          child: this.pages[index],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Scaffold(
          body: SafeArea(
              child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Stack(
              children: <Widget>[
                this._getPagesWidget(0),
                this._getPagesWidget(1),
                this._getPagesWidget(2),
                this._getPagesWidget(3),
                this._getPagesWidget(4),
              ],
            ),
          )),
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavigationBar(
            items: this.bottomItems,
            currentIndex: this._selectIndex,
            iconSize: 25.0,
            type: BottomNavigationBarType.fixed, // 设置底部可以撑开多个按钮
            fixedColor: Colors.blue, // 选中的颜色
            onTap: (int index) {
              setState(() {
                this._selectIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
