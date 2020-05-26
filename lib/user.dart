
import 'dart:typed_data';

import 'package:flutter_app/utility/encryption_utility.dart';

class PolicyIdCard {

  PolicyIdCard(
      this.policyNumber,
      this.model,
      this.makeCompany,
      this.year,
      this.name,
      this.address,
      this.effectiveDate,
      this.expirationDate,
      this.vehicleId,
      this.naicNumber,
      this.logoString);

  final String policyNumber;
  final String model;
  final String makeCompany;
  final int year;
  final String name;
  final String address;
  final String effectiveDate;
  final String expirationDate;
  final String vehicleId;
  final String naicNumber;
  final String logoString;

  Map<String, Uint8List> toMap() {
    return <String, Uint8List>{
      'policyNumber': encrypt(policyNumber).bytes,
      'model': encrypt(model).bytes,
      'makeCompany': encrypt(makeCompany).bytes,
      'year': encrypt(year.toString()).bytes,
      'name': encrypt(name).bytes,
      'address': encrypt(address).bytes,
      'effectiveDate': encrypt(effectiveDate).bytes,
      'expirationDate': encrypt(expirationDate).bytes,
      'vehicleId': encrypt(vehicleId).bytes,
      'naicNumber': encrypt(naicNumber).bytes,
      'logoString': encrypt(logoString).bytes,
    };
  }
}
