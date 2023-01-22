import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_laporan_controller.dart';

class HomeLaporanView extends GetView<HomeLaporanController> {
  const HomeLaporanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeLaporanView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HomeLaporanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
