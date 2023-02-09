import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sikasir/widgets/widgets.dart';
import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final Map<String, dynamic> user = Get.arguments;

  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    controller.nameC.text = user["nama_pegawai"];
    controller.emailC.text = box.read('userEmail');

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Update Pegawai'),
          centerTitle: true,
        ),
        body: ListView(padding: EdgeInsets.all(wDimension.height20), children: [
          TextField(
            controller: controller.emailC,
            readOnly: true,
            decoration: const InputDecoration(
                labelText: "Email", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller.nameC,
            decoration: const InputDecoration(
                labelText: "Name", border: OutlineInputBorder()),
          ),
          SizedBox(height: wDimension.height20),
          wSmallText(text: "Photo Profile"),
          SizedBox(height: wDimension.height10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<UpdateProfileController>(
                builder: (c) {
                  if (c.image != null) {
                    return ClipOval(
                      child: Container(
                        height: wDimension.height20 * 5,
                        width: wDimension.width20 * 5,
                        child: Image.file(
                          File(c.image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    if (user["foto"] != null) {
                      return Column(
                        children: [
                          ClipOval(
                            child: Container(
                              height: wDimension.height20 * 5,
                              width: wDimension.width20 * 5,
                              child: Image.network(
                                user["foto"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () =>
                                  controller.deleteProfile(user["uid"]),
                              child: const Text("Delete"))
                        ],
                      );
                    } else {
                      return const Text("No Image choosen");
                    }
                  }
                },
              ),
              TextButton(
                  onPressed: () {
                    controller.pickImage();
                  },
                  child: wSmallText(text: "choose"))
            ],
          ),
          SizedBox(height: wDimension.height30),
          Obx(() => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.updateProfile(user["uid"]);
                }
              },
              child: controller.isLoading.isFalse
                  ? wSmallText(
                      text: "Update Pegawai",
                      color: Colors.white,
                      weight: FontWeight.bold,
                    )
                  : const CircularProgressIndicator()))
        ]));
  }
}
