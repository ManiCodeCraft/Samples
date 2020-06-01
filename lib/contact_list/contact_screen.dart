import 'package:flutter/material.dart';
import 'package:flutter_app/bloc_provider.dart';
import 'package:flutter_app/contact_list/contact.dart';
import 'package:flutter_app/contact_list/contact_detail_screen.dart';
import 'package:flutter_app/contact_list/contact_repo.dart';

class ContactListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ContactRepo bloc = BlocProvider.of<ContactRepo>(context);
    bloc.fetchContact();
    return StreamBuilder<List<Contact>>(
      stream: bloc.contactStream,
      builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return _getListItem(snapshot.data[index], context);
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
      },
    );
  }

  Widget _getListItem(Contact contact, BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        color: _getColor(contact.gender, false),
        child: ListTile(
          title: Text(
            contact.name,
            style: TextStyle(color: _getColor(contact.gender, true)),
          ),
          subtitle: Text(
            contact.phone.mobile,
            style: TextStyle(color: _getColor(contact.gender, true)),
          ),
          onTap: () {
            Navigator.of(context).push<void>(MaterialPageRoute<void>(
                builder: (BuildContext context) => ContactDetail(
                      contact: contact,
                    )));
          },
        ),
      ),
    );
  }

  Color _getColor(String gender, bool isTextColor) {
    return gender == 'male'
        ? (isTextColor ? Colors.black : Colors.white)
        : (isTextColor ? Colors.white : Colors.black);
  }
}

/*class ContactList extends StatefulWidget {
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
    return Card(
      elevation: 4,
      child: Container(
        color: _getColor(contact.gender, false),
        child: ListTile(
          title: Text(
            contact.name,
            style: TextStyle(color: _getColor(contact.gender, true)),
          ),
          subtitle: Text(
            contact.phone.mobile,
            style: TextStyle(color: _getColor(contact.gender, true)),
          ),
        ),
      ),
    );
  }

  Color _getColor(String gender, bool isTextColor) {
    return gender == 'male'
        ? (isTextColor ? Colors.black : Colors.white)
        : (isTextColor ? Colors.white : Colors.black);
  }
}*/
