// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sikasir/app/controllers/auth_controller.dart';
import 'package:sikasir/widgets/widgets.dart';
import '../controllers/add_produk_controller.dart';

class AddProdukView extends GetView<AddProdukController> {
  AddProdukView({Key? key}) : super(key: key);

  final authC = Get.find<AuthController>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: authC.streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            Map<String, dynamic> user = snapshot.data!.data()!;

            return Scaffold(
                appBar: AppBar(
                  title: const Text('Tambah Produk'),
                  backgroundColor: Colors.red,
                  centerTitle: false,
                  actions: [
                    TextButton(
                        onPressed: () => controller.addProduct(user),
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
                              wSmallText(
                                text: "Simpan",
                                color: Colors.lightBlue,
                                size: wDimension.iconSize16,
                                weight: FontWeight.bold,
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
                    child: ListView(children: [
                      Container(
                          padding:
                              EdgeInsets.all(wDimension.screenWidth * 0.01),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(children: [
                                  GetBuilder<AddProdukController>(
                                    init: AddProdukController(),
                                    initState: (_) {},
                                    builder: (c) {
                                      return AvatarGlow(
                                          endRadius: wDimension.radius15 * 6,
                                          glowColor: Colors.blue,
                                          duration: const Duration(seconds: 3),
                                          child: Container(
                                            margin: EdgeInsets.all(
                                                wDimension.height20),
                                            width: wDimension.screenWidth * 0.5,
                                            height:
                                                wDimension.screenHeight * 0.5,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      wDimension.radius30 * 5),
                                              child: c.image != null
                                                  ? Image.file(
                                                      File(c.image!.path),
                                                      fit: BoxFit.cover,
                                                    )
                                                  : SvgPicture.asset(
                                                      "assets/icons/products.svg",
                                                      color: Colors.red,
                                                      fit: BoxFit.cover),
                                            ),
                                          ));
                                    },
                                  ),
                                  Positioned(
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
                                  )
                                ])
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
                            GetBuilder<AddProdukController>(
                              init: AddProdukController(),
                              initState: (_) {},
                              builder: (c) {
                                return TextField(
                                    onChanged: (value) => c.cekModal(),
                                    onEditingComplete: () => c.cekModal(),
                                    controller: controller.hargaModal,
                                    cursorColor: Colors.black,
                                    textInputAction: TextInputAction.done,
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
                                    ));
                              },
                            ),
                            SizedBox(height: wDimension.height10),
                            Row(
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
                                              child: Text(selectedType));
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
                      SizedBox(height: wDimension.height10),
                      Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: wDimension.width10),
                            width: wDimension.screenWidth,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: wDimension.width30,
                                        vertical: wDimension.height15)),
                                onPressed: () async {
                                  if (controller.isLoading.isFalse) {
                                    loading();

                                    await controller.addProduct(user);

                                    await Future.delayed(Duration(seconds: 3));
                                    Get.back();
                                    Get.back();
                                  }
                                },
                                child: wSmallText(
                                    text: "Simpan",
                                    weight: FontWeight.bold,
                                    color: Colors.white))),
                      )
                    ])));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
