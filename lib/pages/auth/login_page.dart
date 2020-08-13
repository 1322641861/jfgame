import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jfgame/pages/auth/register_page.dart';
import '../container_tab.dart';
import '../../util/screen_utils.dart';
import '../../widgets/loading.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  // _LoginPageState createState() => _LoginPageState();
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  var _userName = TextEditingController();
  var _password = TextEditingController();

  bool _isPassword = true;
  bool _loading = false;
  // 自定义渐变色登陆按钮
  Widget gradientButton(Function perssed) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment(-1.0, 0.0),
            end: Alignment(1.0, 0.0),
            // colors: <Color>[Color(0x7a7ef5), Color(0x2fe0b0)]
            colors: <Color>[Colors.purple, Colors.green],
          )),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: Colors.transparent,
        elevation: 0, // 未点击时隐藏按钮阴影
        highlightElevation: 0, // 点击时隐藏阴影
        onPressed: perssed,
        child: Container(
          alignment: Alignment.center,
          height: 50,
          child: Text(
            '登 录',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = ScreenUtils.screenW(context);
    final screenHeight = ScreenUtils.screenH(context);
    return Container(
      width: num.parse((screenWidth * 0.8).toStringAsFixed(2)),
      height: num.parse((screenHeight * 0.8).toStringAsFixed(2)),
      padding: EdgeInsets.fromLTRB(80, 0, 80, 0),
      // alignment: Alignment.center,
      color: Colors.white,
      child: Scaffold(
        // resizeToAvoidBottomPadding: false, // 不允许修改键盘影响布局
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Container(
                child: Container(
              padding: EdgeInsets.only(top: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Offstage(
                    child: LoadingWidget.getLoading(
                        backgroundColor: Colors.transparent),
                    offstage: true,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      'welcome',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: '账号',
                        // hintText: "相当于placeholder",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                        // icon: Icon(Icons),
                      ),
                      controller: this._userName,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: TextField(
                      obscureText: this._isPassword, // 密码框
                      // keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: '密码',
                        // hintText: "相当于placeholder",
                        border: OutlineInputBorder(),
                        prefixIcon:
                            Icon(Icons.lock_outline), // prefixIcon方框内小图标left
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
                      ),
                      controller: this._password,
                    ),
                  ),
                  this.gradientButton(() {
                    this._userName.text = '登陆';
                    this._loading = true;
                    Timer(Duration(seconds: 2), () {
                      this._loading = false;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ContainerTab();
                      }));
                    });
                  }),
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return RegisterPage();
                                }));
                              },
                              child: Text(
                                '注册新账号',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                          ),
                          FlatButton(
                              onPressed: () {
                                print('关于更多》》》》》');
                              },
                              child: Text('about'))
                        ],
                      )),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
