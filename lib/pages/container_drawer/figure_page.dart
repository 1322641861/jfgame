import 'package:flutter/material.dart';
import 'package:jfgame/util/screen_utils.dart';

bottomFigureDrawer(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (context) {
        return Stack(
          children: <Widget>[
            Container(
              height: ScreenUtils.screenH(context) * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: ListTile(
                      title: Text('男'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            ),
          ],
        );
      });
}
