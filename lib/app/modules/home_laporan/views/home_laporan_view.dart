import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_laporan_controller.dart';

class HomeLaporanView extends GetView<HomeLaporanController> {
  const HomeLaporanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          title: wBigText(text: "Laporan", color: Colors.white),
          centerTitle: false,
        ),
        body: ListView(
          children: [
            ListTile(
              onTap: () => Get.toNamed(Routes.LAPORAN_RANGKUMAN),
              leading: const Icon(Icons.receipt_long),
              title: wSmallText(
                text: "Rangkuman",
                size: 18,
                color: Colors.black,
                weight: FontWeight.bold,
              ),
              trailing: const Icon(Icons.navigate_next),
            ),
            ListTile(
              onTap: () => Get.toNamed(Routes.LAPORAN_RINGKASAN),
              leading: const Icon(Icons.receipt_long),
              title: wSmallText(
                text: "Ringkasan Penjualan",
                size: 18,
                color: Colors.black,
                weight: FontWeight.bold,
              ),
              trailing: const Icon(Icons.navigate_next),
            ),
            ListTile(
              onTap: () => Get.toNamed(Routes.LAPORAN_PRODUK),
              leading: const Icon(Icons.receipt_long),
              title: wSmallText(
                text: "Laporan Produk",
                size: 18,
                color: Colors.black,
                weight: FontWeight.bold,
              ),
              trailing: const Icon(Icons.navigate_next),
            ),
            ListTile(
              onTap: () => Get.toNamed(Routes.LAPORAN_PEMBELIAN),
              leading: const Icon(Icons.receipt_long),
              title: wSmallText(
                text: "Laporan Pembelian",
                size: 18,
                color: Colors.black,
                weight: FontWeight.bold,
              ),
              trailing: const Icon(Icons.navigate_next),
            ),
            ListTile(
              onTap: () => Get.toNamed(Routes.LAPORAN_PENJUALAN),
              leading: const Icon(Icons.receipt_long),
              title: wSmallText(
                text: "Laporan Penjualan",
                size: 18,
                color: Colors.black,
                weight: FontWeight.bold,
              ),
              trailing: const Icon(Icons.navigate_next),
            ),
            ListTile(
              onTap: () => Get.toNamed(Routes.LAPORAN_PEGAWAI),
              leading: const Icon(Icons.receipt_long),
              title: wSmallText(
                text: "Laporan Pegawai",
                size: 18,
                color: Colors.black,
                weight: FontWeight.bold,
              ),
              trailing: const Icon(Icons.navigate_next),
            ),
          ],
        ));
  }
}
