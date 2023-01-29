import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sikasir/widgets/widgets.dart';

class UpdateKeranjangController extends GetxController {
  final TextEditingController namaDiskon = TextEditingController();
  final TextEditingController diskon = TextEditingController();
  RxBool isLoading = false.obs;
  var pakaiDiskon = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final box = GetStorage();

  var emailPegawai = "".obs;
  var namaProduk = "".obs;
  var hargaJual = "".obs;

  var jumlahAwal = 0.obs;
  var jumlah = 0.obs;
  var total = 0.obs;
  var diskonproduk = 0.obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamProduk() {
    return firestore.collection("produk").snapshots();
  }

  increment(String idProduk) async {
    var dataProduk = await firestore.collection("produk").doc(idProduk).get();

    if (dataProduk.get("stok") > 0) {
      jumlah.value += 1;
      await firestore
          .collection("produk")
          .doc(idProduk)
          .update({"stok": FieldValue.increment(-1)});
    } else {
      Get.snackbar("Peringatan", "Produk Habis!",
          backgroundColor: Colors.white, duration: const Duration(seconds: 1));
    }
  }

  willpop(String idProduk) async {
    await firestore
        .collection("produk")
        .doc(idProduk)
        .update({"stok": jumlahAwal.value});

    Get.snackbar("Pemberitahuan", "Data produk berhasil dikembalikan!",
        backgroundColor: Colors.white, duration: const Duration(seconds: 1));
  }

  decrement(String idProduk) async {
    if (jumlah.value > 1) {
      jumlah.value -= 1;
      await firestore
          .collection("produk")
          .doc(idProduk)
          .update({"stok": FieldValue.increment(-1)});
    }
  }

  Future<void> updateKeranjang(String idProduk) async {
    await firestore
        .collection("keranjang")
        .doc("$emailPegawai")
        .collection('produk')
        .doc(namaProduk.value)
        .update({
      "total_harga": total.value,
      "jumlah": jumlah.value,
      "diskon": int.parse(diskon.text),
      "nama_diskon": namaDiskon.text,
    });
  }

  Future<void> deleteKeranjang(String idProduk, int jumlahawal) async {
    loading();
    var dataProduk = await firestore.collection("produk").doc(idProduk).get();

    await firestore
        .collection("produk")
        .doc(idProduk)
        .update({"stok": dataProduk.get("stok") + jumlahawal});

    await firestore
        .collection("keranjang")
        .doc("$emailPegawai")
        .collection('produk')
        .doc(namaProduk.value)
        .delete();

    //close loading
    Get.back();
    //close confirm
    Get.back();
    //back to transaksi
    Get.back();
  }
}
