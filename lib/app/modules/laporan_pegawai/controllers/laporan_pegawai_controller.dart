import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LaporanPegawaiController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var jumlahPenjualan = 0.obs;
  var totalPenjualan = 0.obs;
  var detailtotal = 0.obs;
  var detailjumlah = 0.obs;

  TextEditingController textFieldTanggal = TextEditingController();

  Stream<QuerySnapshot<Map<String, dynamic>>> streamPenjualan() {
    return firestore.collection("penjualan").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamPegawai() {
    return firestore.collection("pegawai").snapshots();
  }

  @override
  void onInit() {
    count();
    super.onInit();
  }

  count() async {
    QuerySnapshot penjualanSnap = await firestore.collection('penjualan').get();
    List<DocumentSnapshot> cekPenjualan = penjualanSnap.docs;

    penjualanSnap.docs.forEach((doc) {
      totalPenjualan += doc["total"];
    });
    jumlahPenjualan.value = cekPenjualan.length;
  }

  countDetail(String email) async {
    QuerySnapshot penjualanSnap = await firestore
        .collection('penjualan')
        .where("email_pegawai", isEqualTo: email)
        .get();
    List<DocumentSnapshot> cekPenjualan = penjualanSnap.docs;

      penjualanSnap.docs.forEach((doc) {
        detailtotal += doc["total"];
      });
      detailjumlah.value = cekPenjualan.length;
  }

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
}
