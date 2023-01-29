import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/detail_riwayat_controller.dart';

class DetailRiwayatView extends GetView<DetailRiwayatController> {
  var riwayat = Get.arguments;
  final rpid = NumberFormat("#,##0", "ID");
  final dpid = DateFormat('HH:mm');

  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  DetailRiwayatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(riwayat["id_penjualan"]as String),
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
                      Text(riwayat["id_penjualan"]as String),
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
                        text: "Tanggal transaksi",
                        color: Colors.black,
                      ),
                      Text(dpid.format(DateTime.parse(riwayat["tanggal"]))),
                    ],
                  ),
                  SizedBox(height: 30),
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
                  )
                ],
              ))
            ],
          ),
        ));
  }
}
