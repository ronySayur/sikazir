import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_barang_controller.dart';

class AddBarangView extends GetView<AddBarangController> {
  const AddBarangView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddBarangView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddBarangView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
