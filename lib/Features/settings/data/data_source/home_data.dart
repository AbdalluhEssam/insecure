import '../../../../../core/class/crud.dart';
import '../../../../../likeapi.dart';

class HomeData {
  Crud crud;

  HomeData(this.crud);

  getPostsData(String department, String band, String code, String token,
      String userId) async {
    var response = await crud.getData(
        "?department=$department&band=$band&code=$code&token=$token&user_id=$userId",
        {});
    return response.fold((l) => l, (r) => r);
  }

  addComplaintData(
    String complaintNumber,
    String complaintType,
    String complaintAddress,
    String complaintContent,
    String complaintDateTime,
    String studentType,
    String token,
    String userId,
  ) async {
    var response = await crud.getData(
        // "https://tawasol.obourtawasol.com/studentComplaint1.php?complaintNumber=52026988&complaintType=Students&complaintAddress=Not Find&complaintContent=Not it&complaintDateTime=08/09/2024&studentType=1&token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIkc3ViIiwibmFtZSI6IiRuYW1lIiwiYWRtaW4iOnRydWUsImV4cCI6MTcyNTY5MTg3Nn0.kSimMP_aBrUG58T5rcDyHNlD9YXOBkIS40J7RoqkwFU&user_id=13479"
        "?complaintNumber=$complaintNumber&complaintType=$complaintType&complaintAddress=$complaintAddress&complaintContent=$complaintContent&complaintDateTime=$complaintDateTime&studentType=$studentType&token=$token&user_id=$userId",
        {});
    return response.fold((l) => l, (r) => r);
  }

  addAttendData(
    String courseId,
    String codeSTD,
    String macAddrees,
    String date,
  ) async {
    var response = await crud.getData(
        "?course_id=$courseId&stu_id=$codeSTD&mac=$macAddrees&datat=$date",
        {});
    return response.fold((l) => l, (r) => r);
  }
}
