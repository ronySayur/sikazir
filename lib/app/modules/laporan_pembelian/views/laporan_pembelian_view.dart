import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/laporan_pembelian_controller.dart';

class LaporanPembelianView extends GetView<LaporanPembelianController> {
  const LaporanPembelianView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Pembelian'),
        centerTitle: false,
      ),
      body: Center(
        child: Text(
          'LaporanPembelianView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
