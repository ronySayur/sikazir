import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomePembelianController extends GetxController {
  var total = 0.obs;
  final TextEditingController hargaModal = TextEditingController();
  final TextEditingController keterangan = TextEditingController();
  var ubahHarga = false.obs;
  var jumlah = 0.obs;

  increment() {
    jumlah.value += 1;
    final hargaM = int.parse(hargaModal.text.replaceAll(RegExp('[^0-9]'), ''));
    total.value = jumlah.value * hargaM;
  }

  decrement() {
    jumlah.value -= 1;
    final hargaM = int.parse(hargaModal.text.replaceAll(RegExp('[^0-9]'), ''));
    total.value = jumlah.value * hargaM;
  }
}
