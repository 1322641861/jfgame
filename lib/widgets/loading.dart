import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoadingWidget {
  // 默认loading
  static Widget getLoading({Color backgroundColor, Color loadingBgColor}) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor == null ? Colors.transparent : backgroundColor,
        ),
        child: Container(
            width: 75,
            height: 75,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: loadingBgColor == null ? Colors.white : loadingBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 25,
                height: 25,
                child: CupertinoActivityIndicator(
                  radius: 15.0,
                ),
              ),
            )));
  }

  // 自定义loading
  static containerLoadingBody(Widget body,
      {bool isLoading = true, Color backgroundColor, Color loadingColor}) {
    return Stack(
      children: <Widget>[
        body,
        Offstage(
          child: getLoading(
              backgroundColor: backgroundColor, loadingBgColor: loadingColor),
          offstage: !isLoading,
        )
      ],
    );
  }
}
