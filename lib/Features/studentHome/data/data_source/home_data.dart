import 'dart:io';

import 'package:insecure/likeapi.dart';

import '../../../../../core/class/crud.dart';

class HomeData {
  Crud crud;

  HomeData(this.crud);

  Future<dynamic> addComplaintData(
      String complaintTitle,
      String complaintContent,
      String complaintTypeId,
      String complaintAuthorityId,
      String userId,
      File? image) async {
    var response = await crud.postRequestWithFiles(
        AppLink.complaintAddNew,
        {
          "complaint_title": complaintTitle,
          "complaint_content": complaintContent,
          "complaint_type_id": complaintTypeId,
          "complaint_authority_id": complaintAuthorityId,
          "user_id": userId,
        },
        image, // لم يعد هناك `!` لأن الصورة قد تكون `null`
        "file");
    return response;
  }

  Future<dynamic> getComplaints(String userId) async {
    var response = await crud.postData(AppLink.complaintView, {
      "user_id": userId, // تأكد أن `userId` يتم تمريره كـ String
    });
    return response.fold((l) => l, (r) => r);
  }
}
