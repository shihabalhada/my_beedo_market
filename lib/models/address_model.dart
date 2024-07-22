class Address {
  int? id;
  String token;
  String firstname;
  String lastname;
  String phone;
  String country;
  String city;
  String address;
  String neighborhood;

  Address({
    this.id,
    required this.token,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.country,
    required this.city,
    required this.address,
    required this.neighborhood,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      token: json['token'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      phone: json['phone'],
      country: json['country'],
      city: json['city'],
      address: json['address'],
      neighborhood: json['neighborhood'],
    );
  }

  Map<String, dynamic> toJson() {
    var data = {
      'token': token,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'country': country,
      'city': city,
      'address': address,
      'neighborhood': neighborhood,
    };
    if (id != null) {
      data['id'] = id as String;
    }
    return data;
  }
}
