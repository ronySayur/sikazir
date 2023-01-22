import 'package:get/get.dart';

import '../controllers/update_toko_controller.dart';

class UpdateTokoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateTokoController>(
      () => UpdateTokoController(),
    );
  }
}
