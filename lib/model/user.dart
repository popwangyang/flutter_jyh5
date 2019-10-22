
class User{
  int id;
  String username;
  String password;
  bool autoLogin;

  User({
    this.id,
    this.username,
    this.password,
    this.autoLogin
  });

  factory User.fromJson(dynamic json){
    return User(
        id: json['id'],
        username: json['username'],
        password: json['password'],
        autoLogin: json['autoLogin']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['autoLogin'] = this.autoLogin;
    return data;
  }

}
