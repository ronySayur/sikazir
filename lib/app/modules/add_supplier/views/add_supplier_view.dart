import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_supplier_controller.dart';

class AddSupplierView extends GetView<AddSupplierController> {
  const AddSupplierView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddSupplierView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddSupplierView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
