import 'package:flutter/material.dart';
import 'package:flutter_app/bloc_provider.dart';
import 'package:flutter_app/contact_list/contact.dart';
import 'package:flutter_app/contact_list/contact_repo.dart';
import 'package:flutter_app/utility/strings.dart';

class ContactDetail extends StatefulWidget {
  ContactDetail({@required this.contact});

  final Contact contact;

  @override
  _ContactDetailState createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  ContactRepo _bloc;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.contact.name;
    _mobileController.text = widget.contact.phone.mobile;
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<ContactRepo>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.CONTACT_DETAIL),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text('name  '),
              Expanded(
                child: TextField(
                  controller: _nameController,
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              const Text('mobile  '),
              Expanded(
                child: TextField(
                  controller: _mobileController,
                ),
              )
            ],
          ),
          Text('email  :  ${widget.contact.email}'),
          Text('gender  :  ${widget.contact.gender}'),
          Text('office number  :  ${widget.contact.phone.office}'),
          Text('home number  :  ${widget.contact.phone.home}'),
          RaisedButton(
            child: const Text('Update'),
            onPressed: () {
              widget.contact.name = _nameController.text;
              widget.contact.phone.mobile = _mobileController.text;
              _bloc.updateContact(widget.contact);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
