import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:jfgame/pages/auth/login_page.dart';
import 'package:jfgame/util/screen_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import '../../provider/theme_model.dart';
import '../../generated/l10n.dart';
import '../../provider/locale_model.dart';
import '../../util/theme_color_utils.dart';

class TopDrawer extends StatefulWidget {
  TopDrawer({Key key, this.title, this.exit = false}) : super(key: key);
  final String title;
  final bool exit;

  @override
  _TopDrawerState createState() => _TopDrawerState();
}

class _TopDrawerState extends State<TopDrawer>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController controller;
  Animation<Offset> slideAnimation;
  int _tabIndex = 2; // 默认选中'设置'
  int _tabSelectedColorIndex = 2; // 默认选中的颜色
  GlobalKey _formKey = new GlobalKey<FormState>();
  TextEditingController _pwdController = new TextEditingController();
  bool _keyBoardOpen = false;
  bool _isPassword = false;
  Locale currentLang;

  @override
  void initState() {
    // 初始化一个动画控制器 定义好动画的执行时长
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    // 初始化一个补间动画 实例化一个补间类动画的实例，明确需要变换的区间大小和作用的controller对象
    slideAnimation = Tween<Offset>(begin: Offset(0.0, -4.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));
    // 提供方法 为动画添加监听
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    super.initState();
    // 注册键盘事件
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(Duration.zero, () async {
      // 本地记录的语言类型
      setState(() {
        this.currentLang = FlutterI18n.currentLocale(context);
        print('currentLang-------${currentLang}');
      });
    });
  }

  /// 监听键盘
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (MediaQuery.of(context).viewInsets.bottom == 0) {
          // 关闭键盘
          this._keyBoardOpen = false;
        } else {
          // 显示键盘
          this._keyBoardOpen = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double scaffoldH = ScreenUtils.screenH(context) / 1.8 < 210
        ? 210
        : ScreenUtils.screenH(context) / 1.8;
    return SlideTransition(
        position: slideAnimation,
        child: Container(
          height: ScreenUtils.screenH(context),
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              children: <Widget>[
                // appbar蒙层背景色
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: ScreenUtils.screenW(context),
                      height: 56,
                      color: ThemeColorChange().bgColorWithDark(context),
                    )),
                // 下拉抽屉内容区
                Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(28),
                            bottomRight: Radius.circular(28)),
                      ),
                      title: Text('您好，${widget.title}'),
                      leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      // actions: <Widget>[
                      //   IconButton(
                      //       icon: Icon(Icons.menu),
                      //       onPressed: () {
                      //         Navigator.push(context,
                      //             MaterialPageRoute(builder: (context) {
                      //           return UserDrawer();
                      //         }));
                      //       })
                      // ],
                    ),
                    body: Container(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      height: scaffoldH,
                      width: ScreenUtils.screenW(context),
                      decoration: BoxDecoration(
                        color: ThemeColorChange().bgColorWithDark(context),
                      ),
                      child: Column(
                        children: <Widget>[
                          // tab按钮
                          Center(
                            child: !this._keyBoardOpen
                                ? Container(
                                    width: ScreenUtils.screenW(context) * 0.7,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        _settingsRaisedButton(Icon(Icons.home),
                                            0, 'topDrawerTexts.tab1', () {
                                          setState(() {
                                            this._tabIndex = 0;
                                          });
                                        }),
                                        _settingsRaisedButton(Icon(Icons.lock),
                                            1, "topDrawerTexts.tab2", () {
                                          setState(() {
                                            this._tabIndex = 1;
                                          });
                                        }),
                                        _settingsRaisedButton(
                                            Icon(Icons.settings),
                                            2,
                                            'topDrawerTexts.tab3', () {
                                          setState(() {
                                            this._tabIndex = 2;
                                          });
                                        }),
                                      ],
                                    ),
                                  )
                                : null,
                          ),
                          !this._keyBoardOpen
                              ? Padding(
                                  padding: EdgeInsets.only(top: 13),
                                  child: Divider(
                                    // color: Colors.blue,
                                    color: Theme.of(context).accentColor,
                                    height: 2,
                                  ),
                                )
                              : Text(''),
                          // tab展示区域；可滑动 + Expanded最大适应 =》 防止超出范围
                          Expanded(
                            child: CustomScrollView(
                              shrinkWrap: true,
                              slivers: <Widget>[
                                SliverList(
                                    delegate: SliverChildListDelegate(<Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 30, top: 10, right: 30),
                                    child: this._tabSelect(),
                                  ),
                                ]))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                // 底部蒙层点击收起下拉抽屉
                Positioned(
                  bottom: 0,
                  width: ScreenUtils.screenW(context),
                  height: ScreenUtils.screenH(context) - scaffoldH - 80,
                  child: FlatButton(
                      // color: Colors.blue,
                      onPressed: () {
                    controller.reverse(); // 反向播放
                    Navigator.pop(context);
                  }),
                ),
              ],
            ),
          ),
        ));
  }

  /// tab点击切换
  Widget _tabSelect() {
    Widget _tabSelected;
    switch (this._tabIndex) {
      case 0:
        _tabSelected = Column(
          children: <Widget>[
            Form(
                key: this._formKey,
                autovalidate: true,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      // autofocus: true,
                      controller: this._pwdController,
                      obscureText: this._isPassword, // 密码框
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            // 方框内小图标right
                            onPressed: () {
                              setState(() {
                                this._isPassword = !this._isPassword;
                              });
                            },
                            icon: Icon(this._isPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          labelText: '新资金密码',
                          hintText: '请输入新资金密码',
                          icon: Icon(Icons.lock)),
                      // 校验密码
                      validator: (v) {
                        return v.trim().length > 5 && v.trim().length <= 30
                            ? null
                            : '密码长度为6～30位';
                      },
                    ),
                    // 登录按钮
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              padding: EdgeInsets.all(10.0),
                              child: Text("提交修改"),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              onPressed: () {
                                // 通过_formKey.currentState 获取FormState后，
                                // 调用validate()方法校验用户名密码是否合法，校验
                                // 通过后再提交数据。
                                if ((_formKey.currentState as FormState)
                                    .validate()) {
                                  // 验证通过提交数据
                                  print(
                                      '输入的密码-----------${_pwdController.text}');
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ))
          ],
        );
        break;
      case 1:
        _tabSelected = Column(
          children: <Widget>[
            Form(
                key: this._formKey,
                autovalidate: true,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      // autofocus: true,
                      controller: this._pwdController,
                      obscureText: this._isPassword, // 密码框
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            // 方框内小图标right
                            onPressed: () {
                              setState(() {
                                this._isPassword = !this._isPassword;
                              });
                            },
                            icon: Icon(this._isPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          labelText: '旧登陆密码',
                          hintText: '请输入旧登陆密码',
                          icon: Icon(Icons.lock)),
                      // 校验密码
                      validator: (v) {
                        return v.trim().length > 5 && v.trim().length <= 30
                            ? null
                            : '密码长度为6～30位';
                      },
                    ),
                    TextFormField(
                      // autofocus: true,
                      controller: this._pwdController,
                      obscureText: this._isPassword, // 密码框
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            // 方框内小图标right
                            onPressed: () {
                              setState(() {
                                this._isPassword = !this._isPassword;
                              });
                            },
                            icon: Icon(this._isPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          labelText: '新登陆密码',
                          hintText: '请输入新登陆密码',
                          icon: Icon(Icons.lock)),
                      // 校验密码
                      validator: (v) {
                        return v.trim().length > 5 && v.trim().length <= 30
                            ? null
                            : '密码长度为6～30位';
                      },
                    ),
                    // 登录按钮
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              padding: EdgeInsets.all(10.0),
                              child: Text("提交修改"),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              onPressed: () {
                                // 通过_formKey.currentState 获取FormState后，
                                // 调用validate()方法校验用户名密码是否合法，校验
                                // 通过后再提交数据。
                                if ((_formKey.currentState as FormState)
                                    .validate()) {
                                  // 验证通过提交数据
                                  print(
                                      '输入的密码-----------${_pwdController.text}');
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ))
          ],
        );
        break;
      case 2:
        _tabSelected = Column(
          children: <Widget>[
            DarkThemeWidget(),
            SizedBox(
              height: 8,
            ),
            ColorThemeWidget(),
            SizedBox(
              height: 8,
            ),
            LanguageWidget(this.currentLang),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              child: RaisedButton(
                  child: Text('退出登陆'),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new LoginPage()),
                        (route) => route == null);
                  }),
            )
          ],
        );
        break;
    }
    return _tabSelected;
  }

  @override
  void dispose() {
    controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// 图标文字按钮（上层图标，下层文字）
  Widget _settingsRaisedButton(Icon icon, int index,
      [String title, Function onPressed]) {
    return RaisedButton(
        padding: EdgeInsets.only(top: 4, bottom: 4),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(
              width: 1,
              color: ThemeColorChange().lightSelectAccentColor(context),
            )),
        color: ThemeColorChange().selectedWithAccentColor(
            this._tabSelectedColorIndex == index, context),
        textColor: ThemeColorChange().bgColorWithDark(context, true),
        child: title != null
            ? Column(
                children: <Widget>[
                  icon,
                  SizedBox(
                    height: 5,
                  ),
                  Text(FlutterI18n.translate(context, title))
                  // Text('${title}')
                ],
              )
            : Column(
                children: <Widget>[
                  icon,
                ],
              ),
        onPressed: () {
          onPressed != null ? onPressed() : Navigator.pop(context);
          this._tabSelectedColorIndex = this._tabIndex;
        });
  }
}

/// 主题切换
class DarkThemeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(builder: (context, ThemeModel t, Widget child) {
      String themeName = '白昼模式';
      Icon themeIcon;
      var themeBrightness = Theme.of(context).brightness;
      themeIcon = Icon(
          themeBrightness == Brightness.light
              ? Icons.brightness_5
              : Icons.brightness_2,
          color: Theme.of(context).accentColor);
      themeName = themeBrightness == Brightness.dark ? '黑夜模式' : '白昼模式';
      return ListTile(
        leading: themeIcon,
        title: Text(
          themeName,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        trailing: CupertinoSwitch(
          activeColor: Theme.of(context).accentColor,
          value: themeBrightness == Brightness.dark,
          onChanged: (value) {
            switchDarkMode(context);
          },
        ),
      );
    });
  }

  ///切换黑夜模式
  void switchDarkMode(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      showToast("检测到系统为暗黑模式,已为你自动切换", position: ToastPosition.bottom);
    } else {
      Provider.of<ThemeModel>(context, listen: false).switchTheme(
          userDarkMode: Theme.of(context).brightness == Brightness.light);
    }
  }
}

/// 颜色自定义
class ColorThemeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      // title: Text(S.of(context).theme),
      title: ThemeColorChange().text('主题颜色', context),
      leading: ThemeColorChange().icon(Icons.color_lens, context),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: <Widget>[
              ...Colors.primaries.map((color) {
                return Material(
                  color: color,
                  child: InkWell(
                    onTap: () => Provider.of<ThemeModel>(context, listen: false)
                        .switchTheme(color: color),
                    child: Container(
                      height: 40,
                      width: 40,
                    ),
                  ),
                );
              }).toList(),
              Material(
                child: InkWell(
                  onTap: () => Provider.of<ThemeModel>(context, listen: false)
                      .switchRandomTheme(
                          brightness: Theme.of(context).brightness),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).accentColor),
                    ),
                    width: 40,
                    height: 40,
                    child: Text(
                      "?",
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

/// 语言选择
class LanguageWidget extends StatelessWidget {
  final Locale currentLang;
  LanguageWidget(this.currentLang);
  // 改变并刷新语言
  changeLange(BuildContext context, Locale currentLang) async {
    // currentLang =
    //     currentLang.languageCode == 'en' ? Locale('it') : Locale('en');
    currentLang = LocaleModel().locale;
    await FlutterI18n.refresh(context, currentLang);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ThemeColorChange().text('自动', context),
          ThemeColorChange().text(
              LocaleModel.localeName(
                  Provider.of<LocaleModel>(context).localeIndex, context),
              context),
        ],
      ),
      leading: ThemeColorChange().icon(Icons.public, context),
      children: LocaleModel.localeValueList.asMap().keys.map((key) {
        var model = Provider.of<LocaleModel>(context);
        return RadioListTile(
          value: key,
          onChanged: (index) {
            model.switchLocale(index);
            this.changeLange(context, this.currentLang);
          },
          groupValue: model.localeIndex,
          title: Text(LocaleModel.localeName(key, context)),
        );
      }).toList(),
    );
  }
}
