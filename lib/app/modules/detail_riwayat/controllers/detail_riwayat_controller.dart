import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailRiwayatController extends GetxController {
FirebaseFirestore firestore=FirebaseFirestore.instance;

List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  @override
  void onInit() {
    super.onInit();
    getDevices();
  }

  void getDevices() async {
    devices = await printer.getBondedDevices();
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> streamPenjualan(String idPenjualan) {
    return firestore
        .collection("penjualan").doc(idPenjualan).collection("produk")
        .snapshots();
  }
}
