import 'package:flutter/material.dart';
import 'package:flutter_app/contact_list/contact.dart';
import 'package:flutter_app/contact_list/contact_repo.dart';
import 'package:flutter_app/utility/strings.dart';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  Future<List<Contact>> contactList;

  @override
  void initState() {
    super.initState();
    contactList = ContactRepo().fetchContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Strings.CONTACTS)),
      body: FutureBuilder<List<Contact>>(
          future: contactList,
          builder:
              (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _getListItem(snapshot.data[index]);
                  });
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('No data present'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget _getListItem(Contact contact) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(contact.name),
          subtitle: Text(contact.phone.mobile),
        ),
        Container(
          height: 1,
          margin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          color: Colors.black26,
        )
      ],
    );
  }
}
