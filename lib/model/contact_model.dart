import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';

class ContactModel with ChangeNotifier {
  bool isFavorite;
  Contact contactModel;

  ContactModel({this.contactModel, this.isFavorite=false});

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
