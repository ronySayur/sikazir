import 'package:get/get.dart';

import '../controllers/home_pembelian_controller.dart';

class HomePembelianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePembelianController>(
      () => HomePembelianController(),
    );
  }
}
