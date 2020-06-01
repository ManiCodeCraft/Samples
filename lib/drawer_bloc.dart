import 'dart:async';

import 'package:flutter_app/bloc.dart';
import 'package:flutter_app/user.dart';

class DrawerBloc implements Bloc {
  final StreamController<String> _controller =
      StreamController<String>.broadcast();
  String currentPage = 'Home';
  PolicyIdCard idCard;

  Stream<String> get currentPageStream => _controller.stream;

  void updatePage(String selectedPage) {
    _controller.sink.add(selectedPage);
  }

  void setIdCard(PolicyIdCard card) {
    idCard = card;
  }

  @override
  void dispose() {
    _controller.close();
  }
}
