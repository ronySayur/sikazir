// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sikasir/app/modules/detail_riwayat/controllers/detail_riwayat_controller.dart';

import '../../../routes/app_pages.dart';

class BlueThermaPrintController extends GetxController {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

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
              .then((value) => printData())
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

  void printData() async {
    dynamic result;
    try {
      result = await bluetooth.printNewLine();
    } catch (e) {
      Get.toNamed(Routes.BLUE_THERMA_PRINT);
      box.remove('printer');
    }
    if (await result != null) {
      bluetooth.printNewLine();
      final ByteData bytes =
          await rootBundle.load('assets/logo/whitebglogo.png');
      final Uint8List list = bytes.buffer.asUint8List();
      await bluetooth.printImageBytes(list);
      bluetooth.printNewLine();

      bluetooth.printCustom(
          " Jl. Mayjen. Sutoyo No.4 Bantul Daerah Istimewa Yogyakarta 55711",
          8,
          1);

      bluetooth.printNewLine();

      bluetooth.print4Column("Produk", "Qty", "Harga", "Total", Size.bold.val);

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
