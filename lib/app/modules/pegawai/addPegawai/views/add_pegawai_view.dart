import 'dart:core';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/add_pegawai_controller.dart';

class AddPegawaiView extends GetView<AddPegawaiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Tambah Pegawai'),
          centerTitle: false,
          actions: [
            TextButton(
                onPressed: () => controller.addPegawai(),
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
        body: ListView(children: [
          Container(
            padding: EdgeInsets.all(wDimension.screenWidth * 0.01),
            child: Row(
              children: [
                Stack(
                  children: [
                    GetBuilder<AddPegawaiController>(
                      init: AddPegawaiController(),
                      initState: (_) {},
                      builder: (c) {
                        return AvatarGlow(
                          endRadius: wDimension.radius15 * 5,
                          glowColor: Colors.blue,
                          duration: const Duration(seconds: 3),
                          child: Container(
                            margin: EdgeInsets.all(wDimension.height20),
                            width: wDimension.screenWidth * 0.5,
                            height: wDimension.screenHeight * 0.5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  wDimension.radius30 * 5),
                              child: c.image != null
                                  ? Image.file(
                                      File(c.image!.path),
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset("assets/logo/noimage.png",
                                      fit: BoxFit.cover),
                            ),
                          ),
                        );
                      },
                    ),

                    //
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
                              ))),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: wDimension.screenWidth * 0.6,
                      child: TextField(
                        controller: controller.nameC,
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: "Nama Pegawai",
                          labelStyle: TextStyle(
                              color: Colors.black, fontSize: wDimension.font16),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  wDimension.radius30 * 10),
                              borderSide: const BorderSide(color: Colors.red)),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(wDimension.radius30 * 10),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: wDimension.width30,
                            vertical: wDimension.height15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: wDimension.height10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        wSmallText(
                            text: "Jabatan",
                            color: Colors.black,
                            size: wDimension.font16),
                        SizedBox(
                          width: wDimension.width10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Obx(() => DropdownButton(
                            hint: const Text("Pilih jabatan"),
                                onChanged: (newValue) {
                                  controller.selectedJabatan(newValue!);
                                },
                                value: controller.jabatanC.value == ""
                                    ? null
                                    : controller.jabatanC.value,
                                items: controller.jabatan.map((selectedType) {
                                  return DropdownMenuItem(
                                    value: selectedType,
                                    child: Text(
                                      selectedType,
                                    ),
                                  );
                                }).toList(),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          //Container 2
          SizedBox(height: wDimension.height10 / 2),
          Container(
              padding: EdgeInsets.all(wDimension.screenWidth * 0.03),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    wBigText(text: "Detail Pegawai", color: Colors.black),
                    const Divider(thickness: 2),
                    TextField(
                      controller: controller.emailC,
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: "Email",
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
                        keyboardType: TextInputType.number,
                        controller: controller.teleponC,
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.black,
                        maxLength: 13,
                        decoration: InputDecoration(
                            labelText: "Telepon",
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
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Obx(() => DropdownButton(
                           
                                onChanged: (newValue) {
                                  controller.selectedToko('${newValue!}');
                                },
                                 hint: const Text("Pilih Toko"),
                                value: controller.tokoC.value == ""
                                    ? null
                                    : controller.tokoC.value,
                                items: controller.dataToko.map((selectedType) {
                                  
                                  return DropdownMenuItem(
                                    value: selectedType,
                                    
                                    child: Text(
                                      selectedType,
                                    ),
                                  );
                                }).toList(),
                              )),
                        ),
                      ],
                    ),
                  ])),

          //Button
          Container(
              padding: EdgeInsets.symmetric(horizontal: wDimension.width10),
              width: wDimension.screenWidth,
              child: Obx(() => ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      loading();
                      await controller.addPegawai();
                    }
                  },
                  child: controller.isLoading.isFalse
                      ? wSmallText(
                          text: "Tambah Pegawai",
                          color: Colors.white,
                          weight: FontWeight.bold,
                        )
                      : const CircularProgressIndicator())))
        ]));
  }
}
