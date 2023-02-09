import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/detail_riwayat_controller.dart';

class DetailRiwayatView extends GetView<DetailRiwayatController> {
  var riwayat = Get.arguments;
  List<DropdownMenuItem<BluetoothDevice>> items = [];
  final rpid = NumberFormat("#,##0", "ID");
  final dpid = DateFormat('dd-MM-yyyy HH:mm');

  DetailRiwayatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.penjualanDetail(riwayat["id_penjualan"]);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('${riwayat["id_penjualan"]}'),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wBigText(
                        text: "Detail Transaksi",
                        color: Colors.black,
                      ),
                      Text(riwayat["id_penjualan"] as String),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wBigText(
                        text: "Pegawai",
                        color: Colors.black,
                      ),
                      Text('${riwayat["email_pegawai"]}'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wBigText(
                        text: "Toko",
                        color: Colors.black,
                      ),
                      Text('${riwayat["id_toko"]}'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wBigText(
                        text: "Tanggal transaksi",
                        color: Colors.black,
                      ),
                      Text(dpid.format(DateTime.parse(riwayat["tanggal"]))),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
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
                            stream: controller
                                .streamPenjualan(riwayat["id_penjualan"]),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.none) {
                                return dataKosong("Riwayat transaksi");
                              }
                              var data = snapshot.data!.docs;
                              return Container(
                                  height: wDimension.heightSetengah / 2,
                                  child: ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        //return tanpa kolom
                                        return ListTile(
                                          leading:
                                              const Icon(Icons.receipt_long),
                                          title: wSmallText(
                                            text:
                                                "${data[index]["nama_produk"]}",
                                            size: 18,
                                            color: Colors.black,
                                            weight: FontWeight.bold,
                                          ),
                                          subtitle: Text(
                                              "${data[index]["jumlah"]} barang x ${data[index]["harga_jual"]}"),
                                          trailing: Text(
                                              "Rp. ${rpid.format(data[index]["total_harga"])}"),
                                        );
                                      }));
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      wBigText(
                        text: "Total Diskon",
                        size: 18,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 20),
                      Text("Rp. ${rpid.format(riwayat["total_diskon"])}"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      wBigText(
                        text: "Total Transaksi",
                        size: 18,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 20),
                      Text("Rp. ${rpid.format(riwayat["total"])}"),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () => controller.printerState(),
                            child: const Center(
                              child: Text("Cetak Struk"),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom)
                ],
              ))
            ],
          ),
        ));
  }
}
