import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter/Androidcontactapp.dart';
import 'package:platform_converter/ContactList.dart';
import 'package:platform_converter/Contactmodal.dart';
import 'package:platform_converter/Splashscreen.dart';
import 'package:platform_converter/ThemeModal.dart';
import 'package:platform_converter/ValuesModal.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool atos = true;
bool profilebool = true;
bool r=false;
List<MainContact>  mainContacts=List.empty(growable: true);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  final ContactListprovider=ContactList();
  final themeProvider=ThemeModal();
  await themeProvider.loadThemePrefrence();
  await themeProvider.loadThemevalue();

  await ContactListprovider.loadContacts();
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => ThemeModal(),),
        ChangeNotifierProvider(create: (context) => forvalues(),),
        ChangeNotifierProvider(create: (context) => ContactList(),),
      ],
      child: const MyApp(),),
      );
}

TimeOfDay timeOfDay = TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);
TextEditingController dateinput = TextEditingController();
TextEditingController timeinput = TextEditingController();
TextEditingController fullname = TextEditingController();
TextEditingController phonenumber = TextEditingController();
TextEditingController pname=TextEditingController();
TextEditingController pBio=TextEditingController();
TextEditingController chat = TextEditingController();
XFile? img;
XFile? imgp;
final random=Random();
Color c=Colors.white;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return  MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/addContact': (context) => Contact(),
        },
        home: SplashScreen(),
      );
    },);
  }
}


