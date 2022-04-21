class User {
  String? username;
  String? password;
  String? firstName;
  String? lastName;
  int? userActivity;

  User(
      {this.username,
      this.password,
      this.firstName,
      this.lastName,
      this.userActivity});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userActivity = json['userActivity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userActivity'] = this.userActivity;
    return data;
  }
}
