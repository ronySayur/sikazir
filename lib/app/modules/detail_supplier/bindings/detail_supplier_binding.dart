import 'package:get/get.dart';

import '../controllers/detail_supplier_controller.dart';

class DetailSupplierBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailSupplierController>(
      () => DetailSupplierController(),
    );
  }
}
