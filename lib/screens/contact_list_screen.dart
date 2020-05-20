import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shruticontactapp/model/contact_list_model.dart';
import 'package:shruticontactapp/screens/add_new_contact_screen.dart';
import 'package:shruticontactapp/widgets/contact_app_Drawer.dart';
import 'package:shruticontactapp/widgets/contact_list_item.dart';

class ContactListScreen extends StatelessWidget {
  static const routeName = "ContactListScreen";

  @override
  Widget build(BuildContext context) {
    Provider.of<ContactListModel>(
      context,
      listen: false,
    ).getContact();

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      drawer: ContactAppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(
            AddNewContactScreen.routeName,
          );
        },
      ),
      body: Consumer<ContactListModel>(
        builder: (_, contact, __) =>
        contact.contactListGetter.length > 0
            ? ListView.builder(
                itemBuilder: (ctx, index) {
                  return ContactListItem(contact.contactListGetter[index]);
                },
                itemCount: contact.contactListGetter.length,
              )
            : Center(child: Text("No Contact found")),
      ),
    );
  }
}
