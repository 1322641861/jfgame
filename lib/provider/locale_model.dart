import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import '../config/storage_manage.dart';
import '../generated/l10n.dart';

class LocaleModel extends ChangeNotifier {
  ///配置语言语种
  static const localeValueList = ['', 'zh-CN', 'en'];

  ///本地语言选择的 key值
  static const kLocaleIndex = 'kLocaleIndex';

  int _localeIndex;

  int get localeIndex => _localeIndex;

  /// 初始化语言类型
  Locale get locale {
    if (_localeIndex > 0) {
      var value = localeValueList[_localeIndex].split("-");
      return Locale(value[0], value.length == 2 ? value[1] : '');
    }
    // 跟随系统
    return null;
  }

  // changeLange(BuildContext context, Locale currentLang) async {
  //   // currentLang =
  //   //     currentLang.languageCode == 'en' ? Locale('it') : Locale('en');
  //   currentLang = LocaleModel().locale;
  //   await FlutterI18n.refresh(context, currentLang);
  // }

  /// 读取存储选择的语言类型index，用于初始化语言类型
  LocaleModel() {
    _localeIndex = StorageManager.sharedPreferences.getInt(kLocaleIndex) ?? 0;
  }

  /// 存储选择的语言类型index
  switchLocale(int index) {
    _localeIndex = index;
    notifyListeners(); // 监听改变状态
    StorageManager.sharedPreferences.setInt(kLocaleIndex, index);
  }

  static String localeName(index, context) {
    switch (index) {
      case 0:
        return '自动';
      case 1:
        return '中文';
      case 2:
        return 'English';
      default:
        return '';
    }
  }
}
