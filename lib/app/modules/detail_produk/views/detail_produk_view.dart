import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_produk_controller.dart';

class DetailProdukView extends GetView<DetailProdukController> {
  const DetailProdukView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailProdukView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DetailProdukView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
