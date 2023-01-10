import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikasir/widgets/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../routes/app_pages.dart';
import '../../components/constants.dart';
import '../../components/settingCard.dart';
import '../../components/responsive.dart';
import '../../components/side_menu.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            Map<String, dynamic> user = snapshot.data!.data()!;
            Image defaultImage = Image.asset("assets/logo/noimage.png");

            return Scaffold(
              drawer: SideMenu(),
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
                            user["profile"] != null
                                ? user["profile"] != ""
                                    ? user["profile"]
                                    : defaultImage
                                : defaultImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 2),
                          child: Text("${user['name']}"),
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
                                await controller.signOut();
                                break;
                              default:
                            }
                          },
                          icon: const Icon(Icons.arrow_drop_down),
                        )
                      ],
                    ),
                  )
                ],
              ),
              body: SlidingUpPanel(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(wDimension.radius20),
                    topRight: Radius.circular(wDimension.radius20)),
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
                        onTap: () {},
                        child: wBigText(text: "lihat semua"),
                      )
                    ],
                  ),
                ),
                body: SafeArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SafeArea(
                          child: SingleChildScrollView(
                            primary: false,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  wBigText(
                                                    text:
                                                        "Selamat Datang ${user["name"]}",
                                                    color: primaryColor,
                                                  ),
                                                  ElevatedButton.icon(
                                                    style: TextButton.styleFrom(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal:
                                                            defaultPadding *
                                                                1.5,
                                                        vertical: defaultPadding /
                                                            (Responsive
                                                                    .isMobile(
                                                                        context)
                                                                ? 2
                                                                : 1),
                                                      ),
                                                    ),
                                                    onPressed: () {},
                                                    icon: Icon(Icons.add),
                                                    label: Text(
                                                        "Tambah Transaksi"),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: defaultPadding),
                                              Responsive(
                                                mobile: FileInfoCardGridView(
                                                  crossAxisCount:
                                                      _size.width < 650 ? 2 : 4,
                                                  childAspectRatio:
                                                      _size.width < 650
                                                          ? 1.3
                                                          : 1,
                                                ),
                                                tablet: FileInfoCardGridView(),
                                                desktop: FileInfoCardGridView(
                                                  childAspectRatio:
                                                      _size.width < 1400
                                                          ? 1.1
                                                          : 1.4,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
