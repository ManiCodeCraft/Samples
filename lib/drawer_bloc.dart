import 'dart:async';

import 'package:flutter_app/bloc.dart';

class DrawerBloc implements Bloc {
  final StreamController<String> _controller = StreamController<String>.broadcast();

  Stream<String> get currentPageStream => _controller.stream;

  void updatePage(String selectedPage) {
    _controller.sink.add(selectedPage);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
