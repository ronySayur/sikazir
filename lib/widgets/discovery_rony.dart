import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> ngetem(Future fungsi) async {
  Get.defaultDialog(
      title: "Tunggu Sebentar",
      content: const CircularProgressIndicator(),
      barrierDismissible: false);

  await fungsi;

  Get.back();
}