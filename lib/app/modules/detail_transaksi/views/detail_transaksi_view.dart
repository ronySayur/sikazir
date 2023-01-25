import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/detail_transaksi_controller.dart';

class DetailTransaksiView extends GetView<DetailTransaksiController> {
  // final List<DetailKeranjangModel> emailUser = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Detail Transaksi'),
          centerTitle: false,
        ),
        body: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child: TextField(
                    // controller: controller.emailC,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: "Uang yang diterima",
                      labelStyle: TextStyle(
                          color: Colors.black, fontSize: wDimension.font16),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(wDimension.radius30 * 10),
                          borderSide: const BorderSide(color: Colors.red)),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(wDimension.radius30 * 10),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: wDimension.width30,
                        vertical: wDimension.width15,
                      ),
                    ),
                  ),
                ),
              ),
         
            ],
          ),
        ));
  }
}
