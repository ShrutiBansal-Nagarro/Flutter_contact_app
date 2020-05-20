import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shruticontactapp/model/contact_list_model.dart';
import 'package:shruticontactapp/model/contact_model.dart';

class UpdateContactScreen extends StatefulWidget {
  static const routeName = "UpdateContactScreen";

  @override
  State<StatefulWidget> createState() {
    return UpdateContactScreenState();
  }
}

class UpdateContactScreenState extends State<UpdateContactScreen> {
  final _firstNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _landlineController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var contact =
        ModalRoute.of(context).settings.arguments as ContactModel; // is the id!

    _firstNameController..text = contact.contactModel.givenName;
    _lastNameController..text = contact.contactModel.familyName;
    _mobileController..text = contact.contactModel.phones.elementAt(0).value;
    _landlineController..text = contact.contactModel.phones.elementAt(1).value;

    void _updateContact() {
      if (_mobileController.text.isEmpty ||
          _firstNameController.text.isEmpty ||
          _lastNameController.text.isEmpty ||
          _mobileController.text.length < 10 ||
          _landlineController.text.length < 10) {
        return;
      }
      contact.contactModel.givenName = _firstNameController.text;
      contact.contactModel.displayName =
          _firstNameController.text + " " + _lastNameController.text;
      contact.contactModel.familyName = _lastNameController.text;
      contact.contactModel.phones.elementAt(0).value = _mobileController.text;
      contact.contactModel.phones.elementAt(1).value = _landlineController.text;

      Provider.of<ContactListModel>(context, listen: false)
          .updateContact(contact);
      Navigator.of(context).pop();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          contact.isFavorite != null && contact.isFavorite
              ? Icons.favorite
              : Icons.favorite_border,
        ),
        onPressed: () {
          setState(() {
            contact.toggleFavoriteStatus();
          });
        },
      ),
      appBar: AppBar(
        title: Text('Update Contact'),
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'First Name'),
                  textCapitalization: TextCapitalization.words,
                  controller: _firstNameController,
                  onSubmitted: (_) => _,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'last Name'),
                  textCapitalization: TextCapitalization.words,
                  controller: _lastNameController,
                  onSubmitted: (_) => _updateContact(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Mobile'),
                  controller: _mobileController,
                  onSubmitted: (_) => _updateContact(),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'landline',
                  ),
                  controller: _landlineController,
                  onSubmitted: (_) => _updateContact(),
                  keyboardType: TextInputType.number,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: RaisedButton(
                      child: Text('Update Contact'),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () => _updateContact()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
