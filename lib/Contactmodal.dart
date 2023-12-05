import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainContact {
  String fullname;
  String phoneNumber;
  String chat;
  String date;
  String time;
  MainContact(this.fullname, this.phoneNumber, this.chat, this.date, this.time);
}
