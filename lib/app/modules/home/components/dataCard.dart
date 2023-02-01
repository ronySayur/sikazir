import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

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

List menuAdmin = [
  CloudStorageInfo(
    press: () => Get.toNamed(Routes.TRANSAKSI_PENJUALAN),
    title: "Transaksi",
    svgSrc: "assets/icons/transactions.svg",
    numOfFiles: 1328,
    totalStorage: "1.9GB",
    color: Colors.red,
    percentage: 35,
  ),
  CloudStorageInfo(
    press: () => Get.toNamed(Routes.HOME_PRODUK),
    title: "Produk",
    svgSrc: "assets/icons/product.svg",
    numOfFiles: 1328,
    totalStorage: "2.9GB",
    color: Colors.amber,
    percentage: 35,
  ),
  CloudStorageInfo(
    press: () => Get.toNamed(Routes.HOME_SUPPLIER),
    title: "Supplier",
    svgSrc: "assets/icons/supplier.svg",
    numOfFiles: 1328,
    totalStorage: "1GB",
    color: Colors.grey,
    percentage: 10,
  ),
  CloudStorageInfo(
    press: () => Get.toNamed(Routes.HOME_TOKO),
    title: "Toko",
    svgSrc: "assets/icons/toko.svg",
    numOfFiles: 5328,
    totalStorage: "7.3GB",
    color: Colors.green,
    percentage: 78,
  ),
  CloudStorageInfo(
    press: () => Get.toNamed(Routes.HOME_PEGAWAI),
    title: "Pegawai",
    svgSrc: "assets/icons/employee.svg",
    numOfFiles: 8,
    totalStorage: "7.3GB",
    color: Colors.lightBlue,
    percentage: 78,
  ),
  CloudStorageInfo(
    press: () => Get.toNamed(Routes.HOME_LAPORAN),
    title: "Laporan",
    svgSrc: "assets/icons/reports.svg",
    numOfFiles: 5328,
    totalStorage: "7.3GB",
    color: Colors.orange,
    percentage: 78,
  ),
];
List menuSPV = [
  CloudStorageInfo(
    press: () => Get.toNamed(Routes.HOME_PEGAWAI),
    title: "Pegawai",
    svgSrc: "assets/icons/employee.svg",
    numOfFiles: 8,
    totalStorage: "7.3GB",
    color: Colors.lightBlue,
    percentage: 78,
  ),
  CloudStorageInfo(
    press: () => Get.toNamed(Routes.HOME_LAPORAN),
    title: "Laporan",
    svgSrc: "assets/icons/reports.svg",
    numOfFiles: 5328,
    totalStorage: "7.3GB",
    color: Colors.orange,
    percentage: 78,
  ),
];

List menuGudang = [
  CloudStorageInfo(
    press: () => Get.toNamed(Routes.HOME_PRODUK),
    title: "Produk",
    svgSrc: "assets/icons/product.svg",
    numOfFiles: 1328,
    totalStorage: "2.9GB",
    color: Colors.amber,
    percentage: 35,
  ),
  CloudStorageInfo(
    press: () => Get.toNamed(Routes.HOME_SUPPLIER),
    title: "Supplier",
    svgSrc: "assets/icons/supplier.svg",
    numOfFiles: 1328,
    totalStorage: "1GB",
    color: Colors.grey,
    percentage: 10,
  ),
];

List menuKasir = [
  CloudStorageInfo(
    press: () => Get.toNamed(Routes.TRANSAKSI_PENJUALAN),
    title: "Transaksi",
    svgSrc: "assets/icons/transactions.svg",
    numOfFiles: 1328,
    totalStorage: "1.9GB",
    color: Colors.red,
    percentage: 35,
  ),
  CloudStorageInfo(
    press: () => Get.toNamed(Routes.HOME_PRODUK),
    title: "Produk",
    svgSrc: "assets/icons/product.svg",
    numOfFiles: 1328,
    totalStorage: "2.9GB",
    color: Colors.amber,
    percentage: 35,
  ),
];
