import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sikasir/app/controllers/auth_controller.dart';

import '../../../../widgets/widgets.dart';
import '../../../routes/app_pages.dart';
import '../controllers/all_pegawai_controller.dart';

class AllPegawaiView extends GetView<AllPegawaiController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Semua Pegawai'),
          centerTitle: false,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: wDimension.height20,
                width: wDimension.screenWidth,
                child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: authC.streamUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasData) {
                        Map<String, dynamic> user = snapshot.data!.data()!;
                        return TextField(
                            onChanged: (value) =>
                                controller.searchPegawai(value, user['email']),
                            controller: controller.searchC,
                            cursorColor: Colors.red[900],
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      wDimension.height45),
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      width: wDimension.width10 / 10)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      wDimension.height45),
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      width: wDimension.width10 / 10)),
                              hintText: "Search friend",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: wDimension.height30,
                                  vertical: wDimension.height20),
                              suffixIcon: InkWell(
                                  borderRadius: BorderRadius.circular(
                                      wDimension.height45),
                                  child: wAppIcon(
                                      icon: Icons.search,
                                      iconColor: Colors.red,
                                      size: wDimension.iconSize24)),
                            ));
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.streamPegawai(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    var listDocsChats = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: listDocsChats.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: wDimension.width20,
                                  vertical: wDimension.height10 / 2),
                              onTap: () => Get.toNamed(Routes.DETAIL_PEGAWAI),
                              leading: CircleAvatar(
                                  radius: wDimension.radius30,
                                  backgroundColor: Colors.black26,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          wDimension.radius30 * 5),
                                      child: listDocsChats[index]["profile"] ==
                                              "noimage"
                                          ? Image.asset(
                                              "assets/logo/noimage.png",
                                              fit: BoxFit.cover)
                                          : Image.network(
                                              "${listDocsChats[index]["profile"]}",
                                              fit: BoxFit.cover))),
                              title: wBigText(
                                  text: "${listDocsChats[index]["name"]}",
                                  weight: FontWeight.w600,
                                  size: wDimension.font20),
                              subtitle: wSmallText(
                                  text: "${listDocsChats[index]["jabatan"]}"),
                            ),
                            const Divider()
                          ],
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ));
  }
}
