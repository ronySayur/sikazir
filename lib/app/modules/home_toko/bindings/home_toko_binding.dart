import 'package:get/get.dart';

import '../controllers/home_toko_controller.dart';

class HomeTokoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeTokoController>(
      () => HomeTokoController(),
    );
  }
}
