import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sikasir/widgets/widgets.dart';

class DetailTransaksiController extends GetxController {
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  
  final TextEditingController uangDiterima = TextEditingController();

  var tagihan = 0.obs;
  var kembalian = 0.obs;

  cekTagihan() {
    final ud = int.parse(uangDiterima.text.replaceAll(RegExp('[^0-9]'), ''));

    if (ud < tagihan.value) {
      Get.snackbar("Peringatan", "Uang yang diterima kurang!");
    } else if (ud == tagihan.value) {
      Get.snackbar("Informasi", "Uang yang diterima pas");
    } else {
      kembalian.value = ud - tagihan.value;
      Get.snackbar("Informasi", "Kembalian $kembalian");
    }
  }

    Future<void> add() async {

        Map<String, dynamic> hasil = await afterAddData({
          // "keyName": namaToko.text.substring(0, 1).toUpperCase(),
          // "id_toko": "id",
          // "nama_toko": namaToko.text,
          // "email_toko": emailToko.text,
          // "alamat": alamatToko.text,
          // "no_telp": telpToko.text
        });


        Get.snackbar(
            hasil["error"] == true ? "Error" : "Success", hasil["message"]);
      } 

        Future<Map<String, dynamic>> afterAddData(Map<String, dynamic> data) async {
    try {
      loading();
      var transaksi = await firestore.collection("transaksi").add(data);
      await firestore
          .collection("transaksi")
          .doc(transaksi.id)
          .update({"id_transaksi": transaksi.id});

      Get.back();
      Get.back();
      return {
        "error": false,
        "message": "Berhasil menambah product.",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Tidak dapat menambah product.",
      };
    }
  }
    
  


}
