import 'package:get/get.dart';

import '../controllers/transaksi_penjualan_controller.dart';

class TransaksiPenjualanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransaksiPenjualanController>(
      () => TransaksiPenjualanController(),
    );
  }
}
