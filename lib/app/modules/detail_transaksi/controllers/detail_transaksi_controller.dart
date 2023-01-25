import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailTransaksiController extends GetxController {

  FirebaseFirestore firestore = FirebaseFirestore.instance;


  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllKeranjang(currentUserEmail) {
    return firestore
        .collection("keranjang")
        .doc(currentUserEmail)
        .collection('produk')
        .snapshots();
  }
}
