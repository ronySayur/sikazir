import 'package:get/get.dart';

import '../controllers/home_supplier_controller.dart';

class HomeSupplierBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeSupplierController>(
      () => HomeSupplierController(),
    );
  }
}
