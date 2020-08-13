import 'package:flutter/material.dart';
import './title_bar_head.dart';

class DownloadRightDrag extends StatelessWidget {
  final Map data;
  const DownloadRightDrag({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Drawer(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: titleBarHead(this.data['userName']),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: constraints.maxWidth,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: constraints.maxWidth * .2,
                          // height: constraints.maxHeight * .6,
                          child: Image.network(
                            'https://static.jianfengdemo.com/static/img/download-light-blue-1.0e76540c.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        RaisedButton(
                            color: Colors.blue,
                            child: Text(
                              '下载尖峰APP',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              print('下载尖峰APP');
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DownloadleftDrag extends StatelessWidget {
  const DownloadleftDrag({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
