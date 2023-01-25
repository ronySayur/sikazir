import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sikasir/app/models/product_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TransaksiPenjualanController extends GetxController
    with GetTickerProviderStateMixin {
  AnimationController? animationController;
  PanelController SUpanel = new PanelController();

  late TextEditingController searchC;
  String? uid;
  RxBool isLoading = false.obs;

  var totalHarga = 0.obs;

  final box = GetStorage();
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

  // Future<void> addKeranjangStorage(
  //     Map<String, dynamic> currentUser, ProdukModel dataProduk) async {

  //   Map<String, dynamic> keranjangList = {
  //     "id_produk": dataProduk.idProduk,
  //     "nama_produk": dataProduk.namaProduk,
  //     "harga_jual": dataProduk.hargaJual,
  //     "harga_modal": dataProduk.hargaModal,
  //     "jumlah": 1,
  //     "total_harga": "hargaJ"
  //   };

  //   String jsonString = jsonEncode(keranjangList);
  //   await box.write('keranjang', jsonString);
  // }

  // showKeranjang() async {
  //   var result = box.read('keranjang');
  //   Map<String, dynamic> jsonData = jsonDecode(result);
  // }

  Future<void> addKeranjang(ProdukModel dataProduk) async {
    final hargaM =
        int.parse(dataProduk.hargaModal!.replaceAll(RegExp('[^0-9]'), ''));
    final hargaJ =
        int.parse(dataProduk.hargaJual!.replaceAll(RegExp('[^0-9]'), ''));

    var cekKeranjang = await firestore
        .collection("keranjang")
        .doc("$emailPegawai")
        .collection('produk')
        .doc(dataProduk.namaProduk!)
        .get();

    if (cekKeranjang.exists) {
      await updateKeranjang(dataProduk);
    } else {
      await addKeranjangProduk(dataProduk, hargaJ);

      await keranjangAdd(dataProduk);
    }
    totalHarga += hargaJ;
    SUpanel.open();
    update();
  }

  Future<void> updateKeranjang(ProdukModel dataProduk) async {

    await firestore
        .collection("keranjang")
        .doc("$emailPegawai")
        .collection('produk')
        .doc(dataProduk.namaProduk!)
        .get()
        .then((DocumentSnapshot snapshot) {
      Map<String, dynamic> cole = snapshot.data() as Map<String, dynamic>;

      final hjual =
          int.parse(cole["harga_jual"].replaceAll(RegExp('[^0-9]'), ''));
      var jumlahPlus1 = cole["jumlah"] + 1;
      
      var harga = jumlahPlus1 * hjual;

      firestore
          .collection("keranjang")
          .doc("$emailPegawai")
          .collection('produk')
          .doc(dataProduk.namaProduk!)
          .update({"total_harga": harga, "jumlah": jumlahPlus1});
    });

    // firestore
    //     .collection("keranjang")
    //     .doc("$emailPegawai")
    //     .update({"total": totalHarga});
  }

  Future<void> keranjangAdd(ProdukModel dataProduk) async {
    Future<Map<String, dynamic>> keranjang(Map<String, dynamic> data) async {
      try {
        var dataKeranjangBaru = await firestore
            .collection("keranjang")
            .doc("$emailPegawai")
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
      "email_pegawai": emailPegawai,
      "total": 0,
    });
  }

  Future<void> addKeranjangProduk(ProdukModel dataProduk, int hargaJ) async {
    Future<Map<String, dynamic>> keranjangProduk(
        Map<String, dynamic> data) async {
      var emailPegawai = box.read('userEmail');

      try {
        var dataKeranjangBaru = await firestore
            .collection("keranjang")
            .doc(emailPegawai)
            .collection('produk')
            .doc(dataProduk.namaProduk!)
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

    await keranjangProduk({
      "id_produk": dataProduk.idProduk,
      "nama_produk": dataProduk.namaProduk,
      "harga_jual": dataProduk.hargaJual,
      "harga_modal": dataProduk.hargaModal,
      "jumlah": 1,
      "total_harga": hargaJ,
      "diskon": 0,
      "nama_diskon": "",
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
        duration: const Duration(milliseconds: 50), vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }
}
