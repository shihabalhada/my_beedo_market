class Profile{
  String name;
  String? token;
  String? email;
  String? phone;
  String? gender;
  String? birthday;

  Profile({
    this.email,
    this.token,
    required this.name,
    this.phone,
    this.gender,
    this.birthday,
});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      // token: json['token'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      birthday: json['birthday'],
    );
  }


  Map<String, dynamic> toJson() {
    var data = {
      'token':token,
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
    if(email != null){
      data['email'] = email as String;
    }
    return data;
  }


}