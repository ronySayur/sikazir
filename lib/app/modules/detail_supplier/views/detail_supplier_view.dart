import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';

import 'package:get/get.dart';
import 'package:sikasir/app/models/supplier_model.dart';

import '../../../../widgets/widgets.dart';
import '../controllers/detail_supplier_controller.dart';

class DetailSupplierView extends GetView<DetailSupplierController> {
  final SupplierModel dataSup = Get.arguments;

  void setData() {
    controller.vendorEmail.text = dataSup.emailVendor;
    controller.picTelp.text = dataSup.noPic;
    controller.vendorAlamat.text = dataSup.alamatVendor;
    controller.picJabatan.text = dataSup.jabatanPic;
    controller.picNama.text = dataSup.namaPic;
    controller.vendorNama.text = dataSup.namaVendor;
    controller.vendorTelp.text = dataSup.noVendor;
  }

  PhoneCountryData? _initialCountryData;
  DetailSupplierView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    setData();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Tambah Suplier'),
          centerTitle: false,
          actions: [
            TextButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.updateSup(dataSup.idSupplier);
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
                        text: "Update",
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
                        SizedBox(height: 20),
                        const Divider(thickness: 2),
                        SizedBox(height: 20),
                        TextField(
                            controller: controller.vendorNama,
                            cursorColor: Colors.black,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                                labelText: "Nama vendor",
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(300),
                                    borderSide:
                                        const BorderSide(color: Colors.red)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(300),
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
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 16),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(300),
                                borderSide:
                                    const BorderSide(color: Colors.red)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(300),
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
                                    color: Colors.black, fontSize: 16),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(300),
                                    borderSide:
                                        const BorderSide(color: Colors.red)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(300),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: wDimension.width30,
                                    vertical: wDimension.height15))),
                        SizedBox(height: wDimension.height15),
                        TextField(
                            controller: controller.vendorAlamat,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.sentences,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                labelText: "Alamat",
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(300),
                                    borderSide:
                                        const BorderSide(color: Colors.red)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(300),
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
                SizedBox(height: 20),
                const Divider(thickness: 2),
                SizedBox(height: 20),
                TextField(
                    controller: controller.picNama,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                        labelText: "Nama",
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 16),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(300),
                            borderSide: const BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(300),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: wDimension.width30,
                            vertical: wDimension.width15))),
                SizedBox(height: wDimension.height10),
                TextField(
                    controller: controller.picJabatan,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                        labelText: "Jabatan",
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 16),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(300),
                            borderSide: const BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(300),
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
                    labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(300),
                        borderSide: const BorderSide(color: Colors.red)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(300),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: wDimension.screenWidth,
              child: Obx(() => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: EdgeInsets.symmetric(
                          horizontal: wDimension.width30,
                          vertical: wDimension.height15)),
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      loading();
                      await controller.updateSup(dataSup.idSupplier);
                    }
                  },
                  child: wSmallText(
                      text: controller.isLoading.isFalse
                          ? "Update"
                          : "Loading...",
                      weight: FontWeight.bold,
                      color: Colors.white))),
            ),
          ),
          Expanded(
              child: TextButton(
                  onPressed: () async {
                    await dialogDeleteFutureMap(
                      'Supplier',
                      controller.isLoading,
                      controller.deleteSup(dataSup.idSupplier),
                    );
                  },
                  child: wSmallText(
                    text: "Hapus Supplier",
                    weight: FontWeight.bold,
                    color: Colors.red,
                  )))
        ]));
  }
}
