import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/widgets.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Pengaturan'),
          centerTitle: false,
        ),
        body: ListView(
          children: [
            ListTile(
              onTap: () {
                Get.defaultDialog(
                    title: "Pilih Toko",
                    actions: [
                      TextButton(
                          onPressed: () => Get.back(),
                          child: wSmallText(text: "Batal"))
                    ],
                    content: controller.kategoriDialog());
              },
              leading: const Icon(Icons.storefront),
              title: wSmallText(
                text: "Toko",
                size: 18,
                color: Colors.black,
                weight: FontWeight.bold,
              ),
              subtitle: Obx(() => Text(controller.tokoC.value)),
              trailing: const Icon(Icons.expand_more),
            ),
          ],
        ));
  }
}
