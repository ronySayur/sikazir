import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/laporan_ringkasan_controller.dart';

class LaporanRingkasanView extends GetView<LaporanRingkasanController> {
  LaporanRingkasanView({Key? key}) : super(key: key);
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
            title: wBigText(text: "Ringkasan Laporan", color: Colors.white),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                wSmallText(
                                  text: "Penjualan",
                                  size: 28,
                                  color: Colors.black,
                                  weight: FontWeight.bold,
                                ),
                                Obx(() => Text(
                                      "${controller.jumlahPenjualan.value} transaksi",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black87),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                wSmallText(
                                  text: "Penjualan kotor",
                                  size: 17,
                                  color: Colors.black,
                                  weight: FontWeight.bold,
                                ),
                                Obx(() => Text(
                                      "Rp. ${rpid.format(controller.totalPenjualan.value)}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.black87),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                wSmallText(
                                  text: "Diskon",
                                  size: 17,
                                  color: Colors.black,
                                  weight: FontWeight.bold,
                                ),
                                Obx(() => Text(
                                      "Rp. ${rpid.format(controller.totalDiskon.value)}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.black87),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                wSmallText(
                                  text: "Total Penjualan",
                                  size: 17,
                                  color: Colors.lightBlue,
                                  weight: FontWeight.bold,
                                ),
                                Obx(() => Text(
                                      "Rp. ${rpid.format(controller.totalPenjualan.value - controller.totalDiskon.value)}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.lightBlue),
                                    )),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              wSmallText(
                                text: "Pembelian",
                                size: 28,
                                color: Colors.black,
                                weight: FontWeight.bold,
                              ),
                              Obx(() => Text(
                                    "${controller.jumlahPembelian.value} transaksi",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black87),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              wSmallText(
                                text: "Pembelian",
                                size: 17,
                                color: Colors.black,
                                weight: FontWeight.bold,
                              ),
                              Obx(() => Text(
                                    "Rp. ${rpid.format(controller.totalPembelian.value)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.black87),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              wSmallText(
                                text: "Total Pembelian",
                                size: 17,
                                color: Colors.orange,
                                weight: FontWeight.bold,
                              ),
                              Obx(() => Text(
                                    "Rp. ${rpid.format(controller.totalPembelian.value)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.orange),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          wSmallText(
                            text: "Laba/Rugi",
                            size: 28,
                            color: Colors.black,
                            weight: FontWeight.bold,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              wSmallText(
                                text: "Total Penjualan",
                                size: 17,
                                color: Colors.black,
                                weight: FontWeight.bold,
                              ),
                              Obx(() => Text(
                                    "Rp. ${rpid.format(controller.totalPenjualan.value - controller.totalDiskon.value)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.black87),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              wSmallText(
                                text: "Total Pembelian",
                                size: 17,
                                color: Colors.black,
                                weight: FontWeight.bold,
                              ),
                              Obx(() => Text(
                                    "Rp. ${rpid.format(controller.totalPembelian.value)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.black87),
                                  )),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                if (controller.totalLR.value > 0) {
                                  return Text(
                                    "Keuntungan",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.green),
                                  );
                                } else {
                                  return Text(
                                    "Kerugian",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.red),
                                  );
                                }
                              }),
                              Obx(() {
                                if (controller.totalLR.value > 0) {
                                  return Text(
                                    "Rp. ${rpid.format(controller.totalLR.value)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.green),
                                  );
                                } else {
                                  return Text(
                                    "Rp. ${rpid.format(controller.totalLR.value)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.red),
                                  );
                                }
                              }),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            )));
  }
}
