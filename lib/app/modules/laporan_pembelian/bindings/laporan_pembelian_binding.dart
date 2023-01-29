import 'package:get/get.dart';

import '../controllers/laporan_pembelian_controller.dart';

class LaporanPembelianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanPembelianController>(
      () => LaporanPembelianController(),
    );
  }
}
