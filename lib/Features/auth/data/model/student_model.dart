import 'dart:convert';

class UserModel {
  final int userId;
  final String username;
  final String email;
  final String phone;
  final String password;
  final String createAt;
  final int userApprove;
  final int studentCode;
  final String name;
  final String image;
  final int majorId;
  final int bandId;
  final String bandName;
  final int id;
  final String majorName;
  final String approveName;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
    required this.createAt,
    required this.userApprove,
    required this.studentCode,
    required this.name,
    required this.image,
    required this.majorId,
    required this.bandId,
    required this.bandName,
    required this.id,
    required this.majorName,
    required this.approveName,
  });

  // تحويل من JSON إلى Object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["user_id"] ?? 0,
      username: json["username"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      password: json["password"] ?? "",
      createAt: json["createAt"] ?? "",
      userApprove: json["user_approve"] ?? 0,
      studentCode: json["student_code"] ?? 0,
      name: json["name"] ?? "",
      image: json["image"] ?? "",
      majorId: json["major_id"] ?? 0,
      bandId: json["band_id"] ?? 0,
      bandName: json["band_name"] ?? "",
      id: json["id"] ?? 0,
      majorName: json["major_name"] ?? "",
      approveName: json["approve_name"] ?? "",
    );
  }

  // تحويل من Object إلى JSON
  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "username": username,
      "email": email,
      "phone": phone,
      "password": password,
      "createAt": createAt,
      "user_approve": userApprove,
      "student_code": studentCode,
      "name": name,
      "image": image,
      "major_id": majorId,
      "band_id": bandId,
      "band_name": bandName,
      "id": id,
      "major_name": majorName,
      "approve_name": approveName,
    };
  }
}
