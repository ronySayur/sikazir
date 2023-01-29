import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sikasir/app/models/penjualan_model.dart';
import 'package:sikasir/app/models/penjualanluar_model.dart';

class LaporanPegawaiController extends GetxController {
  @override
  void onInit() {
    getemailall();
    super.onInit();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<PenjualanLuarModel> allProd = [];

  Future<void> getemailall() async {
    QuerySnapshot snaphsot = await firestore.collection("penjualan").get();

    for (var eachData in snaphsot.docs) {
      final email = eachData["email_pegawai"];
      final total = eachData["total"];

      print(eachData.data());
    }
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> streamPenjualan() {
    return firestore.collection("penjualan").snapshots();
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
}
