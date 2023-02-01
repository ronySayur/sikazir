import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../controllers/laporan_pegawai_controller.dart';
import 'package:sikasir/widgets/widgets.dart';

class LaporanPegawaiView extends GetView<LaporanPegawaiController> {
  LaporanPegawaiView({Key? key}) : super(key: key);
  final rpid = NumberFormat("#,##0", "ID");
  final dpid = DateFormat('dd MMM yyyy, HH:mm', "en_US");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(wDimension.height30 * 4.25),
          child: AppBar(
            backgroundColor: Colors.red[900],
            title: wBigText(text: "Laporan Pegawai", color: Colors.white),
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: wDimension.screenHeight * 0.1,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child: Image.asset("assets/logo/logo.png")),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            wSmallText(
                              text: "Total omset",
                              size: 12,
                              color: Colors.grey,
                            ),
                            Obx(() => Text(
                                  "Rp. ${rpid.format(controller.totalPenjualan.value)}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.lightBlue),
                                )),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            wSmallText(
                              text: "Jumlah transaksi",
                              size: 12,
                              color: Colors.grey,
                            ),
                            Obx(() => Text(
                                  '${rpid.format(controller.jumlahPenjualan.value)} transaksi',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.lightBlue),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    wBigText(
                      text: "Detail Pegawai",
                      color: Colors.black,
                      weight: FontWeight.bold,
                      size: 14,
                    ),
                    const SizedBox(height: 10),
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: controller.streamPegawai(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.none) {
                            return dataKosong("Detail Pegawai");
                          }
                          var dataPegawai = snapshot.data!.docs;

                          return Container(
                              height: wDimension.heightSetengah / 2,
                              child: ListView.builder(
                                  itemCount: dataPegawai.length,
                                  itemBuilder: (context, index) {
                                    final namaPegawai =
                                        dataPegawai[index]["nama_pegawai"];
                                        
                                    controller.countDetail(
                                        dataPegawai[index]["email_pegawai"]);
                                    //return tanpa kolom
                                    return ListTile(
                                      leading: const Icon(Icons.receipt_long),
                                      title: wSmallText(
                                        text: "$namaPegawai",
                                        size: 14,
                                        color: Colors.black,
                                        weight: FontWeight.bold,
                                      ),
                                      // subtitle: Obx(() => Text(
                                      //       "Rp. ${rpid.format(controller.detailtotal.value)}",
                                      //       style: TextStyle(
                                      //           fontWeight: FontWeight.bold,
                                      //           fontSize: 12,
                                      //           color: Colors.lightBlue),
                                      //     )),
                                      trailing: const Icon(Icons.navigate_next),
                                    );
                                  }));
                        }),
                    InkWell(
                      onTap: () => Get.toNamed(Routes.RIWAYAT_TRANSAKSI),
                      child: wSmallText(
                        text: "Lihat detail",
                        size: 12,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
