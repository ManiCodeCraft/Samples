import 'package:flutter/material.dart';
import 'package:flutter_app/bloc.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  const BlocProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  final Widget child;
  final T bloc;

  static T of<T extends Bloc>(BuildContext context) {
    final BlocProvider<T> provider =
        context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    return provider.bloc;
  }

  @override
  _BlocProviderState createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
