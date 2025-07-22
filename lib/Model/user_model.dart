class MyUser {
  static const String collectionUser = 'user';

  String? id;
  String? name;
  String? email;

  MyUser({
    required this.id,
    required this.name,
    required this.email,
  });

  MyUser.fromFireStore(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    email = data['email'];
  }

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
