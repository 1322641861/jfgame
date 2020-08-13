import 'package:flutter/material.dart';
import './title_bar_head.dart';

int _isWithDraw = 0; // 0充值 1提现

/// 代理中心
class AgentRightDrag extends StatefulWidget {
  AgentRightDrag({Key key, this.data}) : super(key: key);
  final Map data;

  @override
  _AgentRightDragState createState() => _AgentRightDragState();
}

class _AgentRightDragState extends State<AgentRightDrag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Drawer(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Column(
                    children: <Widget>[
                      /// 标题栏
                      titleBarHead(widget.data['userName']),

                      /// 余额显示栏
                      balanceShowHead(constraints, widget.data['money']),
                      Center(
                        child: Container(
                            width: 200,
                            child: Row(
                              children: <Widget>[
                                RaisedButton(
                                  child: Text(
                                    '充值',
                                    style: TextStyle(
                                        color: _isWithDraw == 0
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  color: _isWithDraw == 0
                                      ? Colors.blue
                                      : Color.fromRGBO(191, 220, 254, 1),
                                  onPressed: () {
                                    setState(() {});
                                    _isWithDraw = 0;
                                    print('充值');
                                  },
                                ),
                                RaisedButton(
                                  child: Text('提现',
                                      style: TextStyle(
                                          color: _isWithDraw == 1
                                              ? Colors.white
                                              : Colors.black)),
                                  color: _isWithDraw == 1
                                      ? Colors.blue
                                      : Color.fromRGBO(191, 220, 254, 1),
                                  onPressed: () {
                                    setState(() {});
                                    _isWithDraw = 1;
                                    print('提现');
                                  },
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 2,
                  color: Colors.blue,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AgentLeftDrag extends StatelessWidget {
  const AgentLeftDrag({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
