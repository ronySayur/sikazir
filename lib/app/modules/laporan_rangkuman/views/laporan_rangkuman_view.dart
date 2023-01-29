import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../../../routes/app_pages.dart';
import '../controllers/laporan_rangkuman_controller.dart';

class LaporanRangkumanView extends GetView<LaporanRangkumanController> {
  LaporanRangkumanView({Key? key}) : super(key: key);
  final rpid = NumberFormat("#,##0", "ID");
  final dpid = DateFormat('dd MMM yyyy, HH:mm', "en_US");

  @override
  Widget build(BuildContext context) {
    controller.count();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(wDimension.height30 * 4.25),
          child: AppBar(
            backgroundColor: Colors.red[900],
            title: wBigText(text: "Rangkuman Transaksi", color: Colors.white),
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
                          icon: wAppIcon(icon: Icons.edit_calendar),
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
            children: [
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: transaksiPenjualanPembelian(),
              ),
              const SizedBox(height: 20),
              totalPenjualanPembelian(),
              const SizedBox(height: 20),
              listriwayat()
            ],
          ),
        ));
  }

  Container listriwayat() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          wBigText(
            text: "Transaksi Penjualan",
            color: Colors.black,
            weight: FontWeight.bold,
            size: 14,
          ),
          wBigText(
            text: "Transaksi yang terakhir tercatat oleh sistem",
            color: Colors.black,
            size: 10,
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: controller.streamTrans(),
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
                              onTap: () => Get.toNamed(Routes.DETAIL_RIWAYAT,
                                  arguments: alldata[index]),
                              leading: const Icon(Icons.receipt_long),
                              title: wSmallText(
                                text: "#${alldata[index]["id_penjualan"]}",
                                size: 18,
                                color: Colors.black,
                                weight: FontWeight.bold,
                              ),
                              subtitle: Text(dpid.format(
                                  DateTime.parse(alldata[index]["tanggal"]))),
                              trailing: Icon(Icons.navigate_next),
                            )
                          ],
                        );
                      }),
                );
              }),
          InkWell(
            onTap: () => Get.toNamed(Routes.RIWAYAT_TRANSAKSI),
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

  Container totalPenjualanPembelian() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            wSmallText(
              text: "Total penjualan",
              size: 17,
              color: Colors.black,
              weight: FontWeight.bold,
            ),
            Obx(() => Text(
                  "Rp. ${rpid.format(controller.totalPenjualan.value)}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.lightBlue),
                )),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            wSmallText(
              text: "Total pembelian",
              size: 17,
              color: Colors.black,
              weight: FontWeight.bold,
            ),
            Obx(() => Text(
                  "Rp. ${rpid.format(controller.totalPembelian.value)}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.orange),
                )),
          ],
        ),
      ]),
    );
  }

  Row transaksiPenjualanPembelian() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          wSmallText(
            text: "Transaksi penjualan",
            size: 17,
            color: Colors.black,
            weight: FontWeight.bold,
          ),
          Obx(() => Text(
                "${controller.jumlahPenjualan.value} Transaksi",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.lightBlue),
              )),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          wSmallText(
            text: "Transaksi pembelian",
            size: 17,
            color: Colors.black,
            weight: FontWeight.bold,
          ),
          Obx(() => Text(
                "${controller.jumlahPembelian.value} Transaksi",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.orange),
              )),
        ],
      ),
    ]);
  }
}
