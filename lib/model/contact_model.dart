import 'package:contacts_service/contacts_service.dart';

class ContactModel {
  bool isFavorite;
  Contact contactModel;

  ContactModel({this.contactModel, this.isFavorite = false});

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
  }
}
