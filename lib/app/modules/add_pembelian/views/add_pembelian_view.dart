import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sikasir/app/routes/app_pages.dart';
import 'package:sikasir/widgets/theme.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/add_pembelian_controller.dart';

class AddPembelianView extends GetView<AddPembelianController> {
  const AddPembelianView({Key? key}) : super(key: key);
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
                  OutlinedButton(
                      onPressed: () {}, child: const Text("ubah harga")),
                ],
              ),
              SizedBox(height: defaultPadding),
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
              SizedBox(height: defaultPadding),
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
                          child: Icon(Icons.remove, color: Colors.black87),
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
                          child: Icon(Icons.add, color: Colors.black87),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  wBigText(text: "Total"),
                  Obx(
                    () => Text('${controller.total}'),
                  )
                ],
              ),
              TextField(
                            controller: controller.keterangan,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.sentences,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                labelText: "Keterangan",
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(300),
                                    borderSide:
                                        const BorderSide(color: Colors.red)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(300),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: wDimension.width30,
                                    vertical: wDimension.height15))),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.toNamed(Routes.DETAIL_TRANSAKSI),
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
