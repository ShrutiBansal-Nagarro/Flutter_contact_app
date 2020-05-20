import 'package:flutter/material.dart';
import 'package:shruticontactapp/model/contact_model.dart';

class FavoriteListItem extends StatelessWidget {
  final ContactModel contact;

  FavoriteListItem(this.contact);

  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
              leading: (contact.contactModel.avatar != null &&
                      contact.contactModel.avatar.isNotEmpty)
                  ? CircleAvatar(
                      radius: 30,
                      backgroundImage: MemoryImage(contact.contactModel.avatar),
                    )
                  : CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(contact.contactModel.initials()),
                        ),
                      ),
                    ),
              title: Text(contact.contactModel.displayName ?? ''),
              subtitle: contact.contactModel.phones != null &&
                      contact.contactModel.phones.isNotEmpty &&
                      contact.contactModel.phones.elementAt(0) != null
                  ? Text(contact.contactModel.phones.elementAt(0).value)
                  : Text("No phone number"),
            )));
  }
}
