import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/transaksi_selesai_controller.dart';

class TransaksiSelesaiView extends GetView<TransaksiSelesaiController> {
  const TransaksiSelesaiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TransaksiSelesaiView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TransaksiSelesaiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
