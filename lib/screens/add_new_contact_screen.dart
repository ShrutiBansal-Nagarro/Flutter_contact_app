import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:shruticontactapp/bloc/bloc_provider.dart';
import 'package:shruticontactapp/model/contact_model.dart';

class AddNewContactScreen extends StatelessWidget {
  static const routeName = "AddNewContactScreen";

  final _firstNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _landlineController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void addNewContact() {
      if (_mobileController.text.isEmpty ||
          _firstNameController.text.isEmpty ||
          _lastNameController.text.isEmpty ||
          _mobileController.text.length < 10 ||
          _landlineController.text.length < 10) {
        return;
      }
      Contact contact = Contact(
          givenName: _firstNameController.text,
          familyName: _lastNameController.text,
          displayName:
              _firstNameController.text + " " + _lastNameController.text,
          phones: [
            Item(label: "mobile", value: _mobileController.text),
            Item(label: "home", value: _landlineController.text)
          ]);

      final bloc = BlocProvider.of(context).bloc;
      bloc.addContact(ContactModel(contactModel: contact));
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Contact'),
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
                  controller: _firstNameController,
                  onSubmitted: (_) => addNewContact(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'last Name'),
                  controller: _lastNameController,
                  onSubmitted: (_) => addNewContact(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Mobile'),
                  controller: _mobileController,
                  onSubmitted: (_) => addNewContact(),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'landline'),
                  controller: _landlineController,
                  onSubmitted: (_) => addNewContact(),
                  keyboardType: TextInputType.number,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: RaisedButton(
                      child: Text('Add Contact'),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () => addNewContact()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
