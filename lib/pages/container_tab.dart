import 'package:flutter/material.dart';
import 'package:jfgame/pages/container_drawer/chat_page.dart';
import 'package:jfgame/pages/container_drawer/figure_page.dart';
import 'package:jfgame/pages/container_drawer/hall_page.dart';
import 'package:jfgame/pages/container_drawer/lottery_page.dart';
import 'package:jfgame/pages/home/home.dart';
import './side_drawer/top_drawer.dart';
import './side_drawer/user_drawer_page.dart';
import 'package:jfgame/util/screen_utils.dart';
import 'package:flutter/cupertino.dart';
import 'container_drawer/batting_page.dart';

/// App最外层容器，控制底部Tab Nav
class ContainerTab extends StatefulWidget {
  ContainerTab({Key key}) : super(key: key);
  @override
  _ContainerTabState createState() => _ContainerTabState();
}

class _ContainerTabState extends State<ContainerTab> {
  final List titles = ['投注记录', '开奖记录', '聊天', '路子图', '彩票大厅'];
  List<BottomNavigationBarItem> bottomItems;

  int _selectIndex = 2;
  List<Widget> pages;
  List bottomDrager;

  @override
  void initState() {
    super.initState();
    this.pages = [
      HomePage(),
    ];
    this.bottomItems = [
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home), title: Text('${this.titles[0]}')),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.time_solid),
          title: Text('${this.titles[1]}')),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home), title: Text('${this.titles[2]}')),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.circle_filled),
          title: Text('${this.titles[3]}')),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home), title: Text('${this.titles[4]}')),
    ];
    // tab加载的底部弹框
    this.bottomDrager = [
      bottomBattingDrawer, // 投注记录
      bottomLotteryDrawer, // 开奖记录
      bottomChatDrawer, // 聊天
      bottomFigureDrawer, // 路子图
      bottomHallDrawer, // 彩票大厅
    ];
  }

  /// 根据下标加载相应界面
  // _getPagesWidget(int index) {
  //   return Offstage(
  //       offstage: this._selectIndex != index,
  //       child: TickerMode(
  //         enabled: this._selectIndex == index,
  //         child: this.pages[index],
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              '一时分时彩',
            ),
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                showDialog(context: context, child: TopDrawer(title: 'warren'));
              },
            )
            // actions: <Widget>[] // 右侧显示
            ),
        // drawer: UserDrawer(),
        endDrawer: UsersDrawer(),
        drawerEdgeDragWidth: 0,
        body: SafeArea(
            child: Container(
          child: Stack(
            children: <Widget>[this.pages[0]],
          ),
        )),
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          items: this.bottomItems,
          currentIndex: 2,
          iconSize: 25.0,
          type: BottomNavigationBarType.fixed, // 设置底部可以撑开多个按钮
          fixedColor: Colors.blue, // 选中的颜色
          onTap: (int index) {
            this.bottomDrager[index](context);
            setState(() {
              // this._selectIndex = index;
            });
          },
        ),
      ),
    );
  }
}
