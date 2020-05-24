import 'package:flutter/material.dart';
import 'package:shruticontactapp/bloc/bloc_provider.dart';
import 'package:shruticontactapp/model/contact_model.dart';
import 'package:shruticontactapp/widgets/contact_app_Drawer.dart';
import 'package:shruticontactapp/widgets/favorite_list_item.dart';

class FavoriteContactScreen extends StatelessWidget {
  static const routeName = "FavoriteContactScreen";

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).bloc;
    bloc.favoriteContacts();

    return Scaffold(
        appBar: AppBar(
          title: Text('Favorite List'),
        ),
        drawer: ContactAppDrawer(),
        body: StreamBuilder<List<ContactModel>>(
            stream: bloc.getFavItemStream,
            builder: (context, AsyncSnapshot<List<ContactModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text("Loading"));
              }
              if (snapshot.hasData && snapshot.data.length > 0) {
                return ListView.builder(
                  itemBuilder: (ctx, index) =>
                      FavoriteListItem(snapshot.data[index]),
                  itemCount: snapshot.data.length,
                );
              }
              return Center(child: Text("No Contact found"));
            }));
  }
}
