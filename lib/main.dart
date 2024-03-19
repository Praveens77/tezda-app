import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_homescreen/screen/detail/view/detail_view.dart';
import 'package:task_homescreen/screen/favourate/view/fav_view.dart';
import 'package:task_homescreen/screen/list/view/list_view.dart';
import 'package:task_homescreen/screen/login/controller/login_controller.dart';
import 'package:task_homescreen/screen/login/view/login_view.dart';
import 'package:task_homescreen/screen/registration/view/regi_view.dart';
import 'package:task_homescreen/screen/splash/view/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tezda',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashView()),
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/registration', page: () => RegView()),
        GetPage(name: '/listpage', page: () => ListPage()),
        GetPage(
          name: '/detail',
          page: () => const DetailView(product: null),
        ),
        GetPage(name: '/favourate', page: () => FavourateView()),
      ],
      home: Obx(
        () {
          return controller.isLoggedIn.value ? ListPage() : SplashView();
        },
      ),
    );
  }
}
