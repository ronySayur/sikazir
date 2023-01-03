import 'package:avatar_glow/avatar_glow.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../widgets/widgets.dart';
import '../controllers/add_barang_controller.dart';

class AddProdukView extends GetView<AddProdukController> {
  const AddProdukView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Produk'),
          centerTitle: false,
          actions: [
            TextButton(
                onPressed: () => controller.addProduk(),
                child: Container(
                  padding: const EdgeInsets.only(
                      bottom: 10, top: 10, left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(wDimension.radius30)),
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
            child: Expanded(
                child: ListView(children: [
              Container(
                  padding: EdgeInsets.all(wDimension.screenWidth * 0.01),
                  child: Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Stack(children: [
                          AvatarGlow(
                              endRadius: wDimension.radius15 * 6,
                              glowColor: Colors.blue,
                              duration: const Duration(seconds: 3),
                              child: Container(
                                  margin: EdgeInsets.all(wDimension.height20),
                                  width: wDimension.screenWidth * 0.5,
                                  height: wDimension.screenHeight * 0.5,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          wDimension.radius30 * 5),
                                      child:
                                          // authC.user.value.photoUrl == "noimage" ?
                                          Image.asset(
                                              "assets/logo/noproduk.png",
                                              fit: BoxFit.cover)

                                      // : Image.network(authC.user.value.photoUrl!,
                                      //     fit: BoxFit.cover)
                                      ))),
                          Positioned(
                            bottom: 25,
                            right: 25,
                            child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                child: wAppIcon(
                                  icon: Icons.photo_camera,
                                  size: wDimension.iconSize24,
                                )),
                          )
                        ])
                      ]))),

              //Container 2
              SizedBox(height: wDimension.height10 / 2),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    wBigText(text: "Detail Produk", color: Colors.black),
                    SizedBox(height: wDimension.height10 / 2),
                    const Divider(thickness: 2),
                    SizedBox(height: wDimension.height10 / 2),
                    TextField(
                      // controller: controller.emailC,
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "Nama produk",
                        labelStyle: TextStyle(
                            color: Colors.black, fontSize: wDimension.font16),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(wDimension.radius30 * 10),
                            borderSide: const BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(wDimension.radius30 * 10),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: wDimension.width30,
                          vertical: wDimension.width15,
                        ),
                      ),
                    ),
                    SizedBox(height: wDimension.height10),
                    TextField(
                        controller: controller.jabatanC,
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
                                borderSide:
                                    const BorderSide(color: Colors.red)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    wDimension.radius30 * 10)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: wDimension.width30,
                                vertical: wDimension.height15))),
                    SizedBox(height: wDimension.height10),
                    TextField(
                        controller: controller.teleponC,
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
                                borderSide:
                                    const BorderSide(color: Colors.red)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  wDimension.radius30 * 10),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: wDimension.width30,
                                vertical: wDimension.height15))),
                    SizedBox(height: wDimension.height15),
                    TextField(
                        controller: controller.teleponC,
                        textInputAction: TextInputAction.done,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            labelText: "Kategori",
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
                                vertical: wDimension.height15))),
                    SizedBox(height: wDimension.height10)
                  ]),

              //Container Atur Harga
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExpansionTile(
                        title: wBigText(
                            text: "Atur harga modal dan produk",
                            color: Colors.black),
                        subtitle:
                            wSmallText(text: "*opsional", color: Colors.black),
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TextField(
                                  // controller: controller.emailC,
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
                                  ))),
                          SizedBox(height: wDimension.height10),
                          Column(children: [
                            TextField(
                                controller: controller.jabatanC,
                                textInputAction: TextInputAction.done,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    labelText: "Barcode",
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
                          ])
                        ])
                  ]),

              //Button
              SizedBox(height: wDimension.height10),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: wDimension.width10),
                  width: wDimension.screenWidth,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          padding: EdgeInsets.symmetric(
                              horizontal: wDimension.width30,
                              vertical: wDimension.height15)),
                      onPressed: () {},
                      // onPressed: () => controller.addPegawai(),
                      child: wSmallText(
                          text: "Simpan",
                          weight: FontWeight.bold,
                          color: Colors.white)))
            ]))));
  }
}
