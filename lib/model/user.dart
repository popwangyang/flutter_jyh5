
class User{
  int id;
  String username;

  User({
    this.id,
    this.username
  });

  factory User.fromJson(dynamic json){
    return User(
        id: json['id'],
        username: json['username']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    return data;
  }

}
