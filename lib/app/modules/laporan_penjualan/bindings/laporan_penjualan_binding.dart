import 'package:get/get.dart';

import '../controllers/laporan_penjualan_controller.dart';

class LaporanPenjualanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanPenjualanController>(
      () => LaporanPenjualanController(),
    );
  }
}
