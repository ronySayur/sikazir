import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AllPegawaiController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamPegawai() {
    return firestore.collection("pegawai").snapshots();
  }

  late TextEditingController searchC;

  var queryAwal = [].obs;
  var tempSearch = [].obs;

  Future<void> searchPegawai(String nama, String email) async {
    if (nama.isEmpty) {
      queryAwal.value = [];
      tempSearch.value = [];
    } else {
      var capitalized = nama.substring(0, 1).toUpperCase() + nama.substring(1);
      if (queryAwal.isEmpty && nama.length == 1) {
        //fungsi yang akan dijalankan pada 1 ketikan pertama
        CollectionReference pegawai = firestore.collection("pegawai");

        final keyNameResult = await pegawai
            .where("name", isEqualTo: nama.substring(0, 1).toUpperCase())
            .where("email", isNotEqualTo: email)
            .get();

        if (keyNameResult.docs.isNotEmpty) {
          for (int i = 0; i < keyNameResult.docs.length; i++) {
            queryAwal.add(keyNameResult.docs[i].data() as Map<String, dynamic>);
          }
        } else {}
      }

      if (queryAwal.isNotEmpty) {
        tempSearch.value = [];
        queryAwal.forEach((element) {
          if (element["name"].startsWith(capitalized)) {
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
    super.onInit();
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }
}
