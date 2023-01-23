import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikasir/app/controllers/auth_controller.dart';
import 'package:sikasir/widgets/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../routes/app_pages.dart';
import '../components/bodyDashboard.dart';
import '../components/sidebar.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
    final Size _size = MediaQuery.of(context).size;

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: authC.streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasData) {
            
            Map<String, dynamic> user = snapshot.data!.data()!;

            String defaultImage =
                "https://ui-avatars.com/api/?name=${user['nama_pegawai']}";

            return Scaffold(
              drawer: SideBar(),
              key: controller.scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.red,
                title: const Text('Dashboard'),
                centerTitle: false,
                actions: [
                  Container(
                      margin: EdgeInsets.only(left: defaultPadding),
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2,
                      ),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              user["foto"] != null
                                  ? user["foto"] != ""
                                      ? user["foto"]
                                      : defaultImage
                                  : defaultImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding / 2),
                            child: Text("${user['nama_pegawai']}"),
                          ),
                          PopupMenuButton<int>(
                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem(
                                  value: 1, child: Text("Profile")),
                              const PopupMenuItem(
                                  value: 2, child: Text("Logout")),
                            ],
                            initialValue: 2,
                            elevation: 3.2,
                            onSelected: (value) async {
                              print("value:$value");
                              switch (value) {
                                case 1:
                                  Get.toNamed(Routes.PROFILE);
                                  break;
                                case 2:
                                  Get.defaultDialog(
                                      title: "Peringatan",
                                      middleText:
                                          "Apakah anda yakin untuk logout?",
                                      textConfirm: "Setuju",
                                      textCancel: "Batal",
                                      confirmTextColor: Colors.white,
                                      barrierDismissible: false,
                                      radius: wDimension.radius15,
                                      onCancel: () => Get.back(),
                                      onConfirm: () async {
                                        await authC.signOut();
                                        Get.offAllNamed(Routes.LOGIN);
                                      });
                                  break;
                                default:
                              }
                            },
                            icon: const Icon(Icons.arrow_drop_down),
                          )
                        ],
                      ))
                ],
              ),
              body: SlidingUpPanel(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                maxHeight: wDimension.heightSetengah,
                minHeight: wDimension.screenHeight * 0.1,
                panel: Container(
                  padding: EdgeInsets.all(wDimension.screenWidth * 0.06),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          wBigText(
                            color: Colors.black,
                            weight: FontWeight.bold,
                            text: "Laporan Hari ini",
                          ),
                          wSmallText(
                            color: Colors.red,
                            weight: FontWeight.bold,
                            text: "30 Des 2022",
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => Get.toNamed(Routes.LAPORAN),
                        child: wBigText(text: "lihat semua"),
                      )
                    ],
                  ),
                ),
                body: bodyDashboard(user: user, size: _size),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
