import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeSupplierController extends GetxController
    with GetTickerProviderStateMixin {
  AnimationController? animationController;
  late TextEditingController searchC;

  var queryAwal = [].obs;
  var tempSearch = [].obs;

  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamSupplier() {
    return firestore.collection("supplier").snapshots();
  }

  Future<void> searchSupplier(String data) async {
    //jika data kosong

    if (data.isEmpty) {
      queryAwal.value = [];
      tempSearch.value = [];
    } else {
      //buat data jadi kapital
      var capitalized = data.substring(0, 1).toUpperCase() + data.substring(1);
      if (queryAwal.isEmpty && data.length == 1) {
        //fungsi yang akan dijalankan pada 1 ketikan pertama
        CollectionReference sup = firestore.collection("supplier");

        final keyNameResult = await sup
            .where("keyName", isEqualTo: data.substring(0, 1).toUpperCase())
            .get();

        if (keyNameResult.docs.isNotEmpty) {
          for (int i = 0; i < keyNameResult.docs.length; i++) {
            queryAwal.add(keyNameResult.docs[i].data() as Map<String, dynamic>);
          }
        }
        print(keyNameResult.docs);
      }
      print("tempSearch $tempSearch");
      if (queryAwal.isNotEmpty) {
        tempSearch.value = [];

        queryAwal.forEach((element) {
          if (element["nama_vendor"].startsWith(capitalized)) {
            tempSearch.add(element);
          }
        });

        print("queryAwal $queryAwal");
        print("queryAwal $tempSearch");
      }
    }

    queryAwal.refresh();
    tempSearch.refresh();
    update();
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
