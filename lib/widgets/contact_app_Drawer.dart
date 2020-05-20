import 'package:flutter/material.dart';
import 'package:shruticontactapp/screens/favorite_contact_screen.dart';

class ContactAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('App Drawer'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.contacts),
            title: Text('Contact List'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorite contacts'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(FavoriteContactScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
