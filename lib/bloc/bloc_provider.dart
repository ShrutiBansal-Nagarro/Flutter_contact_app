import 'package:flutter/material.dart';
import 'package:shruticontactapp/bloc/contact_bloc.dart';

class BlocProvider extends InheritedWidget {
  final ContactBloc bloc;
  final Widget child;

  BlocProvider({this.bloc, this.child}) : super(child: child);

  static BlocProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: BlocProvider);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
