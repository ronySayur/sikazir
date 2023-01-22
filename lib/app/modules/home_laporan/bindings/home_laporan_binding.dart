import 'package:get/get.dart';

import '../controllers/home_laporan_controller.dart';

class HomeLaporanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeLaporanController>(
      () => HomeLaporanController(),
    );
  }
}
