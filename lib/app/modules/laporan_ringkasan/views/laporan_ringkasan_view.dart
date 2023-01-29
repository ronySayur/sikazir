import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/laporan_ringkasan_controller.dart';

class LaporanRingkasanView extends GetView<LaporanRingkasanController> {
  const LaporanRingkasanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              penjualan(),
              const SizedBox(height: 20),
              pembelian(),
              const SizedBox(height: 20),
              labaRugi(),
            ],
          ),
        ));
  }

  Container penjualan() {
    return Container(
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
                wSmallText(
                  text: "Penjualan",
                  size: 28,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    wSmallText(
                      text: "Penjualan kotor",
                      size: 17,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    ),
                    wSmallText(
                      text: "Transaksi penjualan",
                      size: 17,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    wSmallText(
                      text: "Diskon",
                      size: 17,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    ),
                    wSmallText(
                      text: "Transaksi penjualan",
                      size: 17,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    wSmallText(
                      text: "Total Penjualan",
                      size: 17,
                      color: Colors.lightBlue,
                      weight: FontWeight.bold,
                    ),
                    wSmallText(
                      text: "Transaksi penjualan",
                      size: 17,
                      color: Colors.lightBlue,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container pembelian() {
    return Container(
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
                text: "Pembelian",
                size: 28,
                color: Colors.black,
                weight: FontWeight.bold,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  wSmallText(
                    text: "Pembelian",
                    size: 17,
                    color: Colors.black,
                    weight: FontWeight.bold,
                  ),
                  wSmallText(
                    text: "Transaksi penjualan",
                    size: 17,
                    color: Colors.black,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  wSmallText(
                    text: "Total Pembelian",
                    size: 17,
                    color: Colors.orange,
                    weight: FontWeight.bold,
                  ),
                  wSmallText(
                    text: "Transaksi penjualan",
                    size: 17,
                    color: Colors.orange,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ]),
    );
  }

  Container labaRugi() {
    return Container(
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  wSmallText(
                    text: "Total Penjualan",
                    size: 17,
                    color: Colors.black,
                    weight: FontWeight.bold,
                  ),
                  wSmallText(
                    text: "Transaksi penjualan",
                    size: 17,
                    color: Colors.black,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  wSmallText(
                    text: "Total Pembelian",
                    size: 17,
                    color: Colors.black,
                    weight: FontWeight.bold,
                  ),
                  wSmallText(
                    text: "Transaksi penjualan",
                    size: 17,
                    color: Colors.black,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  wSmallText(
                    text: "Keuntungan/Kerugian",
                    size: 17,
                    color: Colors.orange,
                    weight: FontWeight.bold,
                  ),
                  wSmallText(
                    text: "Transaksi penjualan",
                    size: 17,
                    color: Colors.orange,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ]),
    );
  }
}
