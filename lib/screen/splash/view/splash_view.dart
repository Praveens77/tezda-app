import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_homescreen/common/colors.dart';
import 'package:task_homescreen/common/image.dart';
import 'package:task_homescreen/common/widget.dart';
import 'package:task_homescreen/screen/splash/controller/splash_controller.dart';

class SplashView extends StatelessWidget {
   SplashView({super.key});
  final SplashController controller = Get.put(SplashController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(ImagePath.logo, height: 200),
            const SizedBox(height: 16),
            CustomText("Welcome to Tezda", black, 30, "Poppins", FontWeight.bold),
            const SizedBox(height: 8),
            CustomText("Buy your Favourite Cloths", black, 14, "Poppins",
                FontWeight.w100),
            const SizedBox(height: 16),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.info, color: Colors.grey),
                const SizedBox(width: 8),
                CustomText("Ensure proper Internet Connectivity", button, 16,
                    "Poppins", FontWeight.bold),
              ],
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
