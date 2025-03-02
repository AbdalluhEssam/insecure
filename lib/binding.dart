import 'package:get/get.dart';
import 'core/class/crud.dart';
import 'package:insecure/Features/studentHome/controller/complaint_controller.dart'
    as studentComplaint;

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());

    // Use named instances to avoid conflict
    Get.lazyPut(() => studentComplaint.ComplaintStudentControllerImp(),
        tag: 'student');
  }
}
