import 'dart:async';

import 'package:contacts_service/contacts_service.dart';
import 'package:shruticontactapp/bloc/Bloc.dart';
import 'package:shruticontactapp/database.dart';
import 'package:shruticontactapp/model/contact_model.dart';

class ContactBloc implements Bloc {
  List<ContactModel> _contactList = [];
  final StreamController<List<ContactModel>> _getContactController =
      StreamController<List<ContactModel>>.broadcast();

  Stream<List<ContactModel>> get getContactItemStream =>
      _getContactController.stream;

  StreamSink<List<ContactModel>> get getContactItemSink =>
      _getContactController.sink;

  Stream<List<ContactModel>> get getFavItemStream =>
      _getContactController.stream;

  StreamSink<List<ContactModel>> get getFavItemSink =>
      _getContactController.sink;

  getContact() async {
    List<Contact> dummyContactList = [];
    _contactList.clear();
    Iterable<Contact> contacts = await ContactsService.getContacts(
        orderByGivenName: true, withThumbnails: false);
    dummyContactList = contacts.toList();
    for (int i = 0; i < dummyContactList.length; i++) {
      _contactList.add(ContactModel(contactModel: dummyContactList[i]));
      DBProvider.db
          .insertContact(ContactModel(contactModel: dummyContactList[i]));
    }
    getContactItemSink.add(_contactList);
  }

  addContact(ContactModel newContact) async {
    await ContactsService.addContact(newContact.contactModel);
    _contactList.add(newContact);
    getContactItemSink.add(_contactList);
  }

  updateContact(String id, ContactModel updatedContact) async {
    await ContactsService.updateContact(updatedContact.contactModel);
    int index = _contactList
        .indexWhere((element) => element.contactModel.identifier == id);
    _contactList[index] = updatedContact;
    getContactItemSink.add(_contactList);
  }

  favoriteContacts() async {
    await Future.delayed(Duration(seconds: 0));
    getFavItemSink.add(
        _contactList.where((contactItem) => contactItem.isFavorite).toList());
  }

  deleteContact(ContactModel deletedContact) async {
    await ContactsService.deleteContact(deletedContact.contactModel);
    DBProvider.db
        .deleteContact(int.parse(deletedContact.contactModel.identifier));
    _contactList.removeWhere((contact) => contact == deletedContact);
  }

  ContactModel findById(String id) {
    return _contactList
        .firstWhere((contact) => contact.contactModel.identifier == id);
  }

  toggleFavoriteStatus(String id) async {
    await Future.delayed(Duration(seconds: 0));
    ContactModel contactModel = _contactList
        .firstWhere((contact) => contact.contactModel.identifier == id);
    contactModel.isFavorite = !contactModel.isFavorite;
    getContactItemSink.add(_contactList);
  }

  @override
  void dispose() {
    _getContactController.close();
  }
}
