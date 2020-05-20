import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import 'contact_model.dart';

class ContactListModel extends ChangeNotifier {
  List<ContactModel> _contactList = [];
  List<Contact> dummyContactList = [];

  List<ContactModel> get contactListGetter {
    return _contactList;
  }

  getContact() async {
    _contactList.clear();
    dummyContactList.clear();
    Iterable<Contact> contacts = await ContactsService.getContacts(
        orderByGivenName: true, withThumbnails: false);
    dummyContactList = contacts.toList();
    for (int i = 0; i < dummyContactList.length; i++) {
      _contactList.add(ContactModel(contactModel: dummyContactList[i]));
    }
    notifyListeners();
  }

  deleteContact(ContactModel deletedContact) async {
    await ContactsService.deleteContact(deletedContact.contactModel);
    _contactList.removeWhere((contact) => contact == deletedContact);

    notifyListeners();
  }

  addContact(ContactModel newContact) async {
    await ContactsService.addContact(newContact.contactModel);
    _contactList.add(newContact);
    notifyListeners();
  }

  updateContact(ContactModel updatedContact) async {
    await ContactsService.updateContact(updatedContact.contactModel);
    int index = _contactList.indexWhere((element) =>
        element.contactModel.identifier ==
        updatedContact.contactModel.identifier);
    _contactList[index] = updatedContact;
    notifyListeners();
  }

  List<ContactModel> get favoriteItems {
    List<ContactModel> favList = [];
    favList = _contactList.where((prodItem) => prodItem.isFavorite).toList();
    notifyListeners();
    return favList;
  }
}
