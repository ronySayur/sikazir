import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sikasir/app/controllers/auth_controller.dart';
import 'package:sikasir/app/models/pegawai_model.dart';
import 'package:sikasir/app/routes/app_pages.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/home_pegawai_controller.dart';

class HomePegawaiView extends GetView<HomePegawaiController> {
  final authC = Get.find<AuthController>();
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Pegawai'),
        actions: [
          TextButton(
              onPressed: () => Get.toNamed(Routes.ADD_PEGAWAI),
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
                      text: "Tambah Pegawai",
                      color: Colors.lightBlue,
                      size: wDimension.iconSize16,
                      weight: FontWeight.bold,
                      align: TextAlign.end,
                    ),
                    SizedBox(width: wDimension.width10 / 2),
                    const Icon(Icons.add_box_sharp)
                  ],
                ),
              ))
        ],
        centerTitle: false,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: authC.streamUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData) {
              Map<String, dynamic> user = snapshot.data!.data()!;
              String defaultImage =
                  "https://ui-avatars.com/api/?name=${user['nama_pegawai']}";
              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Container(
                          width: wDimension.width20 * 4,
                          height: wDimension.height20 * 4,
                          child: Image.network(
                            user["foto"] != "noimage" ? user["foto"] : defaultImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: wDimension.width10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          wBigText(
                            text: "Selamat datang..",
                            weight: FontWeight.bold,
                          ),
                          Container(
                            width: wDimension.width20 * 10,
                            child: wSmallText(
                              text: "${box.read('toko')}",
                              align: TextAlign.left,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: wDimension.height20),
                  Container(
                    padding: EdgeInsets.all(wDimension.height20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(wDimension.radius20),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        wBigText(
                            text: "${user['jabatan']}",
                            weight: FontWeight.bold),
                        const SizedBox(height: 20),
                        wBigText(
                          text: "${user['nama_pegawai']}",
                          weight: FontWeight.bold,
                          size: wDimension.font26,
                        ),
                        const SizedBox(height: 10),
                        wBigText(text: "${user['email_pegawai']}"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: wDimension.height10,
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      wBigText(
                          text: "Daftar karyawan",
                          weight: FontWeight.bold,
                          size: wDimension.font16),
                      TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.ALL_PEGAWAI);
                          },
                          child: wSmallText(text: "Lihat Semua"))
                    ],
                  ),
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: controller.streamPegawai(),
                      builder: (context, snap) {
                        if (snap.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snap.data!.docs.isEmpty) {
                          return dataKosong('Pegawai');
                        }
                        if (snap.connectionState == ConnectionState.active) {
                          List<PegawaiModel> pegawaiM = [];

                          for (var element in snap.data!.docs) {
                            pegawaiM.add(PegawaiModel.fromJson(element.data()));
                          }

                          //swiper
                          return Swiper(
                            itemCount: pegawaiM.length,
                            itemWidth: wDimension.screenWidth,
                            itemHeight: wDimension.heightSetengah,
                            layout: SwiperLayout.TINDER,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                radius: wDimension.radius20,
                                onTap: () => Get.toNamed(Routes.DETAIL_PEGAWAI,
                                    arguments: pegawaiM[index]),
                                borderRadius:
                                    BorderRadius.circular(wDimension.radius20),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          wDimension.radius20)),
                                  elevation: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(
                                                    wDimension.radius20)),
                                            child: Image.network(
                                              pegawaiM[index].foto != null
                                                  ? pegawaiM[index].foto !=
                                                          "noimage"
                                                      ? pegawaiM[index].foto
                                                      : defaultImage
                                                  : defaultImage,
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                            title: wBigText(
                                                size: wDimension.font26,
                                                weight: FontWeight.bold,
                                                text: pegawaiM[index]
                                                    .namaPegawai),
                                            subtitle: wSmallText(
                                                text: pegawaiM[index].jabatan)),
                                      ),
                                      SizedBox(
                                        height: wDimension.height20,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return const CircularProgressIndicator();
                      }),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_PEGAWAI),
        child: const Icon(Icons.add),
      ),
    );
  }
}
