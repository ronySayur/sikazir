// ignore_for_file: avoid_print

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';

class BlueThermaPrintController extends GetxController {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  final rpid = NumberFormat("#,##0", "ID");
  final dpid = DateFormat('dd-MM-yyyy HH:mm');

  RxList<BluetoothDevice> devices = <BluetoothDevice>[].obs;
  BluetoothDevice? device;
  final RxBool _connected = false.obs;
  final RxBool isConnected = false.obs;
  final String devicesMsg = 'tidak ada perangkat';
  final box = GetStorage();

  @override
  void onInit() {
    initPlatformState();
    super.onInit();
  }

  @override
  void onClose() {
    if (isConnected.value == true) {
      bluetooth.disconnect();
    }
    if (EasyLoading.isShow) return;
    super.onClose();
  }

  onRefresh() async {
    try {
      devices.value = await bluetooth.getBondedDevices();
    } catch (e) {
      print("terjadi kesalahan $e");
    }
  }

  Future<void> initPlatformState() async {
    isConnected.value = (await bluetooth.isConnected)!;
    try {
      devices.value = await bluetooth.getBondedDevices();
    } catch (e) {
      print("terjadi kesalahan $e");
    }

    bluetooth.onStateChanged().listen((state) async {
      if (EasyLoading.isShow) return;
      await EasyLoading.show();
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          _connected.value = true;
          await Future.delayed(const Duration(milliseconds: 500))
              .then((value) => Get.snackbar(
                  "Pemberitahuan", "Printer Terkoneksi",
                  backgroundColor: Colors.white))
              .then((value) => box.write('printer', device!.toMap()))
              .then((value) => Get.back());
          break;
        case BlueThermalPrinter.DISCONNECTED:
          _connected.value = false;
          break;
        case BlueThermalPrinter.STATE_OFF:
          _connected.value = false;
          print("dialog harap hidupkan bluetooth anda");
          break;
        case BlueThermalPrinter.ERROR:
          _connected.value = false;
          break;
        default:
          break;
      }
      EasyLoading.dismiss();
    });

    if (isConnected.value == true) {
      _connected.value = true;
    }
  }

  void connect(BluetoothDevice connDevice) async {
    if (EasyLoading.isShow) return;
    await EasyLoading.show();
    if (connDevice.name != null) {
      bluetooth.isConnected.then((isConnected) {
        if (isConnected == false) {
          bluetooth.connect(connDevice).catchError((error) {
            _connected.value == false;
            Get.toNamed(Routes.BLUE_THERMA_PRINT);
            box.remove('printer');
          });
          _connected.value == true;
        }
      });
    } else {
      const SnackBar(
        content: Text('Tidak ada perangkat dipilih'),
      );
    }
    EasyLoading.dismiss();
  }

  printData(List<dynamic> dataDetail, List<dynamic> data) async {
    dynamic result;
    try {
      result = await bluetooth.printNewLine();
    } catch (e) {
      Get.toNamed(Routes.BLUE_THERMA_PRINT);
      box.remove('printer');
    }
    if (await result != null) {
      final ByteData bytes =
          await rootBundle.load('assets/logo/whitebglogo.png');
      final Uint8List list = bytes.buffer.asUint8List();
      await bluetooth.printImageBytes(list);
      bluetooth.printNewLine();

      bluetooth.printCustom(
          "Jl. Mayjen. Sutoyo No.4 Bantul\nDaerah Istimewa Yogyakarta 55711",
          0,
          1);

      bluetooth.printNewLine();
      bluetooth.printCustom(
          "${data[0]["id_penjualan"]}"
              .replaceAll("-", "")
              .replaceAll(":", "")
              .replaceAll(" ", "")
              .replaceAll(".", ""),
          Size.medium.val,
          2);

      bluetooth.printLeftRight(
          "Tanggal:", "${data[0]["groupTanggal"]}", Size.medium.val);
      bluetooth.printLeftRight(
          "Pegawai:",
          "${data[0]["email_pegawai"]}".replaceAll("@gmail.com", ""),
          Size.medium.val);
      bluetooth.printLeftRight(
          "Toko:", "${data[0]["id_toko"]}", Size.medium.val);

      bluetooth.printCustom(
          "--------------------------------", Size.medium.val, 1);

      bluetooth.printLeftRight("Deskripsi", "Total", Size.bold.val);
      bluetooth.printCustom(
          "--------------------------------", Size.medium.val, 1);

      for (var i = 0; i < dataDetail.length; i++) {
        bluetooth.printLeftRight(
            "${dataDetail[i]["nama_produk"]}", "", Size.bold.val);

        bluetooth.printLeftRight(
            "${dataDetail[i]["jumlah"]} x ${dataDetail[i]["harga_jual"]}",
            "Rp. ${rpid.format(dataDetail[i]["total_harga"])}",
            Size.medium.val);
      }
      bluetooth.printCustom(
          "--------------------------------", Size.medium.val, 1);

      bluetooth.printLeftRight(
          "Diterima", "${data[0]["diterima"]}", Size.bold.val);
      bluetooth.printLeftRight("Kembalian",
          "Rp. ${rpid.format(data[0]["kembalian"])}", Size.bold.val);
      bluetooth.printLeftRight("Diskon",
          "Rp. ${rpid.format(data[0]["total_diskon"])}", Size.bold.val);
      bluetooth.printLeftRight(
          "Total", "Rp. ${rpid.format(data[0]["total"])}", Size.bold.val);
      bluetooth.printCustom(
          "--------------------------------", Size.medium.val, 1);
      bluetooth.printCustom(dpid.format(DateTime.now()), Size.medium.val, 1);
      bluetooth.printCustom(
          "--------------------------------", Size.medium.val, 1);
      bluetooth.printNewLine();
      bluetooth.printNewLine();

      bluetooth.paperCut();
    }
    return;
  }
}

enum Size {
  medium, //normal size text
  bold, //only bold text
  boldMedium, //bold with medium
  boldLarge, //bold with large
  extraLarge //extra large
}

enum Align {
  left, //ESC_ALIGN_LEFT
  center, //ESC_ALIGN_CENTER
  right, //ESC_ALIGN_RIGHT
}

extension PrintSize on Size {
  int get val {
    switch (this) {
      case Size.medium:
        return 0;
      case Size.bold:
        return 1;
      case Size.boldMedium:
        return 2;
      case Size.boldLarge:
        return 3;
      case Size.extraLarge:
        return 4;
      default:
        return 0;
    }
  }
}

extension PrintAlign on Align {
  int get val {
    switch (this) {
      case Align.left:
        return 0;
      case Align.center:
        return 1;
      case Align.right:
        return 2;
      default:
        return 0;
    }
  }
}
