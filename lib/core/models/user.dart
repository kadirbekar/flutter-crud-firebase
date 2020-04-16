class User {
  String id;
  String name;
  String password;
  String mail;
  String image;

  User({this.id, this.name, this.password, this.mail, this.image});

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        password = map['password'],
        mail = map['mail'],
        image = map['image'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'mail': mail,
      'image': image,
    };
  }
}
