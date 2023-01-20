import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sikasir/app/routes/app_pages.dart';
import 'package:sikasir/widgets/widgets.dart';

class UpdateProductController extends GetxController {
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingDelete = false.obs;
  String? uid;

  final TextEditingController idProduk = TextEditingController();
  final TextEditingController emailPegawai = TextEditingController();
  final TextEditingController namaProduk = TextEditingController();
  final TextEditingController hargaJual = TextEditingController();
  final TextEditingController hargaModal = TextEditingController();
  final TextEditingController stokC = TextEditingController();
  final TextEditingController fotoNetwork = TextEditingController();

  final TextEditingController kategoriC = TextEditingController();
  final TextEditingController tambahKategoriC = TextEditingController();
  final TextEditingController merkC = TextEditingController();
  final TextEditingController tambahmerkC = TextEditingController();

  FirebaseStorage storage = FirebaseStorage.instance;

  XFile? fotoLocal;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void pickImage() async {
    fotoLocal = await ImagePicker().pickImage(source: ImageSource.gallery);
    update();
  }

  Future<void> updateProduct() async {
    isLoading.value = true;
    try {
      Map<String, dynamic> dataMapProduk = {
        "nama_produk": namaProduk.text,
        "harga_jual": hargaJual.text,
        "harga_modal": hargaModal.text,
        "kategori": kategoriC.text,
        "merek": merkC.text,
        "email_pegawai": emailPegawai.text
      };

      if (fotoLocal != null) {
        File file = File(fotoLocal!.path);
        String ext = fotoLocal!.name.split(".").last;
        await storage.ref('${idProduk.text}/profile.$ext').putFile(file);
        String urlImage =
            await storage.ref('${idProduk.text}/profile.$ext').getDownloadURL();

        dataMapProduk.addAll({"foto_produk": urlImage});
      }

      await firestore
          .collection("produk")
          .doc(idProduk.text)
          .update(dataMapProduk);

      fotoLocal = null;

      Get.offNamed(Routes.HOME_PRODUK);
      Get.snackbar("Berhasil", "Berhasil update profile",
          duration: const Duration(seconds: 2));
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Tidak dapat update profile($e)");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteFoto() async {
    isLoading.value = true;
    
    try {
      if (fotoNetwork.text != "noimage" && fotoNetwork.text != null) {
        await storage.ref(idProduk.text).listAll().then((value) {
          value.items.forEach((element) {
            storage.ref(element.fullPath).delete();
          });
        });

        await firestore.collection("produk").doc(idProduk.text).update({
          "foto_produk": "noimage",
        });

        fotoLocal = null;
        fotoNetwork.text = "noimage";

        update();

        Get.back();
        Get.snackbar("Berhasil", "Berhasil hapus image",
            duration: const Duration(seconds: 2));
      } else {
        await firestore.collection("produk").doc(idProduk.text).update({
          "foto_produk": "noimage",
        });

        fotoNetwork.text = "noimage";

        fotoLocal = null;

        update();

        Get.back();
        Get.snackbar("Berhasil", "Berhasil hapus image",
            duration: const Duration(seconds: 2));
      }
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Tidak dapat delete profile($e)");
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>> deleteProduct() async {
    try {
      await firestore.collection("produk").doc(idProduk.text).delete();
      return {
        "error": false,
        "message": "Produk berhasil dihapus.",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Produk gagal dihapus.",
      };
    }
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
