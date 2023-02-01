import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sikasir/app/routes/app_pages.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/laporan_pembelian_controller.dart';

class LaporanPembelianView extends GetView<LaporanPembelianController> {
  LaporanPembelianView({Key? key}) : super(key: key);
  final rpid = NumberFormat("#,##0", "ID");
  final dpid = DateFormat('dd MMM yyyy, HH:mm', "en_US");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(wDimension.height30 * 4.25),
          child: AppBar(
            backgroundColor: Colors.red[900],
            title: wBigText(text: "Laporan Pembelian", color: Colors.white),
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
                              text: "Total pembelian",
                              size: 12,
                              color: Colors.grey,
                            ),
                            Obx(() => Text(
                                  "Rp. ${rpid.format(controller.totalPembelian.value)}",
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
                                  '${rpid.format(controller.jumlahPembelian.value)} transaksi',
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
                      text: "Detail Laporan",
                      color: Colors.black,
                      weight: FontWeight.bold,
                      size: 14,
                    ),
                    const SizedBox(height: 10),
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: controller.streamPembelian(),
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
                                    final email =
                                        dataPegawai[index]["email_pegawai"];
                                    final nama =
                                        dataPegawai[index]["nama_produk"];

                                    return ListTile(
                                      leading: const Icon(Icons.receipt_long),
                                      title: wSmallText(
                                        text: "$nama",
                                        size: 12,
                                        color: Colors.black,
                                        weight: FontWeight.bold,
                                      ),
                                      subtitle: Text(
                                          "${dataPegawai[index]["jumlah"]} barang x ${dataPegawai[index]["harga_modal"]}"),
                                      trailing: Text(
                                          "Rp. ${rpid.format(dataPegawai[index]["total_pembelian"])}"),
                                    );
                                  }));
                        }),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
