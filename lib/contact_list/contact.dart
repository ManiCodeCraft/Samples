class Contact {
  Contact(this.id, this.name, this.email, this.gender, this.phone);

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        json['id'] as String,
        json['name'] as String,
        json['email'] as String,
        json['gender'] as String,
        Phone.fromJson(json['phone'] as Map<String, dynamic>));
  }

  final String id;
  final String name;
  final String email;
  final String gender;

  final Phone phone;
}

class Phone {
  Phone(this.mobile, this.home, this.office);

  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(
      json['mobile'] as String,
      json['home'] as String,
      json['office'] as String,
    );
  }

  final String mobile;
  final String home;
  final String office;
}
