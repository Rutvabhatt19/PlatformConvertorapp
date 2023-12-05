import 'package:flutter/material.dart';
import 'package:platform_converter/Contactmodal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactList extends ChangeNotifier {
  List<MainContact> contacts = [];

  Future<List> loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsData = prefs.getStringList('contacts');

    if (contactsData != null) {
      contacts = contactsData.map((data) {
        final parts = data.split(',');
        return MainContact(parts[0], parts[1], parts[2], parts[3], parts[4]);
      }).toList();
      notifyListeners();
    }
    return contacts;
  }

  void addContact(MainContact newContact) {
    contacts.add(newContact);
    saveContacts();
    notifyListeners();
  }

  void updateContact(int index, MainContact updatedContact) {
    contacts[index] = updatedContact;
    saveContacts();
    notifyListeners();
  }

  void deleteContact(int index) {
    contacts.removeAt(index);
    saveContacts();
    notifyListeners();
  }

  void saveContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsData = contacts.map((contact) {
      return '${contact.fullname},${contact.phoneNumber},${contact.chat},${contact.date},${contact.time}';
    }).toList();
    prefs.setStringList('contacts', contactsData);
  }
}
