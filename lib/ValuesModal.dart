import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:platform_converter/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class forvalues extends ChangeNotifier {
  TimeOfDay selectedTime = TimeOfDay.now();
  String? Time;
  bool profile = false;
  bool isAndroid = true;
  bool isIos = false;
  String profileName = "";
  String profileBio = "";

  void navigate(bool n) {
    profile = n;
    notifyListeners();
  }

  void pickTime(TimeOfDay picked) async {
    selectedTime = picked;
    final timefromat = DateFormat('HH:mm a');
    Time = timefromat
        .format(DateTime(2023, 1, 1, selectedTime.hour, selectedTime.minute));
    notifyListeners();
  }

  void time(String b) {
    timeinput.text = b;
    notifyListeners();
  }

  void date(String a) {
    dateinput.text = a;
    notifyListeners();
  }

  void read(bool e) {
    e = true;
    notifyListeners();
  }

  void changeProfile(bool value) async {
    profile = value;
    await saveProfileToPrefs(value);
    notifyListeners();
  }

  Future<void> loadProfileFromPrefs(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    profile = value;
    prefs.setBool("profile", value);
    notifyListeners();
  }

  Future<void> saveProfileToPrefs(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    profile = value;
    prefs.setBool('profile', value);
    notifyListeners();
  }

  Future<void> loadProfileInfoFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    profileName = (prefs.getString('profileName') ?? null)!;
    profileBio = (prefs.getString('profileBio') ?? null)!;
    notifyListeners();
  }

  Future<void> saveProfileInfoToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('profileName', profileName ?? '');
    prefs.setString('profileBio', profileBio ?? '');
    notifyListeners();
  }

  void saveprofile(String name, String bio) {
    profileName = name;
    profileBio = bio;
    notifyListeners();
  }
}
