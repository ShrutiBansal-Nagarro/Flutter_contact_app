import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:shruticontactapp/bloc/bloc_provider.dart';
import 'package:shruticontactapp/model/contact_model.dart';

class UpdateContactScreen extends StatefulWidget {
  static const routeName = "UpdateContactScreen";

  @override
  State<StatefulWidget> createState() {
    return UpdateContactScreenState();
  }
}

class UpdateContactScreenState extends State<UpdateContactScreen> {
  final _firstNameFocusNode = FocusNode();
  final _lastnameFocusNode = FocusNode();
  final _mobileFocusNode = FocusNode();
  final _landineFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _isInit = true;
  ContactModel contactModelUpdate = ContactModel(contactModel: Contact());
  var _initValues = {
    'firstName': '',
    'lastName': '',
    'landline': '',
    'mobile': '',
  };

  @override
  void didChangeDependencies() {
    if (_isInit) {
      var contactId =
          ModalRoute.of(context).settings.arguments as String; // is the id!
      contactModelUpdate = BlocProvider.of(context).bloc.findById(contactId);
      _initValues = {
        'firstName': contactModelUpdate.contactModel.givenName,
        'lastName': contactModelUpdate.contactModel.familyName,
        'landline': contactModelUpdate.contactModel.phones.elementAt(1).value,
        'mobile': contactModelUpdate.contactModel.phones.elementAt(0).value,
      };

      _isInit = false;
      super.didChangeDependencies();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _landineFocusNode.dispose();
    _mobileFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _lastnameFocusNode.dispose();
  }

  void _updateContact() {
    _form.currentState.save();

    final bloc = BlocProvider.of(context).bloc;
    bloc.updateContact(
        contactModelUpdate.contactModel.identifier, contactModelUpdate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).bloc;
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            contactModelUpdate.isFavorite != null &&
                    contactModelUpdate.isFavorite
                ? Icons.favorite
                : Icons.favorite_border,
          ),
          onPressed: () {
            setState(() {
              bloc.toggleFavoriteStatus(
                  contactModelUpdate.contactModel.identifier);
            });
          },
        ),
        appBar: AppBar(
          title: Text('Update Contact'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _form,
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
                    TextFormField(
                      initialValue: _initValues['firstName'],
                      decoration: InputDecoration(labelText: 'First Name'),
                      textCapitalization: TextCapitalization.words,
                      focusNode: _firstNameFocusNode,
                      onSaved: (value) {
                        Contact contact = Contact(
                            givenName: value,
                            familyName:
                                contactModelUpdate.contactModel.familyName,
                            phones: [
                              Item(
                                  label: "mobile",
                                  value: contactModelUpdate.contactModel.phones
                                      .elementAt(0)
                                      .value),
                              Item(
                                  label: "home",
                                  value: contactModelUpdate.contactModel.phones
                                      .elementAt(1)
                                      .value)
                            ]);
                        contact.identifier =
                            contactModelUpdate.contactModel.identifier;
                        contactModelUpdate =
                            ContactModel(contactModel: contact);
                      },
                    ),
                    TextFormField(
                        initialValue: _initValues['lastName'],
                        decoration: InputDecoration(labelText: 'last Name'),
                        textCapitalization: TextCapitalization.words,
                        onSaved: (value) {
                          Contact contact = Contact(
                              givenName:
                                  contactModelUpdate.contactModel.givenName,
                              familyName: value,
                              phones: [
                                Item(
                                    label: "mobile",
                                    value: contactModelUpdate
                                        .contactModel.phones
                                        .elementAt(0)
                                        .value),
                                Item(
                                    label: "home",
                                    value: contactModelUpdate
                                        .contactModel.phones
                                        .elementAt(1)
                                        .value)
                              ]);
                          contact.identifier =
                              contactModelUpdate.contactModel.identifier;

                          contactModelUpdate =
                              ContactModel(contactModel: contact);
                        }),
                    TextFormField(
                        initialValue: _initValues['mobile'],
                        decoration: InputDecoration(labelText: 'Mobile'),
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          Contact contact = Contact(
                              givenName:
                                  contactModelUpdate.contactModel.givenName,
                              familyName:
                                  contactModelUpdate.contactModel.familyName,
                              phones: [
                                Item(label: "mobile", value: value),
                                Item(
                                    label: "home",
                                    value: contactModelUpdate
                                        .contactModel.phones
                                        .elementAt(1)
                                        .value)
                              ]);

                          contact.identifier =
                              contactModelUpdate.contactModel.identifier;
                          contactModelUpdate =
                              ContactModel(contactModel: contact);
                        }),
                    TextFormField(
                        initialValue: _initValues['landline'],
                        decoration: InputDecoration(
                          labelText: 'landline',
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          Contact contact = Contact(
                              givenName:
                                  contactModelUpdate.contactModel.givenName,
                              familyName:
                                  contactModelUpdate.contactModel.familyName,
                              phones: [
                                Item(
                                    label: "mobile",
                                    value: contactModelUpdate
                                        .contactModel.phones
                                        .elementAt(0)
                                        .value),
                                Item(label: "home", value: value)
                              ]);

                          contact.identifier =
                              contactModelUpdate.contactModel.identifier;
                          contactModelUpdate =
                              ContactModel(contactModel: contact);
                        }),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: RaisedButton(
                          child: Text('Update Contact'),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: _updateContact),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
