import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 右侧标题栏
Widget titleBarHead([String data]) {
  return Row(
    children: <Widget>[
      Icon(Icons.person),
      Expanded(
        child: Container(
          alignment: Alignment.centerLeft,
          height: 30,
          child: Text(
            '${data != null ? data : ''}',
            overflow: TextOverflow.ellipsis,
            // style: TextStyle(),
          ),
        ),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Tooltip(
          // 长按提示
          message: '客服',
          child: IconButton(
              icon: Icon(Icons.face),
              onPressed: () {
                print('客服');
              }),
        ),
      )
    ],
  );
}

/// 余额显示栏
Widget balanceShowHead(BoxConstraints constraints, [String data]) {
  return Container(
    padding: EdgeInsets.all(15),
    alignment: Alignment.centerLeft,
    width: constraints.maxWidth,
    // width: 200,
    // height: 200,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          // colors: <Color>[Color(0x7a7ef5), Color(0xfe0b0)],
          colors: <Color>[Colors.blue, Colors.green],
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
        )),
    child: Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          '账户余额',
          style: TextStyle(color: Colors.white),
        ),
        Text('${data != null ? data : ''}',
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ],
    ),
  );
}
