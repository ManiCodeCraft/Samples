import 'dart:convert';

import 'package:flutter_app/contact_list/contact.dart';
import 'package:flutter_app/utility/strings.dart';
import 'package:http/http.dart';

class ContactRepo {

  Future<List<Contact>> fetchContact() async {
    final Response response =
        await get('https://api.androidhive.info/contacts/');
    if (response.statusCode == 200) {
      return _getListFromJson(response.body);
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
}
