class UserModel {
  int? userId;
  String? username;
  String? email;
  String? phone;
  String? password;
  String? createAt;
  int? userApprove;
  int? studentCode;
  String? name;
  String? image;
  int? majorId;
  int? bandId;
  String? bandName;
  int? id;
  String? majorName;
  String? approveName;

  UserModel(
      {this.userId,
      this.username,
      this.email,
      this.phone,
      this.password,
      this.createAt,
      this.userApprove,
      this.studentCode,
      this.name,
      this.image,
      this.majorId,
      this.bandId,
      this.bandName,
      this.id,
      this.majorName,
      this.approveName});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    createAt = json['createAt'];
    userApprove = json['user_approve'];
    studentCode = json['student_code'];
    name = json['name'];
    image = json['image'];
    majorId = json['major_id'];
    bandId = json['band_id'];
    bandName = json['band_name'];
    id = json['id'];
    majorName = json['major_name'];
    approveName = json['approve_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['createAt'] = createAt;
    data['user_approve'] = userApprove;
    data['student_code'] = studentCode;
    data['name'] = name;
    data['image'] = image;
    data['major_id'] = majorId;
    data['band_id'] = bandId;
    data['band_name'] = bandName;
    data['id'] = id;
    data['major_name'] = majorName;
    data['approve_name'] = approveName;
    return data;
  }
}
