import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sikasir/widgets/theme.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/update_keranjang_controller.dart';

class UpdateKeranjangView extends GetView<UpdateKeranjangController> {
  final Map<String, dynamic> datakeranjang = Get.arguments;
  final box = GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    setData();
    return Scaffold(
        appBar: AppBar(
          title: Text(controller.namaProduk.value),
          backgroundColor: Colors.red,
          centerTitle: false,
        ),
        body: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wBigText(text: "Harga"),
                      Obx(() => Text('${controller.hargaJual.value}')),
                    ],
                  ),
                  const Divider(),
                  Obx(() => Visibility(
                      visible: controller.pakaiDiskon.value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          wBigText(text: "Sub-Total"),
                          Text('Rp. ${controller.diskonproduk.value}')
                        ],
                      ))),
                  SizedBox(height: wDimension.height15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wBigText(text: "total"),
                      Obx(() => Text('Rp. ${controller.total.value}')),
                    ],
                  ),
                ],
              ),
              SizedBox(height: wDimension.height30),
              countJumlah(),
              SizedBox(height: wDimension.height20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wBigText(text: "Terapkan diskon"),
                      Obx(() => Switch(
                            value: controller.pakaiDiskon.value,
                            onChanged: (value) {
                              controller.pakaiDiskon.toggle();
                            },
                          ))
                    ],
                  ),
                ],
              ),
              Obx(() => containDiskon()),
              buttonDelete(),
              const Spacer(),
              buttonOk(),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ));
  }

  Row countJumlah() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        wBigText(text: "Jumlah Barang"),
        Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              border: Border.all()),
          child: Row(
            children: [
              FloatingActionButton(
                heroTag: "decrement",
                child: Icon(Icons.remove, color: Colors.black87),
                backgroundColor: Colors.white,
                onPressed: () {
                  if (controller.jumlah.value > 0) {
                    controller.decrement(datakeranjang["id_produk"]);
                  } else {
                    Get.snackbar(
                        "Peringatan", "Jumlah tidak boleh kurang dari 0",
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
                  controller.increment(datakeranjang["id_produk"]);
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  void setData() {
    controller.emailPegawai.value = box.read("userEmail");
    controller.namaProduk.value = datakeranjang["nama_produk"];
    controller.jumlah.value = datakeranjang["jumlah"];
    controller.hargaJual.value = datakeranjang["harga_jual"];
    controller.total.value = datakeranjang["total_harga"];
  }

  Visibility containDiskon() {
    return Visibility(
      visible: controller.pakaiDiskon.value,
      child: Column(
        children: [
          TextField(
              controller: controller.diskon,
              textInputAction: TextInputAction.next,
              cursorColor: Colors.black,
              inputFormatters: <TextInputFormatter>[
                CurrencyTextInputFormatter(
                  locale: 'ID',
                  decimalDigits: 0,
                  symbol: 'Rp. ',
                ),
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Diskon",
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
          SizedBox(height: wDimension.height10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller.namaDiskon,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Nama diskon",
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
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 4, bottom: 18),
                child: wSmallText(text: "*Tidak wajib diisi"),
              )
            ],
          ),
        ],
      ),
    );
  }

  InkWell buttonOk() {
    return InkWell(
      onTap: () {
        if (controller.jumlah.value == 0) {
          controller.deleteKeranjang();
        } else {
          controller.updateKeranjang(datakeranjang["id_produk"]);
          Get.snackbar("Berhasil", "keranjang berhasil ter-update");
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: DesignAppTheme.nearlyBlue,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: DesignAppTheme.nearlyBlue.withOpacity(0.5),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: const Center(
                child: Text(
                  'Ubah keranjang',
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
          )
        ],
      ),
    );
  }

  Row buttonDelete() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Get.defaultDialog(
                  title: "Konfirmasi",
                  content: Column(
                    children: [
                      wSmallText(
                          text: "Apakah anda yakin untuk menghapus produk?"),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("Batal")),
                          ElevatedButton(
                              onPressed: () {
                                controller.deleteKeranjang();
                                Get.back();
                              },
                              child: const Text("Konfirmasi"))
                        ],
                      ),
                    ],
                  ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.delete),
                SizedBox(width: wDimension.width10),
                wBigText(
                  text: "Hapus dari keranjang",
                  color: Colors.white,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Visibility containeDiskon() {
    return Visibility(
      visible: controller.pakaiDiskon.value,
      child: Container(
        child: Column(
          children: [
            TextField(
                controller: controller.diskon,
                textInputAction: TextInputAction.next,
                cursorColor: Colors.black,
                inputFormatters: <TextInputFormatter>[
                  CurrencyTextInputFormatter(
                    locale: 'ID',
                    decimalDigits: 0,
                    symbol: 'Rp. ',
                  ),
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Diskon",
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
            SizedBox(height: wDimension.height10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: controller.namaDiskon,
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Nama produk",
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
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 4),
                  child: wSmallText(text: "*Tidak wajib diisi"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
