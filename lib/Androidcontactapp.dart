import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:platform_converter/ContactList.dart';
import 'package:platform_converter/Contactmodal.dart';

import 'package:platform_converter/Ioscontactapp.dart';
import 'package:platform_converter/ThemeModal.dart';
import 'package:platform_converter/ValuesModal.dart';
import 'package:platform_converter/main.dart';
import 'package:provider/provider.dart';

class Contact extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Contactstate();
  }
}

class Contactstate extends State<Contact> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TimeOfDay _timePicked;
  Color color = Colors.purple;
  TimeOfDay _time = new TimeOfDay.now();
  @override
  void initState() {
    dateinput.text = "";
    timeinput.text = "";

    Color color = Color.fromRGBO(
        random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
    c = color;
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 2);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeModal>(context);
    final forvaluesprovider = Provider.of<forvalues>(context);
    final ContactlistProvider = Provider.of<ContactList>(context);
    // TODO: implement build
    return Consumer(builder: (context, ContactList, child) {
      return Scaffold(
          backgroundColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            bottomOpacity: 0,
            toolbarOpacity: 0,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
            title: Text(
              "Platform Converter",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: themeNotifier.currentTheme.focusColor),
            ),
            actions: [
              Consumer(builder: (context, forvalues, child) {
                return Switch(
                  value: forvaluesprovider.isAndroid,
                  activeTrackColor: Colors.green,
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.black38,
                  onChanged: (value) {
                    forvaluesprovider.navigate(value);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Ioscontact(),
                    ));
                  },
                );
              }),
            ],
          ),
          body: Column(children: [
            Container(
              child: TabBar(
                  controller: _tabController,
                  indicatorColor: color,
                  labelColor: color,
                  indicatorPadding: EdgeInsets.only(left: 10, right: 10),
                  unselectedLabelColor: themeNotifier.currentTheme.focusColor,
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.person_add_alt,
                      ),
                    ),
                    Tab(
                      text: "CHATS",
                    ),
                    Tab(
                      text: "CALLS",
                    ),
                    Tab(
                      text: "SETTINGS",
                    ),
                  ]),
            ),
            Expanded(
                child: SizedBox(
              child: TabBarView(controller: _tabController, children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundColor: themeNotifier.isLight
                                ? Colors.black
                                : Colors.white,
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
                                                      img = await picker
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .camera);
                                                    }),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Camera",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                    img =
                                                        await picker.pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                  },
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Gallrey",
                                                    style:
                                                        TextStyle(fontSize: 20),
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
                        text("Full Name", Icons.person_2_outlined, fullname,
                            TextInputType.name),
                        text("Phone Number", Icons.phone, phonenumber,
                            TextInputType.number),
                        text("Chat Conversation", Icons.comment, chat,
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
                                          color: themeNotifier
                                              .currentTheme.focusColor,
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
                                          DateTime? pickDate =
                                              await showDatePicker(
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
                                            forvaluesprovider
                                                .date(formatteDate);
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
                                    initialTime:
                                        forvaluesprovider.selectedTime);
                                forvaluesprovider.pickTime(picked!);
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.watch_later_outlined,
                                    color:
                                        themeNotifier.currentTheme.focusColor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    forvaluesprovider.Time != null
                                        ? forvaluesprovider.Time!
                                        : "Pick Time",
                                    style: TextStyle(
                                        color: themeNotifier
                                            .currentTheme.focusColor),
                                  )
                                ],
                              ),
                            )),
                        Center(
                          child:
                              Consumer(builder: (context, ContactList, child) {
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                              backgroundColor:
                                                  themeNotifier.isLight
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
                                                        builder: (BuildContext
                                                            context) {
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
                                                          .currentTheme
                                                          .focusColor,
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
                                      color:
                                          themeNotifier.currentTheme.focusColor,
                                      fontWeight: FontWeight.w400),
                                ),
                                subtitle: Text(
                                  "${ContactlistProvider.contacts[i].chat}",
                                  style: TextStyle(
                                      color:
                                          themeNotifier.currentTheme.focusColor,
                                      fontWeight: FontWeight.w400),
                                ),
                                leading: CircleAvatar(
                                    backgroundColor: c,
                                    child: Text(ContactlistProvider
                                        .contacts[i].fullname[0])),
                                trailing: Text(
                                  "${ContactlistProvider.contacts[i].date}  ${ContactlistProvider.contacts[i].time}",
                                  style: TextStyle(
                                      color:
                                          themeNotifier.currentTheme.focusColor,
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
                                    color:
                                        themeNotifier.currentTheme.focusColor,
                                    fontWeight: FontWeight.w400),
                              ),
                              subtitle: Text(
                                "${ContactlistProvider.contacts[i].chat}",
                                style: TextStyle(
                                    color:
                                        themeNotifier.currentTheme.focusColor,
                                    fontWeight: FontWeight.w400),
                              ),
                              leading: CircleAvatar(
                                  backgroundColor: c,
                                  child: Text(ContactlistProvider
                                      .contacts[i].fullname[0])),
                              trailing: Icon(
                                Icons.call,
                                color: Colors.green,
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
                                      color: themeNotifier
                                          .currentTheme.focusColor),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                            Switch(
                              value: forvaluesprovider.profile,
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
                                            backgroundColor:
                                                themeNotifier.isLight
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
                                                                            source:
                                                                                ImageSource.camera);
                                                                  },
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "Camera",
                                                                    style: TextStyle(
                                                                        color: themeNotifier
                                                                            .currentTheme
                                                                            .focusColor,
                                                                        fontSize:
                                                                            20),
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
                                                                            source:
                                                                                ImageSource.gallery);
                                                                  },
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "Gallrey",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20),
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
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
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
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
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
                                                    style:
                                                        TextStyle(color: color),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    pname.clear();
                                                    pBio.clear();
                                                  },
                                                  child: Text(
                                                    "Cancle",
                                                    style:
                                                        TextStyle(color: color),
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
                                      color: themeNotifier
                                          .currentTheme.focusColor),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                            Switch(
                              value: themeNotifier.isLight,
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
              ]),
            ))
          ]));
    });
  }

  // Scaffold(
  //   body: Consumer(builder: (context, ContactList, index) {
  //     return ContactlistProvider.contacts.isEmpty
  //         ? Center(
  //       child: Text("No any Chats yet..."),
  //     )
  //         : ListView.builder(
  //       itemCount: ContactlistProvider.contacts.length,
  //       itemBuilder: (context, index) {
  //         final conatct =
  //         ContactlistProvider.contacts[index];
  //         return GestureDetector(
  //           onTap: () {
  //             showModalBottomSheet(
  //               context: context,
  //               builder: (context) {
  //                 return Container(
  //                   child: Column(
  //                     mainAxisAlignment:
  //                     MainAxisAlignment.center,
  //                     children: [
  //                       CircleAvatar(
  //                         backgroundColor:
  //                         themeNotifier.isLight
  //                             ? Colors.white
  //                             : Colors.black,
  //                         child: Icon(
  //                           Icons.person,
  //                           color: Colors.grey,
  //                           size: 20,
  //                         ),
  //                       ),
  //                       Text("${conatct.fullname}"),
  //                       Text("${conatct.chat}"),
  //                       Row(
  //                         children: [
  //                           IconButton(
  //                               onPressed: () async {
  //                                 final editedContact =
  //                                 await Navigator
  //                                     .push(
  //                                   context,
  //                                   MaterialPageRoute(
  //                                     builder: (context) =>
  //                                         EditScreen(
  //                                             index:
  //                                             index),
  //                                     settings:
  //                                     RouteSettings(
  //                                       arguments:
  //                                       conatct,
  //                                     ),
  //                                   ),
  //                                 );
  //                                 if (editedContact !=
  //                                     null) {
  //                                   // ContactlistProvider.updateContact(index, editedContact as mainContact);
  //                                 }
  //                               },
  //                               icon: Icon(Icons.edit)),
  //                           IconButton(
  //                               onPressed: () {
  //                                 showDialog(
  //                                   context: context,
  //                                   builder:
  //                                       (BuildContext
  //                                   context) {
  //                                     return AlertDialog(
  //                                       title: Text(
  //                                           'Delete Contact'),
  //                                       content: Text(
  //                                           'Are you sure you want to delete this contact?'),
  //                                       actions: [
  //                                         TextButton(
  //                                           onPressed:
  //                                               () {
  //                                             Navigator.of(
  //                                                 context)
  //                                                 .pop();
  //                                           },
  //                                           child: Text(
  //                                               'Cancel'),
  //                                         ),
  //                                         TextButton(
  //                                           onPressed:
  //                                               () {
  //                                             ContactlistProvider
  //                                                 .deleteContact(
  //                                                 index);
  //                                           },
  //                                           child: Text(
  //                                               'Delete'),
  //                                         ),
  //                                       ],
  //                                     );
  //                                   },
  //                                 );
  //                               },
  //                               icon:
  //                               Icon(Icons.delete)),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               },
  //             );
  //           },
  //           child: ListTile(
  //             title: Text("${conatct.fullname}"),
  //             subtitle: Text("${conatct.chat}"),
  //             leading: CircleAvatar(
  //               backgroundColor: themeNotifier.isLight
  //                   ? Colors.white
  //                   : Colors.black,
  //               child: Icon(
  //                 Icons.person,
  //                 color: Colors.grey,
  //                 size: 20,
  //               ),
  //             ),
  //             trailing: Text(
  //                 "${conatct.date}  ${conatct.time}"),
  //           ),
  //         );
  //       },
  //     );
  //   }),
  // ),
  // Scaffold(
  //   body: Consumer(builder: (context, ContactList, child) {
  //     return ContactlistProvider.contacts.isEmpty
  //         ? Center(
  //       child: Text("No any Calls yet..."),
  //     )
  //         : ListView.builder(
  //       itemCount: ContactlistProvider.contacts.length,
  //       itemBuilder: (context, index) {
  //         final contact =
  //         ContactlistProvider.contacts[index];
  //         return ListTile(
  //           title: Text("${contact.fullname}"),
  //           subtitle: Text("${contact.chat}"),
  //           leading: CircleAvatar(
  //             backgroundColor: themeNotifier.isLight
  //                 ? Colors.white
  //                 : Colors.black,
  //             child: Icon(
  //               Icons.person,
  //               color: Colors.grey,
  //               size: 20,
  //             ),
  //           ),
  //           trailing: IconButton(
  //             icon: Icon(Icons.call),
  //             color: Colors.green,
  //             onPressed: () {},
  //           ),
  //         );
  //       },
  //     );
  //   }),
  // ),
  // Scaffold(
  //   body: Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Container(
  //                 child: Row(
  //                   children: [
  //                     Icon(Icons.person),
  //                     Padding(
  //                       padding:
  //                       const EdgeInsets.only(left: 30),
  //                       child: Column(
  //                         mainAxisAlignment:
  //                         MainAxisAlignment.start,
  //                         crossAxisAlignment:
  //                         CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             "Profile",
  //                             style: TextStyle(
  //                                 fontSize: 20,
  //                                 fontWeight: FontWeight.w700),
  //                           ),
  //                           Text(
  //                             "Update Profile",
  //                             style: TextStyle(
  //                                 fontSize: 16,
  //                                 fontWeight: FontWeight.w400),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Switch(
  //                 value: profilebool,
  //                 onChanged: (value) {
  //                   profilebool = value;
  //                 },
  //               ),
  //             ],
  //           ),
  //           profilebool == true
  //               ? Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Center(
  //                 child: CircleAvatar(
  //                   backgroundColor: themeNotifier.isLight
  //                       ? Color(0xff4E378B)
  //                       : Color(0xffE9DAFC),
  //                   radius: 40,
  //                   child: IconButton(
  //                     icon: Icon(
  //                       Icons.camera_alt_outlined,
  //                       color: Colors.black,
  //                       size: 25,
  //                     ),
  //                     onPressed: () async {
  //                       showModalBottomSheet(
  //                         context: context,
  //                         builder: (context) {
  //                           return Container(
  //                             height: 100,
  //                             width: 500,
  //                             child: Center(
  //                               child: Row(
  //                                 mainAxisAlignment:
  //                                 MainAxisAlignment
  //                                     .spaceAround,
  //                                 children: [
  //                                   Column(
  //                                     crossAxisAlignment:
  //                                     CrossAxisAlignment
  //                                         .center,
  //                                     mainAxisAlignment:
  //                                     MainAxisAlignment
  //                                         .center,
  //                                     children: [
  //                                       IconButton(
  //                                         icon: Icon(
  //                                           Icons
  //                                               .camera_alt_outlined,
  //                                           size: 35,
  //                                         ),
  //                                         onPressed:
  //                                             () async {
  //                                           final ImagePicker
  //                                           picker =
  //                                           ImagePicker();
  //                                           imgp = await picker
  //                                               .pickImage(
  //                                               source:
  //                                               ImageSource.camera);
  //                                         },
  //                                       ),
  //                                       Padding(
  //                                         padding:
  //                                         const EdgeInsets
  //                                             .all(
  //                                             8.0),
  //                                         child: Text(
  //                                           "Camera",
  //                                           style: TextStyle(
  //                                               fontSize:
  //                                               20),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                   Column(
  //                                     mainAxisAlignment:
  //                                     MainAxisAlignment
  //                                         .center,
  //                                     crossAxisAlignment:
  //                                     CrossAxisAlignment
  //                                         .center,
  //                                     children: [
  //                                       IconButton(
  //                                         icon: Icon(
  //                                           Icons.photo,
  //                                           size: 35,
  //                                         ),
  //                                         onPressed:
  //                                             () async {
  //                                           final ImagePicker
  //                                           picker =
  //                                           ImagePicker();
  //                                           imgp = await picker
  //                                               .pickImage(
  //                                               source:
  //                                               ImageSource.gallery);
  //                                         },
  //                                       ),
  //                                       Padding(
  //                                         padding:
  //                                         const EdgeInsets
  //                                             .all(
  //                                             8.0),
  //                                         child: Text(
  //                                           "Gallrey",
  //                                           style: TextStyle(
  //                                               fontSize:
  //                                               20),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   )
  //                                 ],
  //                               ),
  //                             ),
  //                           );
  //                         },
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                   width: 100,
  //                   child: TextField(
  //                     style: TextStyle(
  //                         color: Colors.black,
  //                         fontSize: 20),
  //                     decoration: InputDecoration(
  //                         hintText: "Enter your name..",
  //                         hintStyle: TextStyle(
  //                             color: Colors.grey),
  //                         border: InputBorder.none),
  //                     controller: pname,
  //                     readOnly: r,
  //                   )),
  //               SizedBox(
  //                   width: 100,
  //                   child: TextField(
  //                     style: TextStyle(
  //                         color: Colors.black,
  //                         fontSize: 18),
  //                     decoration: InputDecoration(
  //                         hintText: "Enter your Bio..",
  //                         hintStyle: TextStyle(
  //                             color: Colors.grey),
  //                         border: InputBorder.none),
  //                     controller: pBio,
  //                     readOnly: r,
  //                   )),
  //               Row(
  //                 mainAxisAlignment:
  //                 MainAxisAlignment.spaceAround,
  //                 children: [
  //                   TextButton(
  //                       onPressed: () {
  //                         forvaluesprovider.read(r);
  //                       },
  //                       child: Text(
  //                         "SAVE",
  //                         style: TextStyle(
  //                             color: themeNotifier.isLight
  //                                 ? Colors.white
  //                                 : Color(0xff4E378B)),
  //                       )),
  //                   TextButton(
  //                       onPressed: () {
  //                         pname.clear();
  //                         pBio.clear();
  //                       },
  //                       child: Text(
  //                         "CLEAR",
  //                         style: TextStyle(
  //                             color: themeNotifier.isLight
  //                                 ? Colors.white
  //                                 : Color(0xff4E378B)),
  //                       )),
  //                 ],
  //               )
  //             ],
  //           )
  //               : Container(),
  //           Padding(
  //             padding:
  //             const EdgeInsets.only(top: 20, bottom: 20),
  //             child: Divider(
  //               color: Colors.grey,
  //               height: 10,
  //             ),
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Container(
  //                 child: Row(
  //                   children: [
  //                     Icon(Icons.light_mode_outlined),
  //                     Padding(
  //                       padding:
  //                       const EdgeInsets.only(left: 30),
  //                       child: Column(
  //                         mainAxisAlignment:
  //                         MainAxisAlignment.start,
  //                         crossAxisAlignment:
  //                         CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             "Theme",
  //                             style: TextStyle(
  //                                 fontSize: 20,
  //                                 fontWeight: FontWeight.w700),
  //                           ),
  //                           Text(
  //                             "Change Theme",
  //                             style: TextStyle(
  //                                 fontSize: 16,
  //                                 fontWeight: FontWeight.w400),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Switch(
  //                 value: themeNotifier.isLight,
  //                 onChanged: (value) {
  //                   themeNotifier.setTheme(value);
  //                   themeNotifier.saveThemevalue(value);
  //                 },
  //               ),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   ),
  // )
  // ]),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  //   );
  // }

  Widget text(String name, IconData icon, TextEditingController t, dynamic k) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
              themeNotifier.currentTheme.focusColor, BlendMode.modulate),
          child: TextField(
            style: TextStyle(color: Colors.black),
            controller: t,
            keyboardType: k,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                size: 20,
                color: Colors.white,
              ),
              labelText: name,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  )),
            ),
          ),
        ),
      );
    });
  }
}
// body: CustomScrollView(
//   slivers: [
//     SliverAppBar(
//       backgroundColor:
//           themeNotifier.isDark ? Colors.black : Colors.white,
//       bottom: PreferredSize(
//         preferredSize: Size.fromHeight(0),
//         child: Column(
//           children: [
//             TabBar(
//
//                 controller: _tabController,
//                 unselectedLabelColor: themeNotifier.isDark
//                     ? Colors.white
//                     : Colors.black,
//                 labelColor: themeNotifier.isDark
//                     ? Color(0xff786E92)
//                     : Color(0xff786E92),
//                 indicatorColor: themeNotifier.isDark
//                     ? Color(0xff786E92)
//                     : Color(0xff786E92),
//                 tabs: [
//                   Tab(
//                     icon: Icon(
//                       Icons.person_add_alt,
//                     ),
//                   ),
//                   Tab(
//                     text: 'CHATS',
//                   ),
//                   Tab(
//                     text: 'CALLS',
//                   ),
//                   Tab(
//                     text: 'SETTINGS',
//                   ),
//                 ]),
//             SizedBox(
//               height: 700,
//               child:
//                   TabBarView(controller: _tabController, children: [
//                 Scaffold(
//                   body: Column(
//                     children: [],
//                   ),
//                 ), Scaffold(
//                   body: Column(
//                     children: [],
//                   ),
//                 ),
//                 Scaffold(
//                   body: Column(
//                     children: [],
//                   ),
//                 ),
//                 Scaffold(
//                   body: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             left: 20, right: 20, top: 20),
//                         child: Row(
//                           mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                                 child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.light_mode_outlined,
//                                 ),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.only(left: 10),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Theme',
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                           color: themeNotifier.isDark
//                                               ? Colors.white
//                                               : Colors.black,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       Text(
//                                         'Change Theme',
//                                         style: TextStyle(
//                                           fontSize: 10,
//                                           color: themeNotifier.isDark
//                                               ? Colors.white
//                                               : Colors.black,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             )),
//                             Switch(
//                               value: themeNotifier.isDark,
//                               activeColor: themeNotifier.isDark
//                                   ? Colors.white
//                                   : Colors.black,
//                               onChanged: (val) {
//                                 if (themeNotifier.isDark) {
//                                   themeNotifier.isDark = false;
//                                 } else {
//                                   themeNotifier.isDark = true;
//                                 }
//                               },
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ]),
//             )
//           ],
//         ),
//       ),
//     )
//   ],
// ),
