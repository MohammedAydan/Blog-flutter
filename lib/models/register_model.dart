import 'package:image_picker/image_picker.dart';

class Register {
  final String? name;
  final String? username;
  final String? email;
  final String? phone;
  final String? age;
  final XFile? img;
  final String? password;
  final String? confirmPassword;

  Register({
    this.name,
    this.username,
    this.email,
    this.phone,
    this.age,
    this.img,
    this.password,
    this.confirmPassword,
  });

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      age: json['age'],
      img: json['img_url'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'age': age,
      'img_url': img,
      'password': password,
    };
  }
}
