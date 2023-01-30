// ignore_for_file: sized_box_for_whitespace

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sikasir/widgets/widgets.dart';

class AddProdukController extends GetxController {
  String? uid;
  XFile? image;
  RxBool isLoading = false.obs;
  final supplierC = "".obs;
  var dataSupplier = [].obs;
  @override
  void onInit() {
    listSupplier();
    super.onInit();
  }

  listSupplier() async {
    QuerySnapshot querySnapshot = await firestore.collection("supplier").get();

    for (var snapToko in querySnapshot.docs) {
      final namaSupplier = snapToko["nama_vendor"];
      dataSupplier.add(namaSupplier);
    }
  }

  final TextEditingController hargaJual = TextEditingController();
  final TextEditingController hargaModal = TextEditingController();
  final TextEditingController namaProduk = TextEditingController();
  final TextEditingController merkC = TextEditingController();
  final TextEditingController kategoriC = TextEditingController();
  final TextEditingController stokC = TextEditingController();
  final TextEditingController tambahKategoriC = TextEditingController();
  final TextEditingController tambahmerkC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  void pickImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    update();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamProduk() async* {
    yield* firestore.collection("produk").doc().snapshots();
  }

  void selectedSupplier(String value) {
    supplierC.value = value;
  }

  Future<void> addProduct(Map<String, dynamic> user) async {
    if (isLoading.isFalse) {
      if (hargaJual.text.isNotEmpty &&
          hargaModal.text.isNotEmpty &&
          kategoriC.text.isNotEmpty &&
          merkC.text.isNotEmpty &&
          namaProduk.text.isNotEmpty) {
        //buat loading
        isLoading(true);

        //hasil berupa map
        Map<String, dynamic> hasil = await afterAddProduct({
          "keyName": namaProduk.text.substring(0, 1).toUpperCase(),
          "id_produk": "idProduk",
          "foto_produk": "noimage",
          "nama_produk": namaProduk.text,
          "harga_jual": hargaJual.text,
          "harga_modal": hargaModal.text,
          "kategori": kategoriC.text,
          "merek": merkC.text,
          "email_pegawai": user["email"],
          "stok": int.tryParse(stokC.text) ?? 0,

          // "email_vendor": emailVendor,
          // "id_toko": idToko,
        });

        isLoading(false);

        Get.back();
        Get.back();

        Get.snackbar(
            hasil["error"] == true ? "Error" : "Success", hasil["message"]);
      } else {
        Get.snackbar("Error", "Semua data wajib diisi.");
      }
    }
  }

  Future<Map<String, dynamic>> afterAddProduct(
      Map<String, dynamic> data) async {
    if (image != null) {
      try {
        //tambah produk data
        var produk = await firestore.collection("produk").add(data);
        uid = produk.id;

        //file = path image
        File file = File(image!.path);
        String ext = image!.name.split(".").last;
        await storage.ref('$uid/produk.$ext').putFile(file);
        String urlImage =
            await storage.ref('$uid/produk.$ext').getDownloadURL();

        //habis data masuk di update menambahkan urlimage
        await firestore
            .collection("produk")
            .doc(uid)
            .update({"foto_produk": urlImage, "id_produk": uid});

        return {
          "error": false,
          "message": "Berhasil menambah product.",
        };
      } catch (e) {
        return {
          "error": true,
          "message": "Gagal menambah product",
        };
      }
    } else {
      try {
        //tambah produk data
        var produk = await firestore.collection("produk").add(data);
        uid = produk.id;
        //habis data masuk di update menambahkan urlimage
        await firestore
            .collection("produk")
            .doc(uid)
            .update({"id_produk": uid});

        return {
          "error": false,
          "message": "Berhasil menambah product.",
        };
      } catch (e) {
        return {
          "error": true,
          "message": "Gagal menambah product",
        };
      }
    }
  }

  void cekModal() {
    if (hargaModal.text.isNotEmpty) {
      final hargaM =
          int.parse(hargaModal.text.replaceAll(RegExp('[^0-9]'), ''));
      final hargaJ = int.parse(hargaJual.text.replaceAll(RegExp('[^0-9]'), ''));
      if (hargaM >= hargaJ) {
        Get.snackbar("Peringatan",
            "Harga modal tidak boleh lebih tinggi dari harga jual");
        hargaModal.text = "";
      }
    }

    update();
  }

//menampilkan stream kategori
  Stream<QuerySnapshot<Map<String, dynamic>>> streamKategori() async* {
    yield* firestore.collection("kategori").snapshots();
  }

  Container kategoriDialog() {
    return Container(
      child: Column(
        children: [
          InkWell(
              onTap: () {
                Get.defaultDialog(
                  title: "Tambah kategori",
                  actions: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: wSmallText(text: "batal"),
                        ),
                        TextButton(
                          onPressed: () async => await addKategori(),
                          child: wSmallText(
                            text: "Simpan",
                            weight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                  content: tambahKategoriDialog(),
                );
              },
              child: wSmallText(
                  size: 18,
                  text: "Tambahkan Kategori lain",
                  weight: FontWeight.bold)),
          Divider(),
          Container(
            width: wDimension.widthSetengah,
            height: wDimension.heightSetengah / 2,
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: streamKategori(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.data?.docs.length == 0 ||
                            snapshot.data == null) {
                          return SizedBox(
                            height: wDimension.height20 * 10,
                            child: Center(child: Text("Belum ada kategori")),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> data =
                                snapshot.data!.docs[index].data();

                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    kategoriC.text = data["kategori"];
                                    Get.back();
                                  },
                                  title: Text(data["kategori"]),
                                ),
                                const Divider()
                              ],
                            );
                          },
                        );
                      }),
                  const Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container tambahKategoriDialog() {
    return Container(
      width: wDimension.widthSetengah,
      height: wDimension.heightSetengah / 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          TextField(
            controller: tambahKategoriC,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              label: wSmallText(text: "Tambah Kategori"),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(wDimension.radius30 * 10),
                  borderSide: const BorderSide(color: Colors.red)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(wDimension.radius30 * 10),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: wDimension.width30,
                vertical: wDimension.width15,
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  Future<void> addKategori() async {
    if (isLoading.isFalse) {
      if (tambahKategoriC.text.isNotEmpty) {
        isLoading(true);

        var checkKategori = await firestore
            .collection("kategori")
            .doc(tambahKategoriC.text)
            .get();

        if (checkKategori.exists) {
          Get.snackbar("Gagal", "Data ${tambahKategoriC.text} sudah tersedia");

          tambahKategoriC.clear;

          isLoading(false);
        } else {
          Map<String, dynamic> kategori =
              await afterAddKategori({"kategori": tambahKategoriC.text});

          isLoading(false);

          kategoriC.text = tambahKategoriC.text;

          Get.back();
          Get.back();

          Get.snackbar(kategori["error"] == true ? "Error" : "Success",
              kategori["message"]);
        }
      } else {
        Get.snackbar("Error", "isi data kategori terlebih dahulu.");
      }
    }
  }

  Future<Map<String, dynamic>> afterAddKategori(
      Map<String, dynamic> data) async {
    try {
      //tambah produk data
      firestore.collection("kategori").doc(data["kategori"]).set(data);

      return {
        "error": false,
        "message": "Berhasil menambah kategori.",
      };
    } catch (e) {
      // Error general
      return {
        "error": true,
        "message": "Tidak dapat menambah kategori.",
      };
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streammerk() async* {
    yield* firestore.collection("merk").snapshots();
  }

  Container merkDialog() {
    return Container(
      child: Column(
        children: [
          InkWell(
              onTap: () {
                Get.defaultDialog(
                  title: "Tambah Merk",
                  actions: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: wSmallText(text: "batal"),
                        ),
                        TextButton(
                          onPressed: () async => await addmerk(),
                          child: wSmallText(
                            text: "Simpan",
                            weight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                  content: tambahmerkDialog(),
                );
              },
              child: wSmallText(
                  size: 18,
                  text: "Tambahkan merk lain",
                  weight: FontWeight.bold)),
          Divider(),
          Container(
            width: wDimension.widthSetengah,
            height: wDimension.heightSetengah / 2,
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: streammerk(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.data?.docs.length == 0 ||
                            snapshot.data == null) {
                          return SizedBox(
                            height: wDimension.height20 * 10,
                            child: Center(child: Text("Belum ada merk")),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> data =
                                snapshot.data!.docs[index].data();

                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    merkC.text = data["merk"];
                                    Get.back();
                                  },
                                  title: Text(data["merk"]),
                                ),
                                const Divider()
                              ],
                            );
                          },
                        );
                      }),
                  const Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container tambahmerkDialog() {
    return Container(
      width: wDimension.widthSetengah,
      height: wDimension.heightSetengah / 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          TextField(
            controller: tambahmerkC,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              label: wSmallText(text: "Tambah merk"),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(wDimension.radius30 * 10),
                  borderSide: const BorderSide(color: Colors.red)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(wDimension.radius30 * 10),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: wDimension.width30,
                vertical: wDimension.width15,
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  Future<void> addmerk() async {
    if (isLoading.isFalse) {
      if (tambahmerkC.text.isNotEmpty) {
        isLoading(true);

        var checkmerk =
            await firestore.collection("merk").doc(tambahmerkC.text).get();

        if (checkmerk.exists) {
          Get.snackbar("Gagal", "Data ${tambahmerkC.text} sudah tersedia");

          tambahmerkC.clear;

          isLoading(false);
        } else {
          Map<String, dynamic> merk =
              await afterAddmerk({"merk": tambahmerkC.text});

          isLoading(false);

          merkC.text = tambahmerkC.text;

          Get.back();
          Get.back();

          Get.snackbar(
              merk["error"] == true ? "Error" : "Success", merk["message"]);
        }
      } else {
        Get.snackbar("Error", "isi data merk terlebih dahulu.");
      }
    }
  }

  Future<Map<String, dynamic>> afterAddmerk(Map<String, dynamic> data) async {
    try {
      //tambah produk data
      firestore.collection("merk").doc(data["merk"]).set(data);

      return {
        "error": false,
        "message": "Berhasil menambah merk.",
      };
    } catch (e) {
      // Error general
      return {
        "error": true,
        "message": "Tidak dapat menambah merk.",
      };
    }
  }
}
