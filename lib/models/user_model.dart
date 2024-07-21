class User {
  String username;
  String email;
  String password;
  String passwordConfirmation;

  User({
    required this.username,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': username,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }
}
