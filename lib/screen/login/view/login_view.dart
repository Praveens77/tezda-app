import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_homescreen/common/colors.dart';
import 'package:task_homescreen/common/image.dart';
import 'package:task_homescreen/common/widget.dart';
import 'package:task_homescreen/screen/list/view/list_view.dart';
import 'package:task_homescreen/screen/login/controller/login_controller.dart';
import 'package:task_homescreen/screen/registration/view/regi_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LoginController controller = Get.put(LoginController());
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Login", black, 20, "Poppins", FontWeight.bold),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImagePath.login,
                    height: 150,
                    width: 150,
                  ),
                  const SizedBox(height: 40),
                  CustomText('Welcome to Tezda', black, 20, "Poppins",
                      FontWeight.bold),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: white,
                      contentPadding: EdgeInsets.all(10),
                      suffixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                      hintText: "Enter your Email",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide:
                            BorderSide(color: Colors.indigo, width: 0.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => TextFormField(
                      controller: passwordController,
                      obscureText: !controller.isPasswordVisible.value,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        contentPadding: const EdgeInsets.all(10),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.isPasswordVisible.value =
                                !controller.isPasswordVisible.value;
                          },
                          child: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                        hintText: "Enter your Password",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide:
                              BorderSide(color: Colors.indigo, width: 0.5),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(
                            color: Colors.indigo,
                            width: 0.5,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        controller.password.value = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  MaterialButton(
                    height: 40,
                    minWidth: MediaQuery.of(context).size.width,
                    elevation: 0,
                    color: black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      _handleLogin(context);
                    },
                    child: Center(
                      child: CustomText(
                        "Login",
                        white,
                        15,
                        "Poppins",
                        FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    child: CustomText("New user ? SignUp", Colors.indigo, 15,
                        "Poppins", FontWeight.bold),
                    onTap: () {
                      Get.to(() => RegView());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// Update _handleLogin method in LoginView
  void _handleLogin(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      controller.setLoading(true);

      try {
        await _auth
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((uid) {
          Fluttertoast.showToast(msg: "Login Successful");
          controller.setLoggedIn(true); // Set the isLoggedIn flag to true
          Get.off(() => ListPage());
        });
      } catch (e) {
        print('Error type: ${e.runtimeType}');
        Fluttertoast.showToast(msg: 'An error occurred');
      } finally {
        controller.setLoading(false);
      }
    }
  }
}
