import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ThemeModal with ChangeNotifier{

  String defult="light";
  bool _isLight=true;


  bool get isLight => _isLight;
  late ThemeData _currentTheme=_isLight?lighttheme():darktheme();
  ThemeData get currentTheme => _currentTheme;
  void setTheme(bool isLigt)async{
    _isLight=isLigt;
    _currentTheme=isLigt?lighttheme():darktheme();


    notifyListeners();
  }

  void ChangeTheme(String value){
    defult=value;
    notifyListeners();
  }

  void saveThemePreference(bool is_light_theme)async{
    final prefs=await SharedPreferences.getInstance();
    prefs.setBool("is_light_theme", is_light_theme);
  }

  Future<bool> loadThemePrefrence() async{
    final prefs=await SharedPreferences.getInstance();
    final isLightTheme=prefs.getBool("is_light_theme");
    _isLight = isLightTheme?? true;
    _currentTheme = _isLight?lighttheme():darktheme();
    return _isLight;
    notifyListeners();
  }
  void saveThemevalue(bool defult)async{
    final prefs=await SharedPreferences.getInstance();
    prefs.setBool("selected", defult);
  }

  Future<bool?>loadThemevalue()async{
    final prefs=await SharedPreferences.getInstance();
    final selection=prefs.getBool("selected");
    return selection;
  }


}
ThemeData lighttheme(){
  return ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade100,
      iconTheme: IconThemeData(color: Colors.black,size: 25),
      primaryColor: Colors.purple,
      focusColor: Colors.black,
      textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500)),
      radioTheme: RadioThemeData(
          fillColor: MaterialStateColor.resolveWith((states) => Colors.black)
      ),
      tabBarTheme: TabBarTheme(

        indicatorColor: Color(0xff6A53A7),
        labelColor: Color(0xff6A53A7),
        unselectedLabelColor: Colors.black,
      )
  );
}

ThemeData darktheme(){
  return ThemeData(
      scaffoldBackgroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.black,size: 25),
      primaryColor: Colors.purple,
      timePickerTheme: TimePickerThemeData(backgroundColor: Colors.purple),
      datePickerTheme: DatePickerThemeData(backgroundColor: Colors.purple),
      focusColor: Colors.white,
      textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500)),
      radioTheme: RadioThemeData(
          fillColor: MaterialStateColor.resolveWith((states) => Colors.white)
      ),
      tabBarTheme: TabBarTheme(

        indicatorColor: Color(0xff6A53A7),
        labelColor: Color(0xff6A53A7),
        unselectedLabelColor: Colors.grey,
      )
  );
}
// class ThemePref{
//   static const Prefkey='pref_kry';
//   setTheme(bool val)async{
//     SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
//     sharedPreferences.setBool(Prefkey, val);
//   }
//   getTheme() async{
//     SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
//     return sharedPreferences.getBool(Prefkey);
//   }
// }
// class ThemeModal extends ChangeNotifier{
//   bool _isDark=false;
//   ThemePref _preferances=ThemePref();
//   bool get isDark => _isDark;
//   ThemeModal(){
//     _isDark=false;
//     _preferances=ThemePref();
//     getPreferances();
//   }
//   getPreferances() async{
//     _isDark=await _preferances.getTheme();
//     notifyListeners();
//   }
//   set isDark(bool val){
//     _isDark=val;
//     _preferances.setTheme(val);
//     notifyListeners();
//   }
// }