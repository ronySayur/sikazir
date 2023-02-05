import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sikasir/app/models/product_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TransaksiPenjualanController extends GetxController
    with GetTickerProviderStateMixin {
  AnimationController? animationController;
  PanelController SUpanel = PanelController();
  final box = GetStorage();
  late TextEditingController searchC;

  String? uid;

  var totalDiskon = 0.obs;
  var totalHarga = 0.obs;

  var emailPegawai = "";

  var ontap = false.obs;
  var queryAwal = [].obs;
  var tempSearch = [].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamProduk() {
    return firestore.collection("produk").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllKeranjang() {
    return firestore
        .collection("keranjang")
        .doc(emailPegawai)
        .collection('produk')
        .snapshots();
  }

  Future<void> tapKeranjangList(ProdukModel dataProduk) async {
    if (dataProduk.stok! > 0) {
      final hjual =
          int.parse(dataProduk.hargaJual!.replaceAll(RegExp('[^0-9]'), ''));

      var cekKeranjang = await firestore
          .collection("keranjang")
          .doc(emailPegawai)
          .collection('produk')
          .doc(dataProduk.namaProduk!)
          .get();


      //Cek keranjang
      if (cekKeranjang.exists) {

        //Jika Keranjang ada update jumlah dan total harga
        await firestore
            .collection("keranjang")
            .doc(emailPegawai)
            .collection('produk')
            .doc(dataProduk.namaProduk!)
            .update({
          "jumlah": FieldValue.increment(1),
          "total_harga": (cekKeranjang.get("jumlah") + 1) * hjual
        });
      } else {

        //jika tidak
        await firestore.collection("keranjang").doc(emailPegawai).set({
          "email_pegawai": emailPegawai,
          "total_harga": 0,
          "total_diskon": 0,
        });
        await firestore
            .collection("keranjang")
            .doc(emailPegawai)
            .collection('produk')
            .doc(dataProduk.namaProduk!)
            .set(({
              "id_produk": dataProduk.idProduk,
              "nama_produk": dataProduk.namaProduk,
              "harga_jual": dataProduk.hargaJual,
              "harga_modal": dataProduk.hargaModal,
              "jumlah": 1,
              "total_harga": totalHarga.value + hjual,
              "diskon": 0,
              "nama_diskon": "",
            }));
      }

      await firestore
          .collection("produk")
          .doc(dataProduk.idProduk)
          .update({"stok": FieldValue.increment(-1)});

      SUpanel.open();
      update();
    } else {
      Get.snackbar("Peringatan", "Produk Habis!",
          backgroundColor: Colors.white, duration: const Duration(seconds: 1));
    }
  }

  Future<void> saveNextToDetail() async {
    await firestore.collection("keranjang").doc(emailPegawai).update({
      "total": totalHarga.value,
      "total_diskon": totalDiskon.value,
    });
  }

  Future<void> searchProduk(String data) async {
    if (data.isEmpty) {
      queryAwal.value = [];
      tempSearch.value = [];
    } else {
      var capitalized = data.substring(0, 1).toUpperCase() + data.substring(1);
      if (queryAwal.isEmpty && data.length == 1) {
        CollectionReference products = firestore.collection("produk");

        final keyNameResult = await products
            .where("keyName", isEqualTo: data.substring(0, 1).toUpperCase())
            .get();

        if (keyNameResult.docs.isNotEmpty) {
          for (int i = 0; i < keyNameResult.docs.length; i++) {
            queryAwal.add(keyNameResult.docs[i].data() as Map<String, dynamic>);
          }
        }
      }

      if (queryAwal.isNotEmpty) {
        tempSearch.value = [];
        queryAwal.forEach((element) {
          if (element["nama_produk"].startsWith(capitalized)) {
            tempSearch.add(element);
          }
        });
      }
    }

    queryAwal.refresh();
    tempSearch.refresh();
  }

  @override
  void onInit() {
    searchC = TextEditingController();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 50), vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }
}
