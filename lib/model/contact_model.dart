import 'package:contacts_service/contacts_service.dart';

class ContactModel {
  bool isFavorite;
  Contact contactModel;

  ContactModel({this.contactModel, this.isFavorite = false});

  Map<String, dynamic> toMap() {
    return {
      'isFavorite': isFavorite ? 1 : 0,
      'contactId': int.parse(contactModel.identifier),
      'firstName': contactModel.givenName,
      'lastName': contactModel.familyName,
      'mobile': contactModel.phones.elementAt(0).value,
      'landline': contactModel.phones.elementAt(1).value,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> json) => new ContactModel(
        contactModel: Contact(
            givenName: json["firstName"],
            familyName: json["lastName"],
            phones: [
              Item(label: "mobile", value: json["mobile"]),
              Item(label: "home", value: json["landline"])
            ]),
        isFavorite: json["isFavorite"] == 1 ? true : false,
      );
}
