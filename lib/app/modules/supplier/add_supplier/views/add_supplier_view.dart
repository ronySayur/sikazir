// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:sikasir/app/routes/app_pages.dart';

import '../../../../../widgets/widgets.dart';
import '../controllers/add_supplier_controller.dart';

class AddSupplierView extends GetView<AddSupplierController> {
  PhoneCountryData? _initialCountryData;
  AddSupplierView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Tambah Suplier'),
          centerTitle: false,
          actions: [
            TextButton(
                onPressed: () => controller.obx((state) => state.addSup()),
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
              padding: EdgeInsets.fromLTRB(wDimension.width10,
                  wDimension.height20, wDimension.width10, wDimension.height10),
              child: Expanded(
                  flex: 3,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        wBigText(text: "Detail vendor", color: Colors.black),
                        SizedBox(height: wDimension.height10 / 2),
                        const Divider(thickness: 2),
                        SizedBox(height: wDimension.height10 / 2),
                        TextField(
                            controller: controller.vendorNama,
                            cursorColor: Colors.black,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                labelText: "Nama vendor",
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
                                    vertical: wDimension.width15))),
                        SizedBox(height: wDimension.height10),
                        TextFormField(
                          key: ValueKey(_initialCountryData ?? 'country'),
                          controller: controller.vendorTelp,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: "Nomor telepon",
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
                                vertical: wDimension.height15),
                            hintText: _initialCountryData
                                ?.phoneMaskWithoutCountryCode,
                            hintStyle:
                                TextStyle(color: Colors.black.withOpacity(.3)),
                            errorStyle: const TextStyle(color: Colors.red),
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(13),
                            PhoneInputFormatter(
                              allowEndlessPhone: false,
                              defaultCountryCode:
                                  _initialCountryData?.countryCode,
                            )
                          ],
                        ),
                        SizedBox(height: wDimension.height10),
                        TextField(
                            controller: controller.vendorEmail,
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                labelText: "Email vendor",
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
                            controller: controller.vendorAlamat,
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                labelText: "Alamat",
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
                      ]))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                wBigText(text: "Data pemilik/PIC/Sales", color: Colors.black),
                SizedBox(height: wDimension.height10 / 2),
                const Divider(thickness: 2),
                SizedBox(height: wDimension.height10 / 2),
                TextField(
                    controller: controller.picNama,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: "Nama",
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
                            vertical: wDimension.width15))),
                SizedBox(height: wDimension.height10),
                TextField(
                    controller: controller.picJabatan,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: "Jabatan",
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
                            vertical: wDimension.width15))),
                SizedBox(height: wDimension.height10),
                TextFormField(
                  key: ValueKey(_initialCountryData ?? 'country'),
                  controller: controller.picTelp,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: "Nomor telepon",
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
                        vertical: wDimension.height15),
                    hintText: _initialCountryData?.phoneMaskWithoutCountryCode,
                    hintStyle: TextStyle(color: Colors.black.withOpacity(.3)),
                    errorStyle: const TextStyle(color: Colors.red),
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(13),
                    PhoneInputFormatter(
                      allowEndlessPhone: false,
                      defaultCountryCode: _initialCountryData?.countryCode,
                    )
                  ],
                ),
              ],
            ),
          ),

          //Button
          Spacer(flex: 3),
          Expanded(
            flex: 1,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: wDimension.width10),
                width: wDimension.screenWidth,
                child: Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: EdgeInsets.symmetric(
                            horizontal: wDimension.width30,
                            vertical: wDimension.height15)),
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        Get.defaultDialog(
                          title: "Tunggu Sebentar",
                          content: CircularProgressIndicator(),
                        );

                        await controller.addSup();

                      }
                    },
                    child: wSmallText(
                        text: controller.isLoading.isFalse
                            ? "Simpan"
                            : "Loading...",
                        weight: FontWeight.bold,
                        color: Colors.white)))),
          )
        ]));
  }
}
