import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_homescreen/common/colors.dart';
import 'package:task_homescreen/common/image.dart';
import 'package:task_homescreen/common/widget.dart';
import 'package:task_homescreen/screen/login/view/login_view.dart';
import 'package:task_homescreen/screen/profile/controller/prof_controller.dart';

// ... previous imports ...

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:
            CustomText("Profile Page", black, 20, "Poppins", FontWeight.bold),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
        child: Form(
          key: formKey,
          child: Center(
            child: FutureBuilder(
              future: controller.fetchUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              ImagePath.profile,
                              fit: BoxFit.cover,
                              height: 150,
                              width: 150,
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: () async {
                                await controller.pickAndUploadImage();
                              },
                              child: const CircleAvatar(
                                backgroundColor: button,
                                radius: 15,
                                child: Icon(
                                  Icons.edit,
                                  color: white,
                                  size: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          CustomText(
                            "Name: ${controller.name}",
                            black,
                            15,
                            "",
                            FontWeight.w500,
                          ),
                          const SizedBox(width: 20),
                          const SizedBox(height: 5),
                          CustomText(
                            "Email: ${controller.email}",
                            black,
                            15,
                            "",
                            FontWeight.w500,
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance.signOut();
                            Get.offAll(() => LoginView());
                          } catch (e) {
                            // ignore: avoid_print
                            print("Error during logout: $e");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: button,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: white,
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
