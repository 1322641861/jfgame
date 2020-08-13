import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import './pages/startup/startup_page.dart';
import './provider/locale_model.dart';
import './provider/theme_model.dart';
import './config/storage_manage.dart';
import './generated/l10n.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  runApp(MyApp());
  // 横屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeLeft,
  ]);
  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
}

// void targetPlatformType() {
//   defaultTargetPlatform == TargetPlatform.iOS ? 'iOS' : 'android';
// }

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // DateTime _lastPressedAt; // 上次点击时间
    // WillPopScope(
    //   onWillPop: () async {
    //     if (_lastPressedAt == null ||
    //         DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
    //       //两次点击间隔超过1秒则重新计时
    //       _lastPressedAt = DateTime.now();
    //       showToast('再次点击退出应用');
    //       return false;
    //     }
    //     return true;
    //   })
    return RestartWidget(
      child: OKToast(
          child: MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider.value(value: ThemeModel()), //主题 provider
          ChangeNotifierProvider.value(value: LocaleModel()), //本地语种 provider
        ],
        child: Consumer2<ThemeModel, LocaleModel>(builder:
            (BuildContext context, themeModel, localeModel, Widget child) {
          return MaterialApp(
            // initialRoute: '/',
            // onGenerateRoute: onGenerateRoute, // 路由传值
            // theme: ThemeData(backgroundColor: Colors.blue),
            theme: themeModel.themeData(),
            debugShowCheckedModeBanner: false,
            darkTheme: themeModel.themeData(platformDarkMode: true),
            locale: localeModel.locale,
            localizationsDelegates: [
              S.delegate, //支持语种对应的字段
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: S.delegate.supportedLocales, //支持的语种
            home: Scaffold(
                resizeToAvoidBottomPadding: false, // 防止键盘弹出遮挡界面或改变布局
                body: StartupPage()
                // RotatedBox(
                //   // 旋转（90*n)
                //   quarterTurns: 1,
                //   child: StartupPage(),
                // ),
                ),
          );
        }),
      )),
    );
  }
}

class RestartWidget extends StatefulWidget {
  final Widget child;
  // assert断言，条件为false时抛出异常（只在debug模式下有效）
  // 还可以传一个提示字符串，eg assert(x==1,'x==1了,报错')
  RestartWidget({Key key, @required this.child})
      : assert(child != null),
        super(key: key);

  static restartApp(BuildContext context) {
    final _RestartWidgetState state =
        context.ancestorStateOfType(const TypeMatcher<_RestartWidgetState>());
    state.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: widget.child,
    );
  }
}
