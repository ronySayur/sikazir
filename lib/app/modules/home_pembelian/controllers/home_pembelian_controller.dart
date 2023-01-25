import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../widgets/widgets.dart';

class HomePembelianController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final box = GetStorage();

  final TextEditingController hargaModal = TextEditingController();
  final TextEditingController keterangan = TextEditingController();

  var total = 0.obs;
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

  Future<void> pembelianProduk(String idProduk) async {
    var emailPegawai = box.read('userEmail');
    loading();
    try {
      await firestore.collection("pembelian").add({
        "tanggal": DateTime.now().toIso8601String(),
        "jumlah": jumlah.value,
        "email_pegawai": emailPegawai,
        "total_pembelian": total.value,
        "harga_modal": hargaModal.text,
        "keterangan": keterangan.text,
      });

      await firestore.collection("produk").doc(idProduk).update({
        "stok": jumlah.value,
        "harga_modal": hargaModal.text,
      });

      Get.back();
      Get.back();
      Get.back();
    } catch (e) {
      Get.back();
      Get.back();
      Get.snackbar("Terjadi Kesalahan", "Tidak dapat update keranjang($e)");
    }
  }
}
