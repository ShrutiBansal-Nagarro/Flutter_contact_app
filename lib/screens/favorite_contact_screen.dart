import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shruticontactapp/model/contact_list_model.dart';
import 'package:shruticontactapp/widgets/contact_app_Drawer.dart';
import 'package:shruticontactapp/widgets/favorite_list_item.dart';

class FavoriteContactScreen extends StatelessWidget {
  static const routeName = "FavoriteContactScreen";

  @override
  Widget build(BuildContext context) {
    Provider.of<ContactListModel>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite List'),
      ),
      drawer: ContactAppDrawer(),
      body: Consumer<ContactListModel>(
        builder: (_, contact, __) => contact.favoriteItems.length > 0
            ? ListView.builder(
                itemBuilder: (ctx, index) {
                  return FavoriteListItem(contact.favoriteItems[index]);
                },
                itemCount: contact.favoriteItems.length,
              )
            : Center(child: Text("No Contact found")),
      ),
    );
  }
}
