import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sikasir/app/models/pegawai_model.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/detail_pegawai_controller.dart';

class DetailPegawaiView extends GetView<DetailPegawaiController> {
  final PegawaiModel user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('${user.namaPegawai}'),
          centerTitle: false,
        ),
        body: ListView(
          padding: EdgeInsets.all(wDimension.radius20),
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(wDimension.radius20),
                  color: Colors.grey[200]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: ClipOval(
                    child: user.foto != null
                        ? Image.network(user.foto)
                        : Image.asset(
                            "assets/logo/noimage.png",
                            fit: BoxFit.cover,
                          ),
                  )),

                  //"name": nameC.text,
                  // "jabatan": jabatanC.value,
                  // "telepon": teleponC.text,
                  // "profile": urlImage,
                  // "password": "111111",
                  // "email": emailC.text,
                  // "uid": uid,
                  // "role": "pegawai",
                  // "createdAt": DateTime.now().toIso8601String()

                  SizedBox(height: wDimension.height20),
                  wBigText(text: "Nama", weight: FontWeight.bold),
                  wSmallText(
                      text: "${DateFormat.jms().format(DateTime.now())}"),
                  wSmallText(text: "Posisi: "),
                  wSmallText(text: "Status: Di dalam area"),

                  //
                  SizedBox(height: wDimension.height20),
                  wSmallText(text: "Keluar", weight: FontWeight.bold),
                  wSmallText(
                      text: "${DateFormat.jms().format(DateTime.now())}"),
                  wSmallText(text: "Posisi: "),
                  wSmallText(text: "Status: Di dalam area"),
                ],
              ),
            ),
          ],
        ));
  }
}
