import 'package:get/get.dart';

import '../controllers/home_produk_controller.dart';

class HomeProdukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeProdukController>(
      () => HomeProdukController(),
    );
  }
}
