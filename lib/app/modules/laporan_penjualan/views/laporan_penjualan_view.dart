import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/laporan_penjualan_controller.dart';

class LaporanPenjualanView extends GetView<LaporanPenjualanController> {
  const LaporanPenjualanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LaporanPenjualanView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LaporanPenjualanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
