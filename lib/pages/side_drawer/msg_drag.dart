import 'package:flutter/material.dart';
import './title_bar_head.dart';
import '../../util/theme_color_utils.dart';

class MsgRightDrag extends StatefulWidget {
  MsgRightDrag({Key key, this.data}) : super(key: key);
  final Map data;
  @override
  _MsgRightDragState createState() => _MsgRightDragState();
}

class _MsgRightDragState extends State<MsgRightDrag> {
  List<Map> noticeList = [
    {'msg': '[重要通知]近期有仿冒尖峰官网', 'date': '2020-05-07', 'id': 1},
    {'msg': '2019尖峰参展亚博会靓影', 'date': '2020-05-07', 'id': 2},
    {'msg': '2019尖峰参展亚博会靓影', 'date': '2020-05-07', 'id': 3},
  ];
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
    // this._scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     Future.delayed(Duration(seconds: 1), () {
    //       print('刷新成功');
    //       setState(() {});
    //       this.noticeList.add({
    //         'msg': '新增${this.noticeList.length + 2}',
    //         'date': '2020-05-07',
    //         'id': this.noticeList.length + 2,
    //       });
    //     });
    //   }
    // });
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
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: this.noticeList.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == this.noticeList.length - 1 && index < 8) {
                        this.noticeList.add({
                          'msg': '新增${index + 2}',
                          'date': '2020-05-07',
                          'id': index + 2,
                        });
                      }
                      // else {
                      //   showToast('已加载全部数据');
                      // }
                      return this.noticeListWidget(index, constraints);
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget noticeListWidget(int index, BoxConstraints constraints) {
    return index != 8
        ? Container(
            margin: EdgeInsets.only(top: 8),
            // color: Color(0xfff0f7ff),
            color: ThemeColorChange()
                .customBrightness(context, Color(0xfff0f7ff), Colors.black45),
            child: ListTile(
              title: Text(this.noticeList[index]['msg']),
              subtitle: Text(this.noticeList[index]['date']),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                print('打开弹框-id:${this.noticeList[index]['id']}');
              },
            ),
          )
        : Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 3),
                  width: constraints.maxWidth * .3,
                  child: Divider(
                    height: 2,
                    color: Color(0xff666666),
                  ),
                ),
                Center(
                  child: Text(
                    '已加载全部数据',
                    style: TextStyle(color: Color(0xff666666), fontSize: 12),
                  ),
                ),
              ],
            ),
          );
  }
}

/// 左侧展示
class MsgLeftDrag extends StatefulWidget {
  MsgLeftDrag({Key key}) : super(key: key);

  @override
  _MsgLeftDragState createState() => _MsgLeftDragState();
}

class _MsgLeftDragState extends State<MsgLeftDrag> {
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
              color: Color(0xff4199fd),
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
                  color: ThemeColorChange().lightSelectAccentColor(context))),
          child: Text(f['name']),
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
