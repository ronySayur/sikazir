import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeProdukController extends GetxController
    with GetTickerProviderStateMixin {
  AnimationController? animationController;
  late TextEditingController searchC;

  var ontap = false.obs;
  var queryAwal = [].obs;
  var tempSearch = [].obs;

  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamProduk() {
    return firestore.collection("produk").snapshots();
  }

  Future<void> searchProduk(String data) async {
    //jika data kosong

    if (data.isEmpty) {
      queryAwal.value = [];
      tempSearch.value = [];
    } else {
      //buat data jadi kapital
      var capitalized = data.substring(0, 1).toUpperCase() + data.substring(1);
      if (queryAwal.isEmpty && data.length == 1) {
        //fungsi yang akan dijalankan pada 1 ketikan pertama
        CollectionReference products = firestore.collection("produk");

        final keyNameResult = await products
            .where("keyName", isEqualTo: data.substring(0, 1).toUpperCase())
            .get();

        if (keyNameResult.docs.isNotEmpty) {
          for (int i = 0; i < keyNameResult.docs.length; i++) {
            queryAwal.add(keyNameResult.docs[i].data() as Map<String, dynamic>);
          }
        }
      }

      if (queryAwal.isNotEmpty) {
        tempSearch.value = [];
        queryAwal.forEach((element) {
          if (element["nama_produk"].startsWith(capitalized)) {
            tempSearch.add(element);
          }
        });
      }
    }

    queryAwal.refresh();
    tempSearch.refresh();
  }

  @override
  void onInit() {
    searchC = TextEditingController();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }
}
