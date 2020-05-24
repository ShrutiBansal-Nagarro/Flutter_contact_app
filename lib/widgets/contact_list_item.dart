import 'package:flutter/material.dart';
import 'package:shruticontactapp/bloc/bloc_provider.dart';
import 'package:shruticontactapp/model/contact_model.dart';
import 'package:shruticontactapp/screens/update_contact_screen.dart';

class ContactListItem extends StatelessWidget {
  final ContactModel contact;

  ContactListItem(this.contact);

  Widget build(BuildContext context) {
    void _deleteContact(ContactModel contact) {
      final bloc = BlocProvider.of(context).bloc;
      bloc.deleteContact(contact);
    }

    void _updateContact(ContactModel contact) {
      Navigator.of(context).pushNamed(
        UpdateContactScreen.routeName,
        arguments: contact.contactModel.identifier,
      );
    }

    return Dismissible(
      key: ValueKey(contact),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _deleteContact(contact);
      },
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
            title: Text(contact.contactModel.givenName +
                " " +
                contact.contactModel.familyName),
            subtitle: contact.contactModel.phones != null &&
                    contact.contactModel.phones.isNotEmpty &&
                    contact.contactModel.phones.elementAt(0) != null
                ? Text(contact.contactModel.phones.elementAt(0).value)
                : Text("No phone number"),
            trailing: IconButton(
                onPressed: () => _updateContact(contact),
                icon: Icon(Icons.edit),
                color: Theme.of(context).errorColor),
          )),
    );
  }
}
