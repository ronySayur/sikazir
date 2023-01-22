import 'package:get/get.dart';

import '../controllers/add_toko_controller.dart';

class AddTokoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTokoController>(
      () => AddTokoController(),
    );
  }
}
