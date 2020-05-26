import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utility/constants.dart';
import 'package:flutter_app/utility/strings.dart';

typedef onSaveForm = void Function(String);
typedef onValidateForm = String Function(String);

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Map<String, dynamic> formData = <String, dynamic>{
    Constants.ARG_FIRST_NAME: null,
    Constants.ARG_LAST_NAME: null,
    Constants.ARG_POLICY_NUMBER: null,
    Constants.ARG_ZIP_CODE: null,
    Constants.ARG_EMAIL: null,
    Constants.ARG_DOB: null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(Strings.REGISTER_USER),
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _getPolicyNumberField(
                    (String value) {
                      formData[Constants.ARG_POLICY_NUMBER] = value;
                    },
                  ),
                  _getFormInputField(
                    Strings.FIRST_NAME,
                    (String value) {
                      formData[Constants.ARG_FIRST_NAME] = value;
                    },
                    (String value) {
                      return value.isEmpty ? Strings.ERR_FIRST_NAME : null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: _getFormInputField(
                      Strings.LAST_NAME,
                      (String value) {
                        formData[Constants.ARG_LAST_NAME] = value;
                      },
                      (String value) {
                        return value.isEmpty ? Strings.ERR_LAST_NAME : null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: _getFormInputField(
                      Strings.ZIP_CODE,
                      (String value) {
                        formData[Constants.ARG_ZIP_CODE] = value;
                      },
                      (String value) {
                        return value.isEmpty ? Strings.ERR_ZIP : null;
                      },
                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: _getFormInputField(
                      Strings.EMAIL,
                      (String value) {
                        formData[Constants.ARG_EMAIL] = value;
                      },
                      (String value) {
                        if (value.isEmpty) {
                          return Strings.EMPTY_EMAIL;
                        } else {
                          if (!EmailValidator.validate(value)) {
                            return Strings.ERR_EMAIL;
                          }
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  _getDateOfBirthField(),
                  RaisedButton(
                    child: Text(Strings.REGISTER),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }

  String _getDOB() {
    final dynamic dateOfBirth = formData[Constants.ARG_DOB];
    if (dateOfBirth == null) {
      return Strings.DOB;
    } else {
      return '${dateOfBirth.toLocal()}'.split(' ')[0];
    }
  }

  DateTime _getDate() {
    final dynamic dateOfBirth = formData[Constants.ARG_DOB];
    if (dateOfBirth == null) {
      return DateTime.now();
    } else if (dateOfBirth is DateTime) {
      return dateOfBirth;
    } else {
      return DateTime.now();
    }
  }

  TextFormField _getFormInputField(
      String label, onSaveForm onSaved, onValidateForm onValidate,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
      ),
      keyboardType: keyboardType,
      onSaved: onSaved,
      validator: onValidate,
    );
  }

  Widget _getPolicyNumberField(onSaveForm onSaved) {
    return TextFormField(
        decoration: InputDecoration(
          labelText: Strings.POLICY_NUMBER,
        ),
        maxLength: 15,
        maxLengthEnforced: true,
        keyboardType: TextInputType.number,
        onSaved: onSaved,
        validator: (String value) {
          if (value.isEmpty) {
            return Strings.EMPTY_POLICY_NUMBER;
          } else {
            if (value.length < 10) {
              return Strings.ERR_POLICY_NUMBER;
            }
            return null;
          }
        });
  }

  Widget _getDateOfBirthField() {
    return FormField<dynamic>(
      builder: (FormFieldState<dynamic> state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(_getDOB()),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    final DateTime picked = await showDatePicker(
                        context: context,
                        initialDate: _getDate(),
                        firstDate: DateTime(1800),
                        lastDate: DateTime.now());
                    setState(() {
                      if (picked != null &&
                          picked != formData[Constants.ARG_DOB])
                        formData[Constants.ARG_DOB] = picked;
                    });
                  },
                )
              ],
            ),
            Row(children: <Widget>[
              Text(
                state.errorText ?? '',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                  fontSize: 12,
                ),
              ),
            ]),
          ]),
        );
      },
      validator: (dynamic value) {
        if (formData[Constants.ARG_DOB] == null) {
          return Strings.ERR_DOB;
        } else {
          return null;
        }
      },
    );
  }
}
