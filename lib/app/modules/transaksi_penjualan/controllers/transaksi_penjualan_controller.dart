import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sikasir/app/models/keranjang_model.dart';
import 'package:sikasir/app/models/product_model.dart';
import 'package:sikasir/widgets/widgets.dart';

class TransaksiPenjualanController extends GetxController
    with GetTickerProviderStateMixin {
  AnimationController? animationController;
  late TextEditingController searchC;
  String? uid;
  var ontap = false.obs;
  var queryAwal = [].obs;
  var tempSearch = [].obs;

  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamProduk() {
    return firestore.collection("produk").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamKeranjang(
      String emailUser, String namaProduk) {
    return firestore
        .collection("keranjang")
        .doc(emailUser)
        .collection(namaProduk)
        .snapshots();
  }

  Future<void> addKeranjang(
      Map<String, dynamic> currentUser, ProdukModel dataProduk) async {
    final hargaM =
        int.parse(dataProduk.hargaModal!.replaceAll(RegExp('[^0-9]'), ''));
    final hargaJ =
        int.parse(dataProduk.hargaJual!.replaceAll(RegExp('[^0-9]'), ''));

    if (isLoading.isFalse) {
      isLoading(true);
      var cekKeranjang = await firestore
          .collection("keranjang")
          .doc(currentUser["email_pegawai"])
          .collection(dataProduk.namaProduk!)
          .get();

      if (cekKeranjang.docs.isEmpty) {
        await detailKeranjangAdd(currentUser, dataProduk, hargaJ);

        await keranjangAdd(currentUser, dataProduk);
      } else {
        var idDetail = "";

        await firestore
            .collection("keranjang")
            .doc(currentUser["email_pegawai"])
            .collection(dataProduk.namaProduk!)
            .get()
            .then((QuerySnapshot snapshot) {
          final docs = snapshot.docs;
          for (var data in docs) {
            idDetail = data.id;
            print(data.data());
          }
          print(idDetail);
        });

        final updateKeranjang = await firestore
            .collection("keranjang")
            .doc(currentUser["email_pegawai"])
            .get();

        print(updateKeranjang);
      }

      update();
      isLoading(false);
    }
  }

  Future<void> keranjangAdd(
      Map<String, dynamic> currentUser, ProdukModel dataProduk) async {
    Future<Map<String, dynamic>> keranjang(Map<String, dynamic> data) async {
      try {
        var dataKeranjangBaru = await firestore
            .collection("keranjang")
            .doc(currentUser["email_pegawai"])
            .set(data);

        return {
          "error": false,
          "message": "${dataProduk.namaProduk} ditambahkan ke keranjang",
        };
      } catch (e) {
        return {
          "error": true,
          "message": "Gagal menambah product",
        };
      }
    }

    await keranjang({
      "diskon": 0,
      "nama_diskon": "",
      "email_pegawai": currentUser["email_pegawai"],
      "total": 0,
    });
  }

  Future<void> detailKeranjangAdd(Map<String, dynamic> currentUser,
      ProdukModel dataProduk, int hargaJ) async {
    Future<Map<String, dynamic>> detailKeranjang(
        Map<String, dynamic> data) async {
      try {
        var dataKeranjangBaru = await firestore
            .collection("keranjang")
            .doc(currentUser["email_pegawai"])
            .collection(dataProduk.namaProduk!)
            .add(data);

        return {
          "error": false,
          "message": "${dataProduk.namaProduk} ditambahkan ke keranjang",
        };
      } catch (e) {
        return {
          "error": true,
          "message": "Gagal menambah product",
        };
      }
    }

    await detailKeranjang({
      "id_produk": dataProduk.idProduk,
      "nama_produk": dataProduk.namaProduk,
      "harga_jual": dataProduk.hargaJual,
      "harga_modal": dataProduk.hargaModal,
      "jumlah": 1,
      "total_harga": hargaJ,
    });
  }

  Future<void> searchProduk(String data) async {
    //jika data kosong

    if (data.isEmpty) {
      queryAwal.value = [];
      tempSearch.value = [];
    } else {
      //buat data jadi kapital
      var capitalized = data.substring(0, 1).toUpperCase() + data.substring(1);
      if (queryAwal.isEmpty && data.length == 1) {
        //fungsi yang akan dijalankan pada 1 ketikan pertama
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
        duration: const Duration(milliseconds: 500), vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }
}
