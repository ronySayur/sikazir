import 'package:get/get.dart';

import '../controllers/transaksi_selesai_controller.dart';

class TransaksiSelesaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransaksiSelesaiController>(
      () => TransaksiSelesaiController(),
    );
  }
}
