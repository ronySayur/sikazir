import 'package:get/get.dart';

import '../controllers/detail_toko_controller.dart';

class DetailTokoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailTokoController>(
      () => DetailTokoController(),
    );
  }
}
