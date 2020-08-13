import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_model.dart';

// Color adaptiveColor(BuildContext context) {
//   Color defaultColor = Theme.of(context).brightness;
//   return Brightness.dark ? Colors.white : Colors.black;
// }
class AdaptiveColor extends StatelessWidget {
  final BuildContext context;
  AdaptiveColor({this.context});

  @override
  Widget build(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Text('')
        : Text('');
  }
}
