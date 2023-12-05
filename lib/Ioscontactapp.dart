import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:platform_converter/ContactList.dart';
import 'package:platform_converter/Contactmodal.dart';

import 'package:platform_converter/ThemeModal.dart';
import 'package:platform_converter/ValuesModal.dart';
import 'package:platform_converter/main.dart';
import 'package:provider/provider.dart';

class Ioscontact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Ioscontactstate();
  }
}

int currentindex = 0;

class Ioscontactstate extends State<Ioscontact>
    with SingleTickerProviderStateMixin {
  final forvaluesprovider = forvalues();
  final ContactlistProvider = ContactList();
  late TabController controller;
  Color color = Colors.blue;
  @override
  void initState() {
    controller = TabController(length: 4, vsync: this, initialIndex: 1);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeModal>(context);
    final forvaluesprovider = Provider.of<forvalues>(context);
    final ContactlistProvider = Provider.of<ContactList>(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Platform Converter',
          style: TextStyle(color: themeNotifier.currentTheme.focusColor),
        ),
        backgroundColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
        actions: [
          CupertinoSwitch(
            value: forvaluesprovider.isIos,
            focusColor: Colors.green,
            thumbColor: Colors.green,
            trackColor: Colors.white,
            activeColor: Colors.white,
            onChanged: (value) {
              forvaluesprovider.navigate(value);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: TabBarView(
        controller: controller,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor:
                          themeNotifier.isLight ? Colors.black : Colors.white,
                      radius: 40,
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.grey,
                          size: 25,
                        ),
                        onPressed: () async {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 100,
                                width: 500,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              icon: Icon(
                                                Icons.camera_alt_outlined,
                                                size: 35,
                                              ),
                                              onPressed: () async {
                                                final ImagePicker picker =
                                                    ImagePicker();
                                                img = await picker.pickImage(
                                                    source: ImageSource.camera);
                                              }),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Camera",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.photo,
                                              size: 35,
                                            ),
                                            onPressed: () async {
                                              final ImagePicker picker =
                                                  ImagePicker();
                                              img = await picker.pickImage(
                                                  source: ImageSource.gallery);
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Gallrey",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  textfilled("Full Name", Icons.person_2_outlined, fullname,
                      TextInputType.name),
                  textfilled("Phone Number", Icons.phone, phonenumber,
                      TextInputType.number),
                  textfilled("Chat Conversation", Icons.comment, chat,
                      TextInputType.name),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: themeNotifier.currentTheme.focusColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Consumer(
                            builder: (context, forvalues, child) {
                              return SizedBox(
                                width: 200,
                                child: TextField(
                                  style: TextStyle(
                                    color:
                                        themeNotifier.currentTheme.focusColor,
                                  ),
                                  controller: dateinput,
                                  decoration: InputDecoration(
                                      labelText: "Pick Date",
                                      labelStyle: TextStyle(
                                        color: themeNotifier
                                            .currentTheme.focusColor,
                                      )),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2025),
                                    );
                                    if (pickDate != null) {
                                      print(pickDate);
                                      String formatteDate =
                                          DateFormat('dd-MM-yyyy')
                                              .format(pickDate);
                                      print(formatteDate);
                                      forvaluesprovider.date(formatteDate);
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: forvaluesprovider.selectedTime);
                          forvaluesprovider.pickTime(picked!);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              color: themeNotifier.currentTheme.focusColor,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              forvaluesprovider.Time != null
                                  ? forvaluesprovider.Time!
                                  : "Pick Time",
                              style: TextStyle(
                                  color: themeNotifier.currentTheme.focusColor),
                            )
                          ],
                        ),
                      )),
                  Center(
                    child: Consumer(builder: (context, ContactList, child) {
                      return ElevatedButton(
                        onPressed: () {
                          ContactlistProvider.addContact(MainContact(
                              fullname.text.toString(),
                              phonenumber.text.toString(),
                              chat.text.toString(),
                              dateinput.text.toString(),
                              timeinput.text.toString()));
                          ContactlistProvider.saveContacts();
                          fullname.clear();
                          phonenumber.clear();
                          chat.clear();
                          dateinput.clear();
                          timeinput.clear();
                        },
                        child: Text('Save'),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          ContactlistProvider.contacts.length > 0
              ? Column(
                  children: [
                    for (int i = 0;
                        i < ContactlistProvider.contacts.length;
                        i++) ...[
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 200,
                                width: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: themeNotifier.isLight
                                            ? Colors.black
                                            : Colors.white,
                                        child: Text(ContactlistProvider
                                            .contacts[i].fullname[0])),
                                    Text(
                                        "${ContactlistProvider.contacts[i].fullname}"),
                                    Text(
                                        "${ContactlistProvider.contacts[i].chat}"),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () async {},
                                              icon: Icon(Icons.edit)),
                                          IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                        'Delete Contact',
                                                        style: TextStyle(
                                                            color: themeNotifier
                                                                .currentTheme
                                                                .focusColor),
                                                      ),
                                                      content: Text(
                                                        'Are you sure you want to delete this contact?',
                                                        style: TextStyle(
                                                            color: themeNotifier
                                                                .currentTheme
                                                                .focusColor),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                                color: themeNotifier
                                                                    .currentTheme
                                                                    .focusColor),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            ContactlistProvider
                                                                .deleteContact(
                                                                    i);
                                                            ContactlistProvider
                                                                .saveContacts();
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            'Delete',
                                                            style: TextStyle(
                                                                color: themeNotifier
                                                                    .currentTheme
                                                                    .focusColor),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: themeNotifier
                                                    .currentTheme.focusColor,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: ListTile(
                          title: Text(
                            "${ContactlistProvider.contacts[i].fullname}",
                            style: TextStyle(
                                color: themeNotifier.currentTheme.focusColor,
                                fontWeight: FontWeight.w400),
                          ),
                          subtitle: Text(
                            "${ContactlistProvider.contacts[i].chat}",
                            style: TextStyle(
                                color: themeNotifier.currentTheme.focusColor,
                                fontWeight: FontWeight.w400),
                          ),
                          leading: CircleAvatar(
                              backgroundColor: c,
                              child: Text(
                                  ContactlistProvider.contacts[i].fullname[0])),
                          trailing: Text(
                            "${ContactlistProvider.contacts[i].date}  ${forvaluesprovider.Time}",
                            style: TextStyle(
                                color: themeNotifier.currentTheme.focusColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ]
                  ],
                )
              : Center(
                  child: Text('No any Chat yet...',
                      style: TextStyle(
                          color: themeNotifier.currentTheme.focusColor))),
          ContactlistProvider.contacts.length > 0
              ? Column(
                  children: [
                    for (int i = 0;
                        i < ContactlistProvider.contacts.length;
                        i++) ...[
                      ListTile(
                        title: Text(
                          "${ContactlistProvider.contacts[i].fullname}",
                          style: TextStyle(
                              color: themeNotifier.currentTheme.focusColor,
                              fontWeight: FontWeight.w400),
                        ),
                        subtitle: Text(
                          "${ContactlistProvider.contacts[i].chat}",
                          style: TextStyle(
                              color: themeNotifier.currentTheme.focusColor,
                              fontWeight: FontWeight.w400),
                        ),
                        leading: CircleAvatar(
                            backgroundColor: c,
                            child: Text(
                                ContactlistProvider.contacts[i].fullname[0])),
                        trailing: Icon(
                          CupertinoIcons.phone,
                          color: Colors.blue,
                        ),
                      ),
                    ]
                  ],
                )
              : Center(
                  child: Text('No any Call yet...',
                      style: TextStyle(
                          color: themeNotifier.currentTheme.focusColor))),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.person,
                                color: themeNotifier.currentTheme.focusColor),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Profile",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: themeNotifier
                                            .currentTheme.focusColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "Update Profile",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: themeNotifier
                                            .currentTheme.focusColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      CupertinoSwitch(
                        value: forvaluesprovider.profile,
                        focusColor: Colors.green,
                        thumbColor: Colors.green,
                        trackColor: Colors.white,
                        activeColor: Colors.white,
                        onChanged: (value) {
                          forvaluesprovider.changeProfile(value);
                        },
                      ),
                    ],
                  ),
                  Consumer<forvalues>(
                    builder: (context, forvalueprovider, child) {
                      return forvalueprovider.profile
                          ? Center(
                              child: Column(
                                children: [
                                  Center(
                                    child: CircleAvatar(
                                      backgroundColor: themeNotifier.isLight
                                          ? Color(0xff4E378B)
                                          : Color(0xffE9DAFC),
                                      radius: 40,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.camera_alt_outlined,
                                          color: themeNotifier
                                              .currentTheme.focusColor,
                                          size: 25,
                                        ),
                                        onPressed: () async {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: 100,
                                                width: 500,
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                            icon: Icon(
                                                              Icons
                                                                  .camera_alt_outlined,
                                                              color: themeNotifier
                                                                  .currentTheme
                                                                  .focusColor,
                                                              size: 35,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              final ImagePicker
                                                                  picker =
                                                                  ImagePicker();
                                                              imgp = await picker
                                                                  .pickImage(
                                                                      source: ImageSource
                                                                          .camera);
                                                            },
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "Camera",
                                                              style: TextStyle(
                                                                  color: themeNotifier
                                                                      .currentTheme
                                                                      .focusColor,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                            icon: Icon(
                                                              Icons.photo,
                                                              color: themeNotifier
                                                                  .currentTheme
                                                                  .focusColor,
                                                              size: 35,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              final ImagePicker
                                                                  picker =
                                                                  ImagePicker();
                                                              imgp = await picker
                                                                  .pickImage(
                                                                      source: ImageSource
                                                                          .gallery);
                                                            },
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "Gallrey",
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: 100,
                                      child: TextField(
                                        style: TextStyle(
                                            color: themeNotifier
                                                .currentTheme.focusColor,
                                            fontSize: 20),
                                        decoration: InputDecoration(
                                            hintText: "Enter your name..",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                        controller: pname,
                                        readOnly: r,
                                      )),
                                  SizedBox(
                                      width: 100,
                                      child: TextField(
                                        style: TextStyle(
                                            color: themeNotifier
                                                .currentTheme.focusColor,
                                            fontSize: 18),
                                        decoration: InputDecoration(
                                            hintText: "Enter your Bio..",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                        controller: pBio,
                                        readOnly: r,
                                      )),
                                  SizedBox(
                                    width: 140,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              forvaluesprovider
                                                  .saveProfileInfoToPrefs();
                                            },
                                            child: Text(
                                              "SAVE",
                                              style: TextStyle(color: color),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              pname.clear();
                                              pBio.clear();
                                            },
                                            child: Text(
                                              "Cancle",
                                              style: TextStyle(color: color),
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Divider(
                      color: Colors.grey,
                      height: 10,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.light_mode_outlined,
                                color: themeNotifier.currentTheme.focusColor),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Theme",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: themeNotifier
                                            .currentTheme.focusColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "Change Theme",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: themeNotifier
                                            .currentTheme.focusColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      CupertinoSwitch(
                        value: themeNotifier.isLight,
                        focusColor: Colors.green,
                        thumbColor: Colors.green,
                        trackColor: Colors.white,
                        activeColor: Colors.white,
                        onChanged: (value) {
                          themeNotifier.setTheme(value);
                          themeNotifier.saveThemevalue(value);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: DefaultTabController(
        initialIndex: 1,
        length: 4,
        child: TabBar(
          controller: controller,
          indicatorSize: TabBarIndicatorSize.label,
          automaticIndicatorColorAdjustment: true,
          unselectedLabelColor: Colors.grey,
          labelColor: color,
          labelPadding: EdgeInsets.zero,
          indicatorColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
          indicatorPadding: EdgeInsets.zero,
          labelStyle: TextStyle(color: color),
          tabs: [
            Tab(
              icon: Icon(CupertinoIcons.person_badge_plus),
            ),
            Tab(
              icon: Icon(CupertinoIcons.chat_bubble_2),
            ),
            Tab(
              icon: Icon(CupertinoIcons.phone),
            ),
            Tab(
              icon: Icon(CupertinoIcons.settings),
            ),
          ],
        ),
      ),
    );
  }

  Widget s1() {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: themeNotifier.isLight
                      ? Color(0xff4E378B)
                      : Color(0xffE9DAFC),
                  radius: 40,
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                      size: 25,
                    ),
                    onPressed: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 100,
                            width: 500,
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.camera_alt_outlined,
                                          size: 35,
                                        ),
                                        onPressed: () async {
                                          final ImagePicker picker =
                                              ImagePicker();
                                          img = await picker.pickImage(
                                              source: ImageSource.camera);
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Camera",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.photo,
                                          size: 35,
                                        ),
                                        onPressed: () async {
                                          final ImagePicker picker =
                                              ImagePicker();
                                          img = await picker.pickImage(
                                              source: ImageSource.gallery);
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Gallrey",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              textfilled("Full Name", Icons.person_2_outlined, fullname,
                  TextInputType.name),
              textfilled("Phone Number", Icons.phone, phonenumber,
                  TextInputType.number),
              textfilled(
                  "Chat Conversation", Icons.comment, chat, TextInputType.name),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.date_range),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Consumer(
                        builder: (context, forvalues, child) {
                          return SizedBox(
                            width: 200,
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  Color(0xff4E378B), BlendMode.modulate),
                              child: TextField(
                                style: TextStyle(color: Colors.black),
                                controller: dateinput,
                                decoration: InputDecoration(
                                    labelText: "Pick Date",
                                    labelStyle: TextStyle(color: Colors.black)),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2025),
                                  );
                                  if (pickDate != null) {
                                    print(pickDate);
                                    String formatteDate =
                                        DateFormat('dd-MM-yyyy')
                                            .format(pickDate);
                                    print(formatteDate);
                                    forvaluesprovider.date(formatteDate);
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.watch_later_outlined),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Consumer(
                        builder: (context, forvalues, child) {
                          return SizedBox(
                            width: 200,
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  Color(0xff4E378B), BlendMode.modulate),
                              child: TextField(
                                  style: TextStyle(color: Colors.black),
                                  controller: timeinput,
                                  decoration: InputDecoration(
                                      labelText: "Pick Time",
                                      labelStyle:
                                          TextStyle(color: Colors.black)),
                                  readOnly: true,
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now());
                                    if (pickedTime != null) {
                                      print(pickedTime);
                                      DateTime parsedtime = DateFormat.jm()
                                          .parse(pickedTime.toString());
                                      print(parsedtime);
                                      String Formattedtime =
                                          TimeOfDay.fromDateTime(parsedtime)
                                              as String;
                                      forvaluesprovider.time(Formattedtime);
                                    } else {
                                      print("Time is not Selected");
                                    }
                                  }),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final fname = fullname.text;
                    final pnumber = phonenumber.text;
                    final chats = chat.text;
                    final date = dateinput.text;
                    final time = timeinput.text;
                    if (fname.isNotEmpty && pnumber.isNotEmpty) {
                      final newContact =
                          MainContact(fname, pnumber, chats, date, time);
                      Navigator.pop(context, newContact);
                    } else {}
                    fullname.clear();
                    phonenumber.clear();
                    chat.clear();
                    dateinput.clear();
                    timeinput.clear();
                  },
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget s2() {
    return Material(
      child: Consumer<ContactList>(builder: (context, provider, child) {
        return Consumer(builder: (context, ThemeModal themeNotifier, child) {
          return provider.contacts.isEmpty
              ? Center(
                  child: Text("No any Chats yet..."),
                )
              : ListView.builder(
                  itemCount: provider.contacts.length,
                  itemBuilder: (context, index) {
                    final contact = provider.contacts[index];
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: themeNotifier.isLight
                                        ? Colors.white
                                        : Colors.black,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ),
                                  Text("${contact.fullname}"),
                                  Text("${contact.chat}"),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            // final editedContact = await Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) => EditScreen(index: index),
                                            //     settings: RouteSettings(
                                            //       arguments: contact,
                                            //     ),
                                            //   ),
                                            // );
                                            // if (editedContact != null) {
                                            //   // ContactlistProvider.updateContact(index, editedContact as mainContact);
                                            // }
                                          },
                                          icon: Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Delete Contact'),
                                                  content: Text(
                                                      'Are you sure you want to delete this contact?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        // provider.deleteContact(index);
                                                        // Navigator.of(context).pop();
                                                      },
                                                      child: Text('Delete'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: Icon(Icons.delete)),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: ListTile(
                        title: Text("${contact.fullname}"),
                        subtitle: Text("${contact.chat}"),
                        leading: CircleAvatar(
                          backgroundColor: themeNotifier.isLight
                              ? Colors.white
                              : Colors.black,
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                        trailing: Text("${contact.date}  ${contact.time}"),
                      ),
                    );
                  },
                );
        });
      }),
    );
  }

  Widget s3() {
    return Material(
      child: Consumer<ContactList>(builder: (context, provider, child) {
        return Consumer(builder: (context, ThemeModal themeNotifier, child) {
          return provider.contacts.isEmpty
              ? Center(
                  child: Text("No any Calls yet..."),
                )
              : ListView.builder(
                  itemCount: provider.contacts.length,
                  itemBuilder: (context, index) {
                    final contact = provider.contacts[index];
                    return ListTile(
                      title: Text("${contact.fullname}"),
                      subtitle: Text("${contact.chat}"),
                      leading: CircleAvatar(
                        backgroundColor:
                            themeNotifier.isLight ? Colors.white : Colors.black,
                        child: Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(CupertinoIcons.phone),
                        color: Colors.blue,
                        onPressed: () {},
                      ),
                    );
                  },
                );
        });
      }),
    );
  }

  Widget s4() {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.person),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Profile",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Update Profile",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    activeColor: Colors.white,
                    inactiveThumbColor: Colors.white,
                    activeTrackColor: Colors.green,
                    value: profilebool,
                    onChanged: (value) {},
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: themeNotifier.isLight
                          ? Color(0xff4E378B)
                          : Color(0xffE9DAFC),
                      radius: 40,
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.black,
                          size: 25,
                        ),
                        onPressed: () async {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: 100,
                                width: 500,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.camera_alt_outlined,
                                              size: 35,
                                            ),
                                            onPressed: () async {
                                              final ImagePicker picker =
                                                  ImagePicker();
                                              imgp = await picker.pickImage(
                                                  source: ImageSource.camera);
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Camera",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.photo,
                                              size: 35,
                                            ),
                                            onPressed: () async {
                                              final ImagePicker picker =
                                                  ImagePicker();
                                              imgp = await picker.pickImage(
                                                  source: ImageSource.gallery);
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Gallrey",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                      width: 100,
                      child: TextField(
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(
                            hintText: "Enter your name..",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                        controller: pname,
                        readOnly: r,
                      )),
                  SizedBox(
                      width: 100,
                      child: TextField(
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                            hintText: "Enter your Bio..",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                        controller: pBio,
                        readOnly: r,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            forvaluesprovider.read(r);
                          },
                          child: Text(
                            "SAVE",
                            style: TextStyle(
                                color: themeNotifier.isLight
                                    ? Colors.white
                                    : Color(0xff4E378B)),
                          )),
                      TextButton(
                          onPressed: () {
                            pname.clear();
                            pBio.clear();
                          },
                          child: Text(
                            "CLEAR",
                            style: TextStyle(
                                color: themeNotifier.isLight
                                    ? Colors.white
                                    : Color(0xff4E378B)),
                          )),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Divider(
                  color: Colors.grey,
                  height: 10,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.light_mode_outlined),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Theme",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Change Theme",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: themeNotifier.isLight,
                    activeColor: Colors.white,
                    inactiveThumbColor: Colors.white,
                    activeTrackColor: Colors.green,
                    onChanged: (value) {
                      themeNotifier.setTheme(value);
                      themeNotifier.saveThemevalue(value);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  Widget textfilled(
      String name, IconData icon, TextEditingController t, dynamic k) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
              themeNotifier.isLight ? Colors.white : Colors.blue,
              BlendMode.modulate),
          child: TextField(
            style: TextStyle(color: Colors.black),
            controller: t,
            keyboardType: k,
            decoration: InputDecoration(
              icon: Icon(
                icon,
                size: 20,
                color: Colors.blue,
              ),
              labelText: name,
              labelStyle: TextStyle(
                  color: themeNotifier.isLight ? Colors.white : Colors.black,
                  fontSize: 20),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                    color: themeNotifier.isLight ? Colors.white : Colors.black,
                    width: 4,
                  )),
            ),
          ),
        ),
      );
    });
  }
}
