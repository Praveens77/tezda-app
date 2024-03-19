import 'package:get/get.dart';
import 'package:task_homescreen/screen/list/view/list_view.dart';
import 'package:task_homescreen/screen/login/view/login_view.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    if (isLoggedIn()) {
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAll(() => ListPage());
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAll(() => LoginView());
      });
    }
  }

  bool isLoggedIn() {
    // Add your logic to check if the user is logged in
    // For example, you can use shared preferences, a state management solution, etc.
    // Return true if logged in, false otherwise
    return false; // Replace this with your actual logic
  }
}
