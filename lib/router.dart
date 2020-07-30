import 'package:flutter/material.dart';

// final routes = {
//   '/': (context) => ContainerTab(),
//   '/login': (context) => LoginPage(),
// };
/*
 * 1. 替换路由
 * 比如注册时每次下一次都用替换路由，则返回时会直接返回首页
 * Navigator.pushReplacementNamed('/home');
 * 2.返回根
 * Navigator.pushAndRemoveUntil(
 *  new MaterialPageRoute(builder: (context) => new Tabs(index: 1)), // 控制tabs下标，默认为0
 *  (route) => route == null
 * );
 * 3.直接返回
 * Navigator.pop();
 * 4.pushNamed
 * Navigator.pushNamed(context,'/login');
 * 5.push
 */
// var onGenerateRoute = (RouteSettings settings) {
//   // 统一处理
//   final String name = settings.name;
//   final Function pageContentBuilder = routes[name];
//   if (pageContentBuilder != null) {
//     if (settings.arguments != null) {
//       final Route route = MaterialPageRoute(
//           builder: (context) =>
//               pageContentBuilder(context, arguments: settings.arguments));
//       return route;
//     } else {
//       final Route route =
//           MaterialPageRoute(builder: (context) => pageContentBuilder(context));
//       return route;
//     }
//   }
// };

class Router {
  static const homePage = 'app://';
  static const detailPage = 'app://DetailPage';
  static const playListPage = 'app://VideosPlayPage';
  static const searchPage = 'app://SearchPage';
  static const photoHero = 'app://PhotoHero';
  static const personDetailPage = 'app://PersonDetailPage';
  static const battingPage = 'app://BattingPage';
  Widget _getPage(String url, dynamic params) {
    if (url.startsWith('https://') || url.startsWith('http://')) {
      // return WebViewPage(url, params: params);
    } else {
      switch (url) {
        case battingPage:
        // return BattingPage();
        // case photoHero: // 图片卡片
        //   return PhotoHeroPage(
        //       photoUrl: params['photoUrl'], width: params['width']);
        // case personDetailPage:
        //   return PersonDetailPage(params['personImgUrl'], params['id']);
      }
    }
    return null;
  }

  Router.pushNoParams(BuildContext context, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, null);
    }));
  }

  Router.push(BuildContext context, String url, dynamic params) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }
}
