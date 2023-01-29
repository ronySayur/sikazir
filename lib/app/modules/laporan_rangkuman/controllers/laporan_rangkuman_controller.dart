import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LaporanRangkumanController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var jumlahPenjualan = 0.obs;
  var jumlahPembelian = 0.obs;
  var totalPenjualan = 0.obs;
  var totalPembelian = 0.obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTrans() {
    return firestore
        .collection("penjualan")
        .orderBy("groupTanggal", descending: true)
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

  count() async {
    QuerySnapshot penjualanSnap = await firestore.collection('penjualan').get();
    List<DocumentSnapshot> cekPenjualan = penjualanSnap.docs;

    penjualanSnap.docs.forEach((doc) {
      totalPenjualan += doc["total"];
    });

    QuerySnapshot pembelianSnap = await firestore.collection('pembelian').get();
    List<DocumentSnapshot> cekPembelian = pembelianSnap.docs;

    pembelianSnap.docs.forEach((doc) {
      totalPembelian += doc["total_pembelian"];
    });

    jumlahPenjualan.value = cekPenjualan.length;
    jumlahPembelian.value = cekPembelian.length;
  }
}
