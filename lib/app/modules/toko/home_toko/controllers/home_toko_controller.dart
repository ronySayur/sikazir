import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeTokoController extends GetxController
    with GetTickerProviderStateMixin {
  AnimationController? animationController;
  late TextEditingController searchC;

  var queryAwal = [].obs;
  var tempSearch = [].obs;

  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamToko() {
    return firestore.collection("toko").snapshots();
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
        CollectionReference toko = firestore.collection("toko");

        final keyNameResult = await toko
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
          if (element["nama_toko"].startsWith(capitalized)) {
            tempSearch.add(element);
          }
        });
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
