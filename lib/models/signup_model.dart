class SignUpBody {
  String username;
  String password;
  String firstName;
  String lastName;
  ActivityStatus userActivity;

  SignUpBody(
      {required this.username,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.userActivity});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    return data;
  }
}

enum ActivityStatus { ONLINE, AWAY, DO_NOT_DISTURB, OFFLINE }
