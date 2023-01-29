import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sikasir/app/models/product_model.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../../../../widgets/theme.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_pembelian_controller.dart';

class HomePembelianView extends GetView<HomePembelianController> {
  final ProdukModel dataprod = Get.arguments;
  final rpid =  NumberFormat("#,##0", "ID");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('${dataprod.namaProduk}'),
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
              Obx(() {
                if (controller.ubahHarga.isTrue) {
                  controller.hargaModal.text = '0';
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wBigText(text: "Harga modal"),
                      Container(
                        width: wDimension.screenWidth / 2,
                        child: TextField(
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
                  );
                } else {
                  controller.hargaModal.text = dataprod.hargaModal!;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wBigText(text: "Harga modal"),
                      Text('${dataprod.hargaModal}'),
                    ],
                  );
                }
              }),
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
                    () => Text(
                      'Rp. ${rpid.format(controller.total.value)}',
                    ),
                  )
                ],
              ),
              SizedBox(height: wDimension.height20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      wBigText(text: "Keterangan"),
                      wSmallText(text: "*opsional"),
                      const SizedBox(height: defaultPadding),
                      Container(
                        width: wDimension.screenWidth / 1.5,
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
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        controller.pembelianProduk('${dataprod.idProduk}');
                      },
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: DesignAppTheme.nearlyBlue,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    DesignAppTheme.nearlyBlue.withOpacity(0.5),
                                offset: const Offset(1.1, 1.1),
                                blurRadius: 10.0)
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "Simpan",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              letterSpacing: 0.0,
                              color: DesignAppTheme.nearlyWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom)
            ],
          ),
        ));
  }
}
