import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sikasir/app/routes/app_pages.dart';

import 'package:sikasir/widgets/widgets.dart';
import '../controllers/laporan_produk_controller.dart';

class LaporanProdukView extends GetView<LaporanProdukController> {
  LaporanProdukView({Key? key}) : super(key: key);
  final dpid = DateFormat('dd MMM yyyy, HH:mm', "en_US");

  final rpid = NumberFormat("#,##0", "ID");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(wDimension.height30 * 4.25),
        child: AppBar(
          backgroundColor: Colors.red[900],
          title: wBigText(text: "Laporan Produk", color: Colors.white),
          centerTitle: false,
          flexibleSpace: Padding(
              padding: EdgeInsets.fromLTRB(
                  wDimension.height30,
                  wDimension.height10 * 5,
                  wDimension.height20,
                  wDimension.height20),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextFormField(
                      controller: controller.textFieldTanggal,
                      cursorColor: Colors.red[900],
                      readOnly: true,
                      onTap: () => controller.dateRangePicker(),
                      decoration: InputDecoration(
                        icon: const wAppIcon(icon: Icons.edit_calendar),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(wDimension.height45),
                            borderSide: BorderSide(
                                color: Colors.white,
                                width: wDimension.width10 / 10)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(wDimension.height45),
                            borderSide: BorderSide(
                                color: Colors.white,
                                width: wDimension.width10 / 10)),
                        hintText: "Pilih jangkauan tanggal",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: wDimension.height30,
                            vertical: wDimension.height20),
                      )))),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [produkterjual(), const SizedBox(height: 10), listProduk()],
        ),
      ),
    );
  }

  Container produkterjual() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            wSmallText(
              text: "Total seluruh produk yang sudah terjual",
              size: 17,
              color: Colors.black,
              weight: FontWeight.bold,
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => Text(
                  "${controller.total.value} Produk (${controller.terlaris.value})",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.lightBlue),
                )),
          ],
        ),
      ]),
    );
  }

  Container listProduk() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          wBigText(
            text: "Produk",
            color: Colors.black,
            weight: FontWeight.bold,
            size: 14,
          ),
          wBigText(
            text: "Produk dan sisa akhir stok produk yang tercatat oleh sistem",
            color: Colors.black,
            size: 10,
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.streamProduk(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return dataKosong("Riwayat");
                }
                var alldata = snapshot.data!.docs;

                return Container(
                  height: wDimension.heightSetengah / 2,
                  child: ListView.builder(
                      itemCount: alldata.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () => Get.toNamed(Routes.HOME_PRODUK),
                              leading: const Icon(Icons.receipt_long),
                              title: wSmallText(
                                text: "${alldata[index]["nama_produk"]}",
                                size: 18,
                                color: Colors.black,
                                weight: FontWeight.bold,
                              ),
                              subtitle: Text(
                                  "${alldata[index]["stok"]} Tersisa & ${alldata[index]["terjual"]} Terjual "),
                              trailing: const Icon(Icons.navigate_next),
                            )
                          ],
                        );
                      }),
                );
              }),
          InkWell(
            onTap: () => Get.toNamed(Routes.HOME_PRODUK),
            child: wSmallText(
              text: "Lihat detail",
              size: 12,
              color: Colors.orange,
            ),
          )
        ],
      ),
    );
  }
}
