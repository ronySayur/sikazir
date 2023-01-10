import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import 'constants.dart';

class CloudStorageInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;
  final VoidCallback? press;

  CloudStorageInfo({
    this.press,
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    press: () {},
    title: "Transaksi",
    numOfFiles: 1328,
    svgSrc: "assets/icons/menu_tran.svg",
    totalStorage: "1.9GB",
    color: primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    press: () {},
    title: "Produk",
    numOfFiles: 1328,
    svgSrc: "assets/icons/menu_store.svg",
    totalStorage: "2.9GB",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  CloudStorageInfo(
    press: () {},
    title: "Supplier",
    numOfFiles: 1328,
    svgSrc: "assets/icons/one_drive.svg",
    totalStorage: "1GB",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  CloudStorageInfo(
    press: () {},
    title: "Toko",
    numOfFiles: 5328,
    svgSrc: "assets/icons/toko.svg",
    totalStorage: "7.3GB",
    color: Color.fromARGB(255, 13, 23, 32),
    percentage: 78,
  ),

  //Add Pegawai
  CloudStorageInfo(
    //TODO Hitung jumlah pegawai di db
    press: () => Get.toNamed(Routes.ADD_PEGAWAI),
    title: "Pegawai",
    numOfFiles: 8,
    svgSrc: "assets/icons/drop_box.svg",
    totalStorage: "7.3GB",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),

  //Laporan
  CloudStorageInfo(
    press: () {},
    title: "Laporan",
    numOfFiles: 5328,
    svgSrc: "assets/icons/drop_box.svg",
    totalStorage: "7.3GB",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];
