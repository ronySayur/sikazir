import 'package:get/get.dart';

import '../controllers/laporan_produk_controller.dart';

class LaporanProdukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanProdukController>(
      () => LaporanProdukController(),
    );
  }
}
