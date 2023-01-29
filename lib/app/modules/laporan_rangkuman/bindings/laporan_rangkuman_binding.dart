import 'package:get/get.dart';

import '../controllers/laporan_rangkuman_controller.dart';

class LaporanRangkumanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanRangkumanController>(
      () => LaporanRangkumanController(),
    );
  }
}
