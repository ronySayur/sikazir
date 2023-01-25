import 'package:get/get.dart';

import '../controllers/add_pembelian_controller.dart';

class AddPembelianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPembelianController>(
      () => AddPembelianController(),
    );
  }
}
