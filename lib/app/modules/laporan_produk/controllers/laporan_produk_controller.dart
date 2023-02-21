import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class LaporanProdukController extends GetxController {
  GetStorage box = GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var jumlahPenjualan = 0.obs;
  var jumlahPembelian = 0.obs;
  var totalPenjualan = 0.obs;
  var totalPembelian = 0.obs;
  var total = 0.obs;
  var terlaris = "".obs;

  count() async {
    QuerySnapshot snaphsot = await firestore.collection('produk').get();
    QuerySnapshot snapBig = await firestore
        .collection('produk')
        .orderBy("terjual", descending: true)
        .limit(1)
        .get();

    for (var message in snaphsot.docs) {
      total.value += message["terjual"] as int;
    }
    for (var message in snapBig.docs) {
      terlaris.value = message["nama_produk"];
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamProduk() {
    return firestore
        .collection("produk")
        .where("id_toko", isEqualTo: box.read('toko'))
        .snapshots();
  }

  TextEditingController textFieldTanggal = TextEditingController();

  var dateRange = DateTimeRange(
          start: DateTime.now(),
          end: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 6))
      .obs;

  dateRangePicker() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: Get.context!,
      firstDate: DateTime(DateTime.now().year - 20),
      lastDate: DateTime(DateTime.now().year + 20),
      initialDateRange: dateRange.value,
      builder: (context, child) {
        return Theme(data: ThemeData.dark(), child: child!);
      },
    );

    if (picked != null && picked != dateRange.value) {
      dateRange.value = picked;
      textFieldTanggal.text =
          '${DateFormat("dd MMM").format(dateRange.value.start).toString()} - ${DateFormat("dd MMM yyyy").format(dateRange.value.end).toString()}';
    }
  }

  @override
  void onInit() {
    count();
    super.onInit();
  }
}
