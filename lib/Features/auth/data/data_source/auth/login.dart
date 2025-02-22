import '../../../../../../core/class/crud.dart';
import '../../../../../../likeapi.dart';

class LoginData {
  Crud crud;

  LoginData(this.crud);

  Future login(String username, String password) async {
    var response = await crud.postData(AppLink.login, {
      "username": username.toString(),
      "password": password.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }
}
