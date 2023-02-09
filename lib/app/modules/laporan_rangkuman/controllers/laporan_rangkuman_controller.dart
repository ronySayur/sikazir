import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LaporanRangkumanController extends GetxController {
  @override
  void onInit() {
    count();
    super.onInit();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var jumlahPenjualan = 0.obs;
  var jumlahPembelian = 0.obs;
  var totalPenjualan = 0.obs;
  var totalPembelian = 0.obs;

  var dateRange = DateTimeRange(
          start: DateTime.now(),
          end: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 6))
      .obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTrans() {
    final startAtTimestamp = Timestamp.fromMillisecondsSinceEpoch(
        dateRange.value.start.millisecondsSinceEpoch);
    print(dateRange.value.start.toIso8601String());

    return firestore
        .collection('penjualan')
        .orderBy("tanggal", descending: true)
        .where('tanggal',
            isLessThanOrEqualTo: dateRange.value.start.toIso8601String())
        .snapshots();
  }

  TextEditingController textFieldTanggal = TextEditingController();

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
          '${DateFormat("yMMMd").format(dateRange.value.start).toString()} - ${DateFormat("yMMMd").format(dateRange.value.end).toString()}';
    }
  }

  count() async {
    totalPenjualan.value = 0;
    totalPembelian.value = 0;

    QuerySnapshot penjualanSnap = await firestore
        .collection('penjualan')
        .where("groupTanggal",
            isGreaterThanOrEqualTo:
                DateFormat("yMMMd").format(dateRange.value.start).toString())
        .get();

    QuerySnapshot pembelianSnap = await firestore.collection('pembelian').get();

    List<DocumentSnapshot> cekPenjualan = penjualanSnap.docs;
    List<DocumentSnapshot> cekPembelian = pembelianSnap.docs;

    penjualanSnap.docs.forEach((doc) {
      totalPenjualan += doc["total"];
    });

    pembelianSnap.docs.forEach((doc) {
      totalPembelian += doc["total_pembelian"];
    });

    jumlahPenjualan.value = cekPenjualan.length;
    jumlahPembelian.value = cekPembelian.length;

    update();
  }
}
