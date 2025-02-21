class AppLink {
//================================== Hosting ===============================//
  static const String serverLink = "https://elearning.oi.edu.eg";
  static const String serverLinkOI = "https://tawasol.obourtawasol.com";
//================================== Image ===============================//
  static const String imageStatic = "$serverLink/upload";
  static const String imageServices = "$imageStatic/services";
//================================== Auth ===============================//
  static const String signUp = "$serverLink/auth/signup.php";
  static const String verfiyCodeSignUp = "$serverLink/auth/verfiycode.php";
  static const String reSend = "$serverLink/auth/resend.php";
  static const String login = "https://elearning.oi.edu.eg/login/token.php";
  static const String dataSTD = "https://elearning.oi.edu.eg/webservice/rest/server.php";
  static const String setSTDData = "$serverLinkOI/insertUserOrUpdateData2.php";
  static const String studentLogin = "$serverLinkOI/studentLogin.php";
//================================== Forget Password ===============================//
  static const String checkEmail = "$serverLink/forgetpassword/checkemail.php";
  static const String verfiyCodeForgetPass ="$serverLink/forgetpassword/verfiycode.php";
  static const String resetPassword ="$serverLink/forgetpassword/resetpassword.php";
//================================== Home ===============================//
  static const String homePage = "$serverLink/home.php";
  static const String postGet = "$serverLinkOI/getAllPost.php";
  static const String addComplaint = "$serverLinkOI/studentComplaint1.php";
  static const String getAllComplaint = "$serverLinkOI/getComplaints.php";
  static const String replayComplaints = "$serverLinkOI/replayComplaints.php";
  static const String addAttend = "$serverLinkOI/registerAttendence.php";
//================================== HomeAdmin ===============================//
  static const String postGetAdmin = "https://tawasol.obourtawasol.com/getPostAdminHome3.php";
  static const String deletePost = "https://tawasol.obourtawasol.com/deletePost.php";
  static const String addComplaintAdmin = "$serverLinkOI/studentComplaint1.php";
  static const String addAttendAdmin = "$serverLinkOI/registerAttendence.php";
//================================== NOTIFICATION ===============================//
  static const String notification = "$serverLink/notification.php";
//================================== ADMIN ===============================//
  static const String loginAdmin = "https://elearning.oi.edu.eg/login/token.php";

//================================== Payment ===============================//
  static const String getPiadInfo = "$serverLinkOI/getPiadInfo.php";
  static const String updateFees = "$serverLinkOI/updateFees.php";

//================================== POSTS Department ===============================//
  static const String getMainDepartment = "$serverLinkOI/getMainDeparment.php";
  static const String getAdminGroups = "$serverLinkOI/getAdminGroups.php";
  static const String createAdminGroups = "$serverLinkOI/createGroup.php";
  static const String addGroupMember = "$serverLinkOI/addGroupMember.php";
  static const String deleteGroupMember = "$serverLinkOI/deleteOnememberInGroup.php";
  static const String deleteGroup = "$serverLinkOI/deleteGroup.php";
  static const String getDepartmentAndBandAndLab = "$serverLinkOI/getDepartmentAndBandAndLab.php";
  static const String getAllUsers = "$serverLinkOI/getAllUsers.php";
  static const String uploadNewPost = "$serverLinkOI/uploadNewPost.php";
  static const String editImageAdmin = "$serverLinkOI/editImageAdmin.php";


//================================== Payment ===============================//
  static const String getGuardianCode = "$serverLinkOI/getGuardianCode.php";
//================================== END ===============================//
}
