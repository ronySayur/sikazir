// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sikasir/widgets/splash_screen.dart';

import 'app/controllers/auth_controller.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "Sikasir",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  accessDataOfflineConfigureCache();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final authC = Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return FutureBuilder(
            future: authC.firstInitialized(),
            builder: (context, snapshot) => const SplashScreen(),
          );
        }
        return Obx(() => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Sikasir",
              builder: EasyLoading.init(),
              initialRoute: authC.isSkipIntro.isTrue
                  ? snapshot.data != null
                      ? Routes.HOME
                      : Routes.LOGIN
                  : Routes.INTRODUCTION,
              getPages: AppPages.routes,
            ));
      },
    );
  }
}

void accessDataOfflineConfigureCache() {
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
}
