import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';
import '../../blue_therma_print/controllers/blue_therma_print_controller.dart';

class DetailRiwayatController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final box = GetStorage();

  var riwayatC = <Map<String, dynamic>>[].obs;

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

    for (var message in snaphsot.docs) {
      final nama_produk = message["nama_produk"];
      final diskon = message["diskon"];
      final harga_jual = message["harga_jual"];
      final harga_modal = message["harga_modal"];
      final id_produk = message["id_produk"];
      final jumlah = message["jumlah"];
      final nama_diskon = message["nama_diskon"];
      final total_harga = message["total_harga"];

      print(nama_produk);
    }
  }

  printerState() {
    var savedDevice = box.read('printer');
    final BluetoothDevice printer;
    if (savedDevice != null) {
      printer = BluetoothDevice.fromMap(savedDevice);
      BlueThermaPrintController().connect(printer);
      BlueThermaPrintController().printData();
    } else {
      Get.toNamed(Routes.BLUE_THERMA_PRINT);
    }
  }
}
