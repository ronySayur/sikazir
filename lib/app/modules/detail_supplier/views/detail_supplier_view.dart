import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_supplier_controller.dart';

class DetailSupplierView extends GetView<DetailSupplierController> {
  const DetailSupplierView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailSupplierView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DetailSupplierView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
