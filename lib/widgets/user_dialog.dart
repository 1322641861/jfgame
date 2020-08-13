import 'package:flutter/material.dart';

class BaseDialog extends Dialog {
  // 子控件
  final Widget widget;
  final double height;
  final double width;
  BaseDialog(this.widget, this.height, this.width, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: EdgeInsets.all(12),
        child: Material(
          // 覆盖屏幕组件
          type: MaterialType.transparency, // 覆盖一个透明的背景层
          child: Container(
            height: this.height,
            width: this.width,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                )),
            child: this.widget,
          ),
        ),
      ),
    );
  }
}
