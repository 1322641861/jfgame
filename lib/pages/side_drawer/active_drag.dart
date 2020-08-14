import 'package:flutter/material.dart';
import 'package:jfgame/util/screen_utils.dart';
import './title_bar_head.dart';
import '../../widgets/user_dialog.dart';
import '../../util/theme_color_utils.dart';

/// 右侧展示
class ActiveRightDrag extends StatefulWidget {
  ActiveRightDrag({Key key, this.data}) : super(key: key);
  final Map data;

  @override
  _ActiveRightDragState createState() => _ActiveRightDragState();
}

class _ActiveRightDragState extends State<ActiveRightDrag>
    with SingleTickerProviderStateMixin {
  List<Map> listData;
  TabController _tabController;
  Map balanceData = {
    'title': 'Welcome to my app',
    'dateList': ['2020-03-21'],
    'startTime': '2020-01',
    'endTime': '2020-02',
    'makeMoney': '3.8',
    'bettingMoney': '1000.0'
  };
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
        vsync: this, length: this.balanceData['dateList'].length);
    this.listData = [
      {
        'imgSrc':
            'https://t8.baidu.com/it/u=3571592872,3353494284&fm=79&app=86&size=h300&n=0&g=4n&f=jpeg?sec=1595916477&t=8e4719073e6c066e0c785f07ccb322a4',
        'value': '测试充值送'
      },
      {
        'imgSrc':
            'https://t8.baidu.com/it/u=3571592872,3353494284&fm=79&app=86&size=h300&n=0&g=4n&f=jpeg?sec=1595916477&t=8e4719073e6c066e0c785f07ccb322a4',
        'value': '欢迎来到尖峰游戏'
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Drawer(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: titleBarHead(widget.data['userName']),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: this.listData.map((value) {
                  return FlatButton(
                      onPressed: () {
                        print('点击card');
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  return BaseDialog(
                                      this._showBalance(this.balanceData),
                                      constraints.maxHeight < 240
                                          ? 240
                                          : constraints.maxHeight,
                                      ScreenUtils.screenW(context) * .6);
                                },
                              );
                            });
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  AspectRatio(
                                    aspectRatio: 1.0,
                                    child: Image.network(
                                      '${value['imgSrc']}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text('${value['value']}'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ));
                }).toList(),
              ),
            )
          ],
        ),
      );
    });
  }

  /// 弹框内容
  Widget _showBalance(balanceData) {
    if (balanceData == null) return null;
    return Scaffold(
      appBar: AppBar(
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        centerTitle: true,
        bottom: TabBar(
          controller: this._tabController,
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: <Widget>[
            Tab(
              text: balanceData['dateList'][0],
            )
          ],
        ),
        title: Text(balanceData['title']),
      ),
      body: TabBarView(
        controller: this._tabController,
        children: <Widget>[
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          this._columnMoneyMsg(),
                          SizedBox(
                            height: 30,
                            width: 1,
                            child: Container(
                              color: Colors.blue,
                            ),
                          ),
                          this._columnMoneyMsg('红利金额', 'makeMoney'),
                          SizedBox(
                            height: 30,
                            width: 1,
                            child: Container(
                              color: Colors.blue,
                            ),
                          ),
                          this._columnMoneyMsg('提现投注金额', 'bettingMoney'),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: <Widget>[
                              Text(
                                '活动时间',
                                style: TextStyle(color: Colors.blue),
                              ),
                              Text(
                                '${balanceData['startTime']}至${balanceData['endTime']}',
                              ),
                            ],
                          ),
                        ),
                        RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            '申领',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            print('申领');
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _columnMoneyMsg([String descri, String value]) {
    return descri != null
        ? Column(
            children: <Widget>[
              Text(
                descri,
                style: TextStyle(color: Color(0xff666666)),
              ),
              Text(
                  '￥${balanceData[value] != null ? balanceData[value] : "0.00"}')
            ],
          )
        : Column(
            children: <Widget>[Text('-')],
          );
  }
}

/// 左侧展示
class ActiveLeftDrag extends StatefulWidget {
  ActiveLeftDrag({Key key}) : super(key: key);

  @override
  _ActiveLeftDragState createState() => _ActiveLeftDragState();
}

class _ActiveLeftDragState extends State<ActiveLeftDrag> {
  Map requestParams = {'_status': 0, '_species': 0};

  final List<List<Map>> _leftBtnList = [
    [
      {'name': '所有', 'value': 0},
      {'name': '待开始', 'value': 1},
      {'name': '进行中', 'value': 2},
      {'name': '已结束', 'value': 3},
    ],
    [
      {'name': '所有', 'value': 0},
      {'name': '彩票', 'value': 1},
      {'name': '棋牌', 'value': 2},
      {'name': '真人', 'value': 3},
      {'name': '电子', 'value': 4},
      {'name': '捕鱼', 'value': 5},
      {'name': '体育', 'value': 6},
    ]
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // 滚动容器中使用ListView时,外层包裹一层container
        child: ListView(
          shrinkWrap: true, // 决定列表长度仅包裹其内容的长度
          children: <Widget>[
            this._colunmBtnWgList(this._leftBtnList[0], '_status'),
            Divider(
              // color: Color(0xff4199fd),
              color: Theme.of(context).accentColor,
              height: 4,
            ),
            this._colunmBtnWgList(this._leftBtnList[1], '_species'),
          ],
        ),
      ),
    );
  }

  Widget _colunmBtnWgList(List<Map> value, String type) {
    return Column(
      children: value.map((f) {
        return RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                  width: 1,
                  // color: Color(0xffbfdcfe)
                  color: ThemeColorChange().lightSelectAccentColor(context))),
          child: Text(f['name']),
          // textColor: this.requestParams[type] == f['value']
          //     ? Colors.white
          //     : Color(0xff495269),
          color: ThemeColorChange().selectedWithAccentColor(
              this.requestParams[type] == f['value'], context),
          onPressed: () {
            setState(() {});
            this.requestParams[type] = f['value'];
          },
        );
      }).toList(),
    );
  }
}
