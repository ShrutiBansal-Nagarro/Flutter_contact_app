import 'package:flutter/material.dart';
import 'package:shruticontactapp/bloc/bloc_provider.dart';
import 'package:shruticontactapp/model/contact_model.dart';
import 'package:shruticontactapp/screens/add_new_contact_screen.dart';
import 'package:shruticontactapp/widgets/contact_app_Drawer.dart';
import 'package:shruticontactapp/widgets/contact_list_item.dart';

class ContactListScreen extends StatelessWidget {
  static const routeName = "ContactListScreen";

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).bloc;
    bloc.getContact();

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
        body: StreamBuilder<List<ContactModel>>(
            stream: bloc.getContactItemStream,
            builder: (context, AsyncSnapshot<List<ContactModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text("Loading"));
              }
              if (snapshot.hasData && snapshot.data.length > 0) {
                return ListView.builder(
                  itemBuilder: (ctx, index) =>
                      ContactListItem(snapshot.data[index]),
                  itemCount: snapshot.data.length,
                );
              }
              return Center(child: Text("No Contact found"));
            }));
  }
}
