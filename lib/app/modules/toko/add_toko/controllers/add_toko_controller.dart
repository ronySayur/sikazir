import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sikasir/widgets/widgets.dart';

class AddTokoController extends GetxController with StateMixin {
  
  String? uid;
  RxBool isLoading = false.obs;

  final TextEditingController namaToko = TextEditingController();
  final TextEditingController telpToko = TextEditingController();
  final TextEditingController alamatToko = TextEditingController();
  final TextEditingController emailToko = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamToko() async* {
    yield* firestore.collection("toko").doc().snapshots();
  }

  Future<void> add() async {
    if (isLoading.isFalse) {
      if (namaToko.text.isNotEmpty &&
          telpToko.text.isNotEmpty &&
          emailToko.text.isNotEmpty &&
          alamatToko.text.isNotEmpty) {
        isLoading(true);

        Map<String, dynamic> hasil = await afterAddData({
          "keyName": namaToko.text.substring(0, 1).toUpperCase(),
          "id_toko": "id",
          "nama_toko": namaToko.text,
          "email_toko": emailToko.text,
          "alamat": alamatToko.text,
          "no_telp": telpToko.text
        });

        isLoading(false);

        Get.snackbar(
            hasil["error"] == true ? "Error" : "Success", hasil["message"]);
      } else {
        Get.snackbar("Error", "Semua data wajib diisi.");
      }
    }
  }

  Future<Map<String, dynamic>> afterAddData(Map<String, dynamic> data) async {
    try {
      loading();
      var toko = await firestore.collection("toko").add(data);
      await firestore
          .collection("toko")
          .doc(toko.id)
          .update({"id_toko": toko.id});

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
