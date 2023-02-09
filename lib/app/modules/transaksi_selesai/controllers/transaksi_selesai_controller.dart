import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TransaksiSelesaiController extends GetxController {
  @override
  BlueThermalPrinter printer = BlueThermalPrinter.instance;
  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;

  @override
  void onInit() {
    super.onInit();
    getDevices();
  }

  void getDevices() async {
    devices = await printer.getBondedDevices();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamTransksi(
      String date) async* {
    yield* FirebaseFirestore.instance.collection("penjualan").doc(date).snapshots();
  }
}
