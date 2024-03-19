import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:task_homescreen/common/colors.dart';
import 'package:task_homescreen/common/image.dart';
import 'package:task_homescreen/common/widget.dart';
import 'package:task_homescreen/screen/list/view/list_view.dart';
import 'package:task_homescreen/screen/login/view/login_view.dart';
import 'package:task_homescreen/screen/registration/controller/regi_controller.dart';
import 'package:task_homescreen/screen/registration/model/model.dart';

class RegView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  //editing controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RegController controller = Get.put(RegController());
  final auth = FirebaseAuth.instance;

  RegView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            CustomText("Registration", black, 20, "Poppins", FontWeight.bold),
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
                    ImagePath.register,
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 40),
                  CustomText('Welcome to Tezda', black, 20, "Poppins",
                      FontWeight.bold),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: fullNameController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: white,
                      contentPadding: EdgeInsets.all(10),
                      suffixIcon: Icon(
                        Icons.person_3_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                      hintText: "Enter your Name",
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
                          color: Colors.indigo,
                          width: 0.5,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter valid name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
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
                          color: Colors.indigo,
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
                  const SizedBox(height: 20),
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
                        hintText: "Create your Password",
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
                      if (formKey.currentState?.validate() ?? false) {
                        // Get.to(() => LoginView());
                        signUp(emailController.text, passwordController.text);
                      }
                    },
                    child: Center(
                        child: CustomText(
                            "Register", white, 15, "Poppins", FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    child: CustomText("Already a user ? LogIn ", Colors.indigo,
                        15, "Poppins", FontWeight.bold),
                    onTap: () {
                      Get.to(() => LoginView());
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

  //Sign Up Function
  void signUp(String email, String password) async {
    if (formKey.currentState!.validate()) {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        postDetailsToFirestore();
        Get.off(() => ListPage());
      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = fullNameController.text;

    await firebaseFirestore
        .collection("email_users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account Created Successfully");

    // Use Get.to instead of Navigator.pushReplacement
    Get.off(() => ListPage());
  }
}
