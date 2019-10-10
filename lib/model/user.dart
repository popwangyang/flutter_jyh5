
class User{
  String token;
  int id;

  User({
    this.id,
    this.token,
  });

  factory User.fromJson(dynamic json){
    return User(
        id: json['user']['id'],
        token: json['token'],
    );
  }

}
