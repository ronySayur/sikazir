import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';

import 'package:get/get.dart';
import 'package:sikasir/widgets/widgets.dart';
import '../controllers/add_toko_controller.dart';

class AddTokoView extends GetView<AddTokoController> {
  PhoneCountryData? _initialCountryData;

  AddTokoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Tambah Toko'),
          centerTitle: false,
          actions: [
            TextButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.add();
                  }
                },
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
                        wBigText(text: "Detail Toko", color: Colors.black),
                        SizedBox(height: wDimension.height10 / 2),
                        const Divider(thickness: 2),
                        SizedBox(height: wDimension.height10 / 2),
                        TextField(
                            controller: controller.namaToko,
                            cursorColor: Colors.black,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                                labelText: "Nama",
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
                        TextField(
                            controller: controller.emailToko,
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                labelText: "Email",
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
                            controller: controller.alamatToko,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.sentences,
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
                        SizedBox(height: wDimension.height10),
                        TextFormField(
                          key: ValueKey(_initialCountryData ?? 'country'),
                          controller: controller.telpToko,
                          textInputAction: TextInputAction.done,
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
                      ]))),
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
                        await controller.add();
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
