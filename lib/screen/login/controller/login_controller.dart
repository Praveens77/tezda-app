import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  RxBool loading = false.obs;
  final RxString password = ''.obs;
  final RxBool isPasswordVisible = true.obs;
  final RxBool isLoggedIn = false.obs; // Add isLoggedIn flag

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus(); // Check login status when the controller is initialized
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
  }

  void setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
    isLoggedIn.value = value;
  }
}
