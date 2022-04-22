class User {
  String? username;
  String? password;
  String? firstName;
  String? lastName;
  int? userActivity;
  String? profilePictureUri;
  int? permissionLevel;

  User(
      {this.username,
      this.password,
      this.firstName,
      this.lastName,
      this.userActivity,
      this.profilePictureUri,
      this.permissionLevel});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userActivity = json['userActivity'];
    profilePictureUri = json['profilePictureUri'];
    permissionLevel = json['permissionLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userActivity'] = this.userActivity;
    data['profilePictureUri'] = this.profilePictureUri;
    data['permissionLevel'] = this.permissionLevel;
    return data;
  }
}

enum ActivityStatus { ONLINE, AWAY, DO_NOT_DISTURB, OFFLINE }
