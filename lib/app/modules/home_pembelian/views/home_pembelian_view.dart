import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/home_pembelian_controller.dart';

class HomePembelianView extends GetView<HomePembelianController> {
  const HomePembelianView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Produk'),
          centerTitle: false,
        ),
        body: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  wBigText(text: "Pembelian Produk"),
                  Obx(() {
                    if (controller.ubahHarga.isFalse) {
                      return OutlinedButton(
                          onPressed: () => controller.ubahHarga.toggle(),
                          child: const Text("Ubah harga"));
                    } else {
                      return const SizedBox();
                    }
                  }),
                ],
              ),
              const SizedBox(height: defaultPadding),
              TextField(
                  controller: controller.hargaModal,
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.black,
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'ID',
                      decimalDigits: 0,
                      symbol: 'Rp. ',
                    ),
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Harga modal",
                      labelStyle: TextStyle(
                          color: Colors.black, fontSize: wDimension.font16),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(wDimension.radius30 * 10),
                          borderSide: const BorderSide(color: Colors.red)),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(wDimension.radius30 * 10)),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: wDimension.width30,
                          vertical: wDimension.height15))),
              const SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  wBigText(text: "Jumlah Barang"),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        border: Border.all()),
                    child: Row(
                      children: [
                        FloatingActionButton(
                          heroTag: "decrement",
                          child: const Icon(Icons.add, color: Colors.black87),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            if (controller.jumlah.value > 0) {
                              controller.decrement();
                            } else {
                              Get.snackbar("Peringatan",
                                  "Jumlah tidak boleh kurang dari 0",
                                  duration: const Duration(seconds: 1));
                            }
                          },
                        ),
                        SizedBox(width: wDimension.width20),
                        Obx(() => Text('${controller.jumlah.value}')),
                        SizedBox(width: wDimension.width20),
                        FloatingActionButton(
                          heroTag: "increment",
                          child: const Icon(Icons.add, color: Colors.black87),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            controller.increment();
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: wDimension.height20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  wBigText(text: "Total"),
                  Obx(
                    () => Text('${controller.total}'),
                  )
                ],
              ),
              SizedBox(height: wDimension.height20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      wBigText(text: "Keterangan"),
                      wSmallText(text: "*opsional"),
                      const SizedBox(height: defaultPadding),
                      Container(
                        width: 100,
                        child: TextField(
                            controller: controller.keterangan,
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                labelText: "Keterangan",
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: wDimension.font16),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        wDimension.radius30 * 10),
                                    borderSide:
                                        const BorderSide(color: Colors.red)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        wDimension.radius30 * 10)),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: wDimension.width30,
                                    vertical: wDimension.height15))),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
