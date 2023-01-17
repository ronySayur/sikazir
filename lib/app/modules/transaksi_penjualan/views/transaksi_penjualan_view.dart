import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/transaksi_penjualan_controller.dart';

class TransaksiPenjualanView extends GetView<TransaksiPenjualanController> {
  const TransaksiPenjualanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                backgroundColor: Colors.red,
        title: const Text('TransaksiPenjualanView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TransaksiPenjualanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
