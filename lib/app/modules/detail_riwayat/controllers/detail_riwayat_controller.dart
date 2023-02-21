import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';
import '../../blue_therma_print/controllers/blue_therma_print_controller.dart';

class DetailRiwayatController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final box = GetStorage();
  var dataDetail = [];
  var data = [];

  Stream<QuerySnapshot<Map<String, dynamic>>> streamPenjualan(
      String idPenjualan) {
    return firestore
        .collection("penjualan")
        .doc(idPenjualan)
        .collection("produk")
        .snapshots();
  }

  // Printer
  Future<void> penjualanDetail(String idPenjualan) async {
    QuerySnapshot snaphsot = await firestore
        .collection("penjualan")
        .doc(idPenjualan)
        .collection("produk")
        .get();

    for (var data in snaphsot.docs) {
      dataDetail.add(data);
    }
  }

  printerState() {
    var savedDevice = box.read('printer');
    
    final BluetoothDevice printer;
    if (savedDevice != null) {
      printer = BluetoothDevice.fromMap(savedDevice);
      BlueThermaPrintController().connect(printer);
      BlueThermaPrintController().printDataRiwayat(dataDetail, data);
    } else {
      Get.toNamed(Routes.BLUE_THERMA_PRINT);
    }
  }
}
