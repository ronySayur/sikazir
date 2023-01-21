import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_toko_controller.dart';

class HomeTokoView extends GetView<HomeTokoController> {
  const HomeTokoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeTokoView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HomeTokoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
