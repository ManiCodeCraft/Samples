import 'package:flutter_app/utility/encryption_utility.dart';

class User {
  final int id;
  final String name;
  final int age;

  User(this.id, this.name, this.age);

  Map<String, dynamic> toMap() {
    return {
      'id': EncrypterUtility.encrypt(this.id.toString()).bytes,
      'name': EncrypterUtility.encrypt(this.name).bytes,
      'age': EncrypterUtility.encrypt(this.age.toString()).bytes,
    };
  }
}

class PolicyIdCard {
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

  Map<String, dynamic> toMap() {
    return {
      'policyNumber': EncrypterUtility.encrypt(this.policyNumber).bytes,
      'model': EncrypterUtility.encrypt(this.model).bytes,
      'makeCompany': EncrypterUtility.encrypt(this.makeCompany).bytes,
      'year': EncrypterUtility.encrypt(this.year.toString()).bytes,
      'name': EncrypterUtility.encrypt(this.name).bytes,
      'address': EncrypterUtility.encrypt(this.address).bytes,
      'effectiveDate': EncrypterUtility.encrypt(this.effectiveDate).bytes,
      'expirationDate': EncrypterUtility.encrypt(this.expirationDate).bytes,
      'vehicleId': EncrypterUtility.encrypt(this.vehicleId).bytes,
      'naicNumber': EncrypterUtility.encrypt(this.naicNumber).bytes,
      'logoString': EncrypterUtility.encrypt(this.logoString).bytes,
    };
  }
}
