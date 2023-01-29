import 'package:get/get.dart';

import '../controllers/laporan_ringkasan_controller.dart';

class LaporanRingkasanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanRingkasanController>(
      () => LaporanRingkasanController(),
    );
  }
}
