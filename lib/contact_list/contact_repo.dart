import 'dart:async';
import 'dart:convert';

import 'package:flutter_app/bloc.dart';
import 'package:flutter_app/contact_list/contact.dart';
import 'package:flutter_app/utility/strings.dart';
import 'package:http/http.dart';

class ContactRepo implements Bloc {
  //broadcast streams can be listened by multiple listeners
  List<Contact> _list = <Contact>[];
  final StreamController<List<Contact>> _controller =
      StreamController<List<Contact>>.broadcast();

  Stream<List<Contact>> get contactStream => _controller.stream;

  Future<List<Contact>> fetchContact() async {
    final Response response =
        await get('https://api.androidhive.info/contacts/');
    if (response.statusCode == 200) {
      List<Contact> data = _getListFromJson(response.body);
      _list = data;
      print(data.length);
      _controller.sink.add(data);
      return data;
    } else {
      throw Exception(Strings.NO_DATA_PRESENT);
    }
  }

  List<Contact> _getListFromJson(String body) {
    final List<Contact> list = <Contact>[];
    final Map<String, dynamic> decodeMap =
        jsonDecode(body) as Map<String, dynamic>;
    final List<dynamic> jsonList = decodeMap['contacts'] as List<dynamic>;
    for (final dynamic value in jsonList) {
      list.add(Contact.fromJson(value as Map<String, dynamic>));
    }
    return list;
  }

  void updateContact(Contact contact) {
    final Contact matchedData = _list.firstWhere(
        (Contact element) => element.id == contact.id,
        orElse: () => null);
    if (matchedData != null) {
      final int index = _list.indexOf(matchedData);
      _list.remove(matchedData);
      _list.insert(index, contact);
      _controller.sink.add(_list);
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
