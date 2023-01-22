import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_toko_controller.dart';

class UpdateTokoView extends GetView<UpdateTokoController> {
  const UpdateTokoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UpdateTokoView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'UpdateTokoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
