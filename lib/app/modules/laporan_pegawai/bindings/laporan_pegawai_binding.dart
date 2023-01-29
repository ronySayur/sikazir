import 'package:get/get.dart';

import '../controllers/laporan_pegawai_controller.dart';

class LaporanPegawaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LaporanPegawaiController>(
      () => LaporanPegawaiController(),
    );
  }
}
