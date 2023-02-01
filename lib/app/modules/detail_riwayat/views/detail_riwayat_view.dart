import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/detail_riwayat_controller.dart';

class DetailRiwayatView extends GetView<DetailRiwayatController> {
  var riwayat = Get.arguments;
  final rpid = NumberFormat("#,##0", "ID");
  final dpid = DateFormat('dd-MM-yyyy HH:mm');

  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  DetailRiwayatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('${riwayat["id_penjualan"]}'),
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                children: [
                  SizedBox(height: 20),
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
                  SizedBox(height: 20),
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
                  SizedBox(height: 20),
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
                  SizedBox(height: 20),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                                  return dataKosong("Riwayat trransaksi");
                                }
                                var alldata = snapshot.data!.docs;

                                return Container(
                                    height: wDimension.heightSetengah / 2,
                                    child: ListView.builder(
                                        itemCount: alldata.length,
                                        itemBuilder: (context, index) {
                                          //return tanpa kolom
                                          return ListTile(
                                            leading:
                                                const Icon(Icons.receipt_long),
                                            title: wSmallText(
                                              text:
                                                  "${alldata[index]["nama_produk"]}",
                                              size: 18,
                                              color: Colors.black,
                                              weight: FontWeight.bold,
                                            ),
                                            subtitle: Text(
                                                "${alldata[index]["jumlah"]} barang x ${alldata[index]["harga_jual"]}"),
                                            trailing: Text(
                                                "Rp. ${rpid.format(alldata[index]["total_harga"])}"),
                                          );
                                        }));
                              }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(),
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
                      SizedBox(width: 20),
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
                      SizedBox(width: 20),
                      Text("Rp. ${rpid.format(riwayat["total"])}"),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () async {
                              if ((await printer.isConnected)!) {
                                printer.printNewLine();
                                Image.asset("assets/logo/logo.png");
                                printer.printNewLine();
                                printer.printCustom("Aida Putra Group", 12, 1);
                                printer.printCustom(
                                    " Jl. Mayjen. Sutoyo No.4, Bantul Wr., Bantul, Kec. Bantul, Kabupaten Bantul, Daerah Istimewa Yogyakarta 55711",
                                    8,
                                    1);

                                printer.printNewLine();
                              } else {
                                Get.snackbar("Pemberitahuan",
                                    "Printer belum terkoneksi");
                                Get.defaultDialog(
                                    title: "Koneksikan printer",
                                    textCancel: "Batal",
                                    onCancel: () => Get.back(),
                                    content: DropdownButton<BluetoothDevice>(
                                        items: controller.devices
                                            .map((e) => DropdownMenuItem(
                                                  child: Text(e.name!),
                                                  value: e,
                                                ))
                                            .toList(),
                                        value: controller.selectedDevice,
                                        hint: Text("Pilih printer"),
                                        onChanged: (devices) {
                                          controller.selectedDevice = controller
                                              .devices as BluetoothDevice?;
                                        }));
                              }
                            },
                            child: Center(
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
