import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/transaksi_selesai_controller.dart';

class TransaksiSelesaiView extends GetView<TransaksiSelesaiController> {
  final String date = Get.arguments;
  final rpid = NumberFormat("#,##0", "ID");
  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  TransaksiSelesaiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.penjualanDetail(date);
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              logoLottie(),
              Des(context),
            ],
          )),
    );
  }

  Expanded Des(BuildContext context) {
    return Expanded(
        flex: 2,
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: controller.streamTransksi(date),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              Map<String, dynamic> transaksi = snapshot.data!.data()!;
              String tgl = DateFormat('dd-MMM-yyyy, kk:mm')
                  .format(DateTime.parse(transaksi['tanggal']));

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          wBigText(
                            text: "Transaksi Berhasil",
                            color: Colors.black,
                            size: 28,
                            weight: FontWeight.bold,
                          ),
                          wBigText(text: tgl, size: 22, color: Colors.black),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: wDimension.height30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wBigText(
                          text: "Ditangani oleh",
                          size: 22,
                          color: Colors.black),
                      Text("${transaksi['email_pegawai']}")
                    ],
                  ),
                  SizedBox(height: wDimension.height20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wBigText(
                          text: "Total tagihan", size: 22, color: Colors.black),
                      Text("Rp. ${rpid.format(transaksi['total'])}")
                    ],
                  ),
                  SizedBox(height: wDimension.height20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wBigText(text: "Diterima", size: 22, color: Colors.black),
                      Text("${transaksi['diterima']}")
                    ],
                  ),
                  SizedBox(height: wDimension.height20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wBigText(
                          text: "Kembalian", size: 22, color: Colors.black),
                      Text("Rp. ${rpid.format(transaksi['kembalian'])}")
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => controller.printerState(),
                          child: const Text("Cetak Struk"),
                        ),
                      ),
                      SizedBox(width: wDimension.width20),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              int times = 2;
                              Get.close(times);
                            },
                            child: const Text("Transaksi Baru")),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom)
                ],
              );
            }));
  }

  Expanded logoLottie() {
    return Expanded(
      flex: 1,
      child: Center(
        child: Lottie.asset("assets/lottie/transaksisukses.json"),
      ),
    );
  }
}
