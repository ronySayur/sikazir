import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sikasir/widgets/widgets.dart';

class DetailTransaksiController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final box = GetStorage();

  final TextEditingController uangDiterima = TextEditingController();

  var tagihan = 0.obs;
  var kembalian = 0.obs;
  final date = DateTime.now().toIso8601String();

  cekTagihan() {
    if (uangDiterima.text.isNotEmpty) {
      final ud = int.parse(uangDiterima.text.replaceAll(RegExp('[^0-9]'), ''));

      if (ud < tagihan.value) {
        Get.snackbar("Peringatan", "Uang yang diterima kurang!",
            duration: const Duration(seconds: 1));
      } else if (ud == tagihan.value) {
        Get.snackbar("Informasi", "Uang yang diterima pas",
            duration: const Duration(seconds: 1));

        add();
      } else {
        kembalian.value = ud - tagihan.value;
        Get.snackbar("Informasi", "Kembalian $kembalian",
            duration: const Duration(seconds: 1));
        add();
      }
    } else {
      Get.snackbar("Peringatan", "Isi pembayaran terlebih dahulu !",
          duration: const Duration(seconds: 1));
    }
  }

  Future<void> penjualanDetail() async {
    var emailPegawai = box.read("userEmail");

    QuerySnapshot snaphsot = await firestore
        .collection("keranjang")
        .doc("$emailPegawai")
        .collection('produk')
        .get();

    for (var message in snaphsot.docs) {
      final nama_produk = message["nama_produk"];
      final diskon = message["diskon"];
      final harga_jual = message["harga_jual"];
      final harga_modal = message["harga_modal"];
      final id_produk = message["id_produk"];
      final jumlah = message["jumlah"];
      final nama_diskon = message["nama_diskon"];
      final total_harga = message["total_harga"];

      firestore
          .collection("penjualan")
          .doc(date)
          .collection('produk')
          .doc(nama_produk)
          .set({
        'nama_produk': nama_produk,
        'diskon': diskon,
        'harga_jual': harga_jual,
        'harga_modal': harga_modal,
        'id_produk': id_produk,
        'jumlah': jumlah,
        'nama_diskon': nama_diskon,
        'total_harga': total_harga
      });
    }
  }

  Future<void> add() async {
    if (uangDiterima.text.isNotEmpty) {
      var emailPegawai = box.read("userEmail");
      var toko = box.read("toko");

      firestore.collection("penjualan").doc(date).set({
        "id_penjualan": date,
        "email_pegawai": emailPegawai,
        "tanggal": date,
        "total": uangDiterima.text,
        "id_toko": toko,
      });
      await penjualanDetail();
    } else {
      Get.snackbar("Error", "Semua data wajib diisi.");
    }
  }
}
