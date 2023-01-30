import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/update_keranjang_controller.dart';

class UpdateKeranjangView extends GetView<UpdateKeranjangController> {
  final rpid = NumberFormat("#,##0", "ID");
  final Map<String, dynamic> datakeranjang = Get.arguments;
  final box = GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void setData() {
    controller.emailPegawai.value = box.read("userEmail");
    controller.namaProduk.value = datakeranjang["nama_produk"];
    controller.jumlah.value = datakeranjang["jumlah"];
    controller.hargaJual.value = datakeranjang["harga_jual"];
    controller.total.value = datakeranjang["total_harga"];
    controller.diskon.text = '${datakeranjang["diskon"]}';
    controller.diskonproduk.value = datakeranjang["diskon"];
  }

  @override
  Widget build(BuildContext context) {
    setData();

    return Scaffold(
        appBar: AppBar(
          title: Text(controller.namaProduk.value),
          backgroundColor: Colors.red,
          centerTitle: false,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(defaultPadding),
              child: ListView(
                children: [
                  //Keterangan Harga
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          wBigText(text: "Harga"),
                          Text(controller.hargaJual.value),
                        ],
                      ),
                      const Divider(),
                      Obx(() => Visibility(
                          visible: controller.pakaiDiskon.value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              wBigText(text: "Diskon"),
                              Text(
                                  'Rp ${rpid.format(controller.diskonproduk.value)}'),
                            ],
                          ))),
                      SizedBox(height: wDimension.height15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          wBigText(text: "Total"),
                          Obx(() => Text(
                              'Rp. ${rpid.format(controller.total.value)}'))
                        ],
                      ),
                      SizedBox(height: wDimension.height30)
                    ],
                  ),
                  //Set Jumlah Produk
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
                                child:
                                    Icon(Icons.remove, color: Colors.black87),
                                backgroundColor: Colors.white,
                                onPressed: () => controller
                                    .decrement(datakeranjang["id_produk"])),
                            SizedBox(width: wDimension.width20),
                            Obx(() => Text('${controller.jumlah.value}')),
                            SizedBox(width: wDimension.width20),
                            FloatingActionButton(
                                heroTag: "increment",
                                child: Icon(Icons.add, color: Colors.black87),
                                backgroundColor: Colors.white,
                                onPressed: () => controller
                                    .increment(datakeranjang["id_produk"]))
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Jika ada diskon
                  Column(
                    children: [
                      SizedBox(height: wDimension.height20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          wBigText(text: "Terapkan diskon"),
                          Obx(
                            () => Switch(
                              value: controller.pakaiDiskon.value,
                              onChanged: (value) =>
                                  controller.pakaiDiskon.toggle(),
                            ),
                          ),
                        ],
                      ),
                      Obx(() => Visibility(
                            visible: controller.pakaiDiskon.value,
                            child: Column(
                              children: [
                                TextField(
                                    controller: controller.diskon,
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
                                        labelText: "Diskon",
                                        labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: wDimension.font16),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                wDimension.radius30 * 10),
                                            borderSide: const BorderSide(
                                                color: Colors.red)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                wDimension.radius30 * 10)),
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
                                            color: Colors.black,
                                            fontSize: wDimension.font16),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                wDimension.radius30 * 10),
                                            borderSide: const BorderSide(
                                                color: Colors.red)),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              wDimension.radius30 * 10),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: wDimension.width30,
                                          vertical: wDimension.width15,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 24, top: 4, bottom: 18),
                                      child: wSmallText(
                                          text: "*Tidak wajib diisi"),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: EdgeInsets.only(bottom: 40),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      controller.updateKeranjang(datakeranjang["id_produk"]),
                  child: const Text('Ubah Keranjang '),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(5),
                width: double.infinity,
                child: TextButton(
                    onPressed: () {
                      konfirmasiDelete();
                    },
                    child: wSmallText(
                      text: "Hapus keranjang",
                      color: Colors.red,
                    )),
              ),
            ),
          ],
        ));
  }

  Future<dynamic> konfirmasiDelete() {
    return Get.defaultDialog(
        title: "Konfirmasi",
        content: Column(
          children: [
            wSmallText(text: "Apakah anda yakin untuk menghapus produk?"),
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
                      controller.deleteKeranjang(datakeranjang['id_produk']);
                    },
                    child: const Text("Konfirmasi"))
              ],
            ),
          ],
        ));
  }
}
