class ComplainModel {
  int? complaintId;
  String? complaintTitle;
  String? complaintContent;
  String? complaintImage;
  int? complaintTypeId;
  int? complaintAuthorityId;
  String? complaintReply;
  String? complaintDate;
  int? status;
  int? userId;
  String? typeName;
  int? authorityId;
  String? authorityName;
  String? username;
  String? email;
  String? phone;
  String? password;
  String? createAt;
  int? userApprove;

  ComplainModel(
      {this.complaintId,
      this.complaintTitle,
      this.complaintContent,
      this.complaintImage,
      this.complaintTypeId,
      this.complaintAuthorityId,
      this.complaintReply,
      this.complaintDate,
      this.status,
      this.userId,
      this.typeName,
      this.authorityId,
      this.authorityName,
      this.username,
      this.email,
      this.phone,
      this.password,
      this.createAt,
      this.userApprove});

  ComplainModel.fromJson(Map<String, dynamic> json) {
    complaintId = json['complaint_id'];
    complaintTitle = json['complaint_title'];
    complaintContent = json['complaint_content'];
    complaintImage = json['complaint_image'];
    complaintTypeId = json['complaint_type_id'];
    complaintAuthorityId = json['complaint_authority_id'];
    complaintReply = json['complaint_reply'];
    complaintDate = json['complaint_date'];
    status = json['status'];
    userId = json['user_id'];
    typeName = json['type_name'];
    authorityId = json['authority_id'];
    authorityName = json['authority_name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    createAt = json['createAt'];
    userApprove = json['user_approve'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['complaint_id'] = complaintId;
    data['complaint_title'] = complaintTitle;
    data['complaint_content'] = complaintContent;
    data['complaint_image'] = complaintImage;
    data['complaint_type_id'] = complaintTypeId;
    data['complaint_authority_id'] = complaintAuthorityId;
    data['complaint_reply'] = complaintReply;
    data['complaint_date'] = complaintDate;
    data['status'] = status;
    data['user_id'] = userId;
    data['type_name'] = typeName;
    data['authority_id'] = authorityId;
    data['authority_name'] = authorityName;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['createAt'] = createAt;
    data['user_approve'] = userApprove;
    return data;
  }
}
