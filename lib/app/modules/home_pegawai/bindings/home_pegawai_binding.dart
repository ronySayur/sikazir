import 'package:get/get.dart';

import '../controllers/home_pegawai_controller.dart';

class HomePegawaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePegawaiController>(
      () => HomePegawaiController(),
    );
  }
}
