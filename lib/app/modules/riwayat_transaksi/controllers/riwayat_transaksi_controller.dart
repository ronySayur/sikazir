import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RiwayatTransaksiController extends GetxController {
  final box = GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTrans() {
    return firestore
        .collection("penjualan")
        .orderBy("groupTanggal",descending: true)
        .snapshots();
  }
}
