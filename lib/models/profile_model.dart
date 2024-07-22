class Profile{
  String token;
  String name;
  String? phone;
  String? gender;
  String? birthday;

  Profile({
    required this.token,
    required this.name,
    this.phone,
    this.gender,
    this.birthday,
});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      token: json['token'],
      name: json['name'],
      phone: json['phone'],
      gender: json['gender'],
      birthday: json['birthday'],
    );
  }


  Map<String, dynamic> toJson() {
    var data = {
      'token': token,
      'name': name,
    };
    if (phone != null) {
      data['phone'] = phone as String;
    }
    if (gender != null) {
      data['gender'] = gender as String;
    }
    if (birthday != null) {
      data['birthday'] = birthday as String;
    }
    return data;
  }


}