import 'package:get/get.dart';
import 'Features/studentHome/controller/home_student_controller.dart';
import 'core/class/crud.dart';
import 'package:insecure/Features/studentHome/controller/complaint_controller.dart'
    as studentComplaint;

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.lazyPut(() => HomeStudentControllerImp());

    // Use named instances to avoid conflict
    Get.lazyPut(() => studentComplaint.ComplaintStudentControllerImp(),
        tag: 'student');
  }
}
