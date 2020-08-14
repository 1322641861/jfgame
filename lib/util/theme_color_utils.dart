import 'package:flutter/material.dart';

class ThemeColorChange extends StatelessWidget {
  /// 自定义黑白模式时颜色
  Color customBrightness(BuildContext context, Color light, Color dart) {
    Color color =
        Theme.of(context).brightness == Brightness.dark ? dart : light;
    return color;
  }

  /// 一般用于边框: 白昼时返回当前主题色,黑夜时返回白色
  Color lightSelectAccentColor(BuildContext context) {
    Color color = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Theme.of(context).accentColor;
    return color;
  }

  /// 一般用于选中组件: 选中后(true)返回主题色,否则返回黑或白
  Color selectedWithAccentColor(bool b, BuildContext context) {
    Color color = b
        ? Theme.of(context).accentColor
        : Theme.of(context).brightness == Brightness.dark
            ? Colors.black45
            : Colors.white;
    // Theme.of(context).unselectedWidgetColor
    return color;
  }

  /// 一般用于页面背景颜色: 黑夜模式时页面暗黑色,白昼时白色;
  /// 第二个参数传true时，颜色相反
  Color bgColorWithDark(BuildContext context, [bool reverse = false]) {
    Color color = Theme.of(context).brightness == Brightness.dark
        ? !reverse ? Color.fromRGBO(40, 40, 40, 1) : Colors.white
        : !reverse ? Colors.white : Color.fromRGBO(40, 40, 40, 1);
    return color;
  }

  /// Text(),文本色默认为主题颜色
  Widget text(String value, BuildContext context, [double fontSize]) {
    return Text(value,
        style: TextStyle(
            fontSize: fontSize, color: Theme.of(context).accentColor));
  }

  /// Icon(), 颜色默认为主题颜色
  Widget icon(IconData icon, BuildContext context, [double size]) {
    return Icon(icon, size: size, color: Theme.of(context).accentColor);
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
