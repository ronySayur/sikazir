import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sikasir/app/controllers/auth_controller.dart';
import 'package:sikasir/app/models/product_model.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/update_product_controller.dart';

class UpdateProductView extends GetView<UpdateProductController> {
  UpdateProductView({Key? key}) : super(key: key);

  final authC = Get.find<AuthController>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final box = GetStorage();
  final ProdukModel dataProduk = Get.arguments;

  @override
  Widget build(BuildContext context) {
    setData();

    return WillPopScope(
      onWillPop: () async => willPopScope(),
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: authC.streamUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData) {
              Map<String, dynamic> user = snapshot.data!.data()!;

              return Scaffold(
                  appBar: AppBar(
                    title: const Text('Edit Produk'),
                    backgroundColor: Colors.red,
                    centerTitle: false,
                    actions: [
                      TextButton(
                          onPressed: () => controller.updateProduct(),
                          child: Container(
                            padding: const EdgeInsets.only(
                                bottom: 10, top: 10, left: 20, right: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(wDimension.radius30)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Obx(
                                  () => wSmallText(
                                    text: controller.isLoading.isFalse
                                        ? "Simpan"
                                        : "Loading...",
                                    color: Colors.lightBlue,
                                    size: wDimension.iconSize16,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Icon(Icons.save)
                              ],
                            ),
                          ))
                    ],
                  ),
                  body: Padding(
                      padding: EdgeInsets.all(wDimension.height20),
                      child: Expanded(
                          child: ListView(children: [
                        Container(
                            padding:
                                EdgeInsets.all(wDimension.screenWidth * 0.01),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GetBuilder<UpdateProductController>(
                                      init: UpdateProductController(),
                                      initState: (_) {},
                                      builder: (c) {
                                        return Stack(children: [
                                          AvatarGlow(
                                              endRadius:
                                                  wDimension.radius15 * 6,
                                              glowColor: Colors.blue,
                                              duration:
                                                  const Duration(seconds: 3),
                                              child: Container(
                                                margin: EdgeInsets.all(
                                                    wDimension.height20),
                                                width: wDimension.screenWidth *
                                                    0.5,
                                                height:
                                                    wDimension.screenHeight *
                                                        0.5,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            wDimension
                                                                    .radius30 *
                                                                5),
                                                    child: c.fotoLocal != null
                                                        ? localFotoProduk()
                                                        : c.fotoNetwork.text !=
                                                                "noimage"
                                                            ? networkFotoProduk()
                                                            : fotoProdukKosong()),
                                              )),
                                          c.fotoLocal != null
                                              ? littleDelete()
                                              : dataProduk.fotoProduk != null &&
                                                      dataProduk.fotoProduk !=
                                                          "noimage"
                                                  ? littleDelete()
                                                  : littleCamera(),
                                        ]);
                                      })
                                ])),

                        //Container 2
                        SizedBox(height: wDimension.height10 / 2),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              wBigText(
                                  text: "Detail Produk", color: Colors.black),
                              SizedBox(height: wDimension.height10 / 2),
                              const Divider(thickness: 2),
                              SizedBox(height: wDimension.height10 / 2),
                              TextField(
                                controller: controller.namaProduk,
                                cursorColor: Colors.black,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  labelText: "Nama produk",
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: wDimension.font16),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          wDimension.radius30 * 10),
                                      borderSide:
                                          const BorderSide(color: Colors.red)),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        wDimension.radius30 * 10),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: wDimension.width30,
                                    vertical: wDimension.width15,
                                  ),
                                ),
                              ),
                              SizedBox(height: wDimension.height10),
                              TextField(
                                  onTap: () {
                                    Get.defaultDialog(
                                        title: "Pilih Merk",
                                        actions: [
                                          TextButton(
                                              onPressed: () => Get.back(),
                                              child: wSmallText(text: "Batal"))
                                        ],
                                        content: controller.merkDialog());
                                  },
                                  readOnly: true,
                                  controller: controller.merkC,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      labelText: "Merk",
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: wDimension.font16),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              wDimension.radius30 * 10),
                                          borderSide: const BorderSide(
                                              color: Colors.red)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            wDimension.radius30 * 10),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: wDimension.width30,
                                          vertical: wDimension.height15))),
                              SizedBox(height: wDimension.height15),
                              TextField(
                                  onTap: () {
                                    Get.defaultDialog(
                                        title: "Pilih Kategori",
                                        actions: [
                                          TextButton(
                                              onPressed: () => Get.back(),
                                              child: wSmallText(text: "Batal"))
                                        ],
                                        content: controller.kategoriDialog());
                                  },
                                  controller: controller.kategoriC,
                                  readOnly: true,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      labelText: "Kategori",
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: wDimension.font16),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              wDimension.radius30 * 10),
                                          borderSide: const BorderSide(
                                              color: Colors.red)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            wDimension.radius30 * 10),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: wDimension.width30,
                                          vertical: wDimension.height15))),
                              SizedBox(height: wDimension.height10),
                              TextField(
                                  controller: controller.hargaJual,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: Colors.black,
                                  inputFormatters: <TextInputFormatter>[
                                    CurrencyTextInputFormatter(
                                      locale: 'ID',
                                      decimalDigits: 0,
                                      symbol: 'Rp. ',
                                    ),
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText: "Harga jual",
                                      labelStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: wDimension.font16),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              wDimension.radius30 * 10),
                                          borderSide: const BorderSide(
                                              color: Colors.red)),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              wDimension.radius30 * 10)),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: wDimension.width30,
                                          vertical: wDimension.height15))),
                              SizedBox(height: wDimension.height10),
                              TextField(
                                  controller: controller.hargaModal,
                                  cursorColor: Colors.black,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: <TextInputFormatter>[
                                    CurrencyTextInputFormatter(
                                      locale: 'ID',
                                      decimalDigits: 0,
                                      symbol: 'Rp. ',
                                    ),
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: "Harga modal",
                                    labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: wDimension.font16),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            wDimension.radius30 * 10),
                                        borderSide: const BorderSide(
                                            color: Colors.red)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          wDimension.radius30 * 10),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: wDimension.width30,
                                        vertical: wDimension.width15),
                                  )),  Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                wSmallText(
                                    text: "Supplier",
                                    color: Colors.black,
                                    size: wDimension.font16),
                                SizedBox(
                                  width: wDimension.width10,
                                ),
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Obx(() => DropdownButton(
                                        onChanged: (newValue) {
                                          controller
                                              .selectedSupplier('${newValue!}');
                                        },
                                        hint: const Text("Pilih Supplier"),
                                        value: controller.supplierC.value == ""
                                            ? null
                                            : controller.supplierC.value,
                                        items: controller.dataSupplier
                                            .map((selectedType) {
                                          return DropdownMenuItem(
                                            value: selectedType,
                                            child: Text(selectedType),
                                          );
                                        }).toList())))
                              ],
                            ),
                            SizedBox(height: wDimension.height10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                wSmallText(
                                    text: "Toko",
                                    color: Colors.black,
                                    size: wDimension.font16),
                                SizedBox(
                                  width: wDimension.width10,
                                ),
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Obx(() => DropdownButton(
                                        onChanged: (newValue) {
                                          controller
                                              .selectedToko('${newValue!}');
                                        },
                                        hint: const Text("Pilih Toko"),
                                        value: controller.tokoC.value == ""
                                            ? null
                                            : controller.tokoC.value,
                                        items: controller.dataToko
                                            .map((selectedType) {
                                          return DropdownMenuItem(
                                            value: selectedType,
                                            child: Text(selectedType),
                                          );
                                        }).toList())))
                              ],
                            ),
                          
                            ]),

                        //Button
                        SizedBox(height: wDimension.height20),
                        Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: wDimension.width10),
                              width: wDimension.screenWidth,
                              child: Obx(() => ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: wDimension.width30,
                                          vertical: wDimension.height15)),
                                  onPressed: () {
                                    if (controller.isLoading.isFalse) {
                                      controller.updateProduct();
                                    }
                                  },
                                  child: wSmallText(
                                      text: controller.isLoading.isFalse
                                          ? "Simpan"
                                          : "Loading...",
                                      weight: FontWeight.bold,
                                      color: Colors.white)))),
                        )
                      ]))));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  void setData() {
    controller.idProduk.text = dataProduk.idProduk!;
    controller.hargaJual.text = dataProduk.hargaJual!;
    controller.hargaModal.text = dataProduk.hargaModal!;
    controller.namaProduk.text = dataProduk.namaProduk!;
    controller.merkC.text = dataProduk.merek!;
    controller.kategoriC.text = dataProduk.kategori!;
    controller.emailPegawai.text = box.read("userEmail");

    dataProduk.fotoProduk != "noimage"
        ? controller.fotoNetwork.text = dataProduk.fotoProduk!
        : controller.fotoNetwork.text = "noimage";
  }

  SvgPicture fotoProdukKosong() {
    return SvgPicture.asset("assets/icons/products.svg",
        color: Colors.red, fit: BoxFit.cover);
  }

  Image networkFotoProduk() {
    print(controller.fotoNetwork.text);
    return Image.network(
      "${controller.fotoNetwork.text}",
      fit: BoxFit.cover,
    );
  }

  Image localFotoProduk() {
    return Image.file(
      File(controller.fotoLocal!.path),
      fit: BoxFit.cover,
    );
  }

  Positioned littleCamera() {
    return Positioned(
      bottom: 25,
      right: 25,
      child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
          child: InkWell(
            onTap: () => controller.pickImage(),
            child: wAppIcon(
              icon: Icons.photo_camera,
              size: wDimension.iconSize24,
            ),
          )),
    );
  }

  Positioned littleDelete() {
    return Positioned(
      bottom: 25,
      right: 25,
      child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
          child: InkWell(
            onTap: () {
              Get.defaultDialog(
                  title: "Konfirmasi",
                  content: Column(
                    children: [
                      wSmallText(
                          text:
                              "Apakah anda yakin untuk menghapus foto profil?"),
                      SizedBox(height: wDimension.height10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                              onPressed: () async {
                                Get.back();
                                controller.isLoading.isFalse;
                              },
                              child: const Text("Batal")),
                          Obx(() => ElevatedButton(
                              onPressed: () async {

                                if (controller.isLoading.isFalse) {
                                  controller.deleteFoto();
                                }
                              },
                              child: Text(controller.isLoading.isFalse
                                  ? "Konfirmasi"
                                  : "Loading..")))
                        ],
                      ),
                    ],
                  ));
            },
            child: wAppIcon(
              icon: Icons.delete,
              size: wDimension.iconSize24,
            ),
          )),
    );
  }
}
