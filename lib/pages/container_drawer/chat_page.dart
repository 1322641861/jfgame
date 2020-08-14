import 'dart:async';

import 'package:flutter/material.dart' hide showModalBottomSheet;
import 'package:oktoast/oktoast.dart';
import '../../util/screen_utils.dart';
import '../../widgets/bottom_sheet.dart';

List<String> chatMsgList = [];
bottomChatDrawer(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: ScreenUtils.screenH(context) * .7,
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              // FocusScope.of(context).requestFocus(FocusNode()); // 点击信息界面关闭软键盘
            },
            child: Stack(
              children: <Widget>[
                Container(
                  height: ScreenUtils.screenH(context) * .7,
                  width: ScreenUtils.screenW(context),
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 55),
                  decoration: BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(3),
                      border: Border.fromBorderSide(
                          BorderSide(width: 1, color: Color(0xffcccccc)))),
                  child: ListView(
                    children: <Widget>[Text('data')],
                    // children: chatMsgList.map((f) {
                    //   Text(f);
                    // }).toList(),
                  ),
                ),
                InputButtomWidget(),
              ],
            ),
          ),
        );
      });
}

class BottomChatDrawer extends StatefulWidget {
  BottomChatDrawer({Key key}) : super(key: key);

  @override
  _BottomChatDrawerState createState() => _BottomChatDrawerState();
}

class _BottomChatDrawerState extends State<BottomChatDrawer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: null,
      future: bottomChatDrawer(context),
    );
  }
}

class InputButtomWidget extends StatelessWidget {
  final ValueChanged onEditingCompleteText;
  final TextEditingController controller = TextEditingController();

  InputButtomWidget({this.onEditingCompleteText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Positioned(
            width: ScreenUtils.screenW(context),
            bottom: 0,
            child: Container(
                color: Color(0xFFF4F4F4),
                padding:
                    EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: TextField(
                    controller: controller,
                    // autofocus: true,
                    style: TextStyle(fontSize: 16),
                    //设置键盘按钮为发送
                    textInputAction: TextInputAction.send,
                    keyboardType: TextInputType.multiline,
                    onEditingComplete: () {
                      //点击发送调用
                      print('onEditingComplete----${controller.text}');
                      if (controller.text.isEmpty) {
                        showToast('不能发送空字符');
                      } else {
                        // chatMsgList.add(controller.text);
                        print('chatMsgList------${chatMsgList}');
                      }
                      onEditingCompleteText(controller.text);
                      Navigator.pop(context);
                      // Navigator.push(context, PopRoute(child: InputButtomWidget(
                      //   onEditingCompleteText: (text) {
                      //     print('点击发送2 ---$text');
                      //   },
                      // )));
                    },
                    decoration: InputDecoration(
                      hintText: '请输入内容',
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                          left: 10, top: 5, bottom: 5, right: 10),
                      border: const OutlineInputBorder(
                        gapPadding: 0,
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                    minLines: 1,
                    maxLines: 5,
                  ),
                )),
          )
        ],
      ),
    );
  }
}

/// 过度路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
