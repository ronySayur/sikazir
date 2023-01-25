import 'package:get/get.dart';

import '../controllers/update_keranjang_controller.dart';

class UpdateKeranjangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateKeranjangController>(
      () => UpdateKeranjangController(),
    );
  }
}
