import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_toko_controller.dart';

class DetailTokoView extends GetView<DetailTokoController> {
  const DetailTokoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailTokoView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DetailTokoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
