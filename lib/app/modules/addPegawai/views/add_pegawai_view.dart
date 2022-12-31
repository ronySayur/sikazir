import 'package:avatar_glow/avatar_glow.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/widgets.dart';
import '../controllers/add_pegawai_controller.dart';

final List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
];
String? selectedValue;

List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
  List<DropdownMenuItem<String>> _menuItems = [];
  for (var item in items) {
    _menuItems.addAll(
      [
        DropdownMenuItem<String>(
          value: item,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ),
        //If it's last item, we will not add Divider after it.
        if (item != items.last)
          const DropdownMenuItem<String>(
            enabled: false,
            child: Divider(),
          ),
      ],
    );
  }
  return _menuItems;
}

List<double> _getCustomItemsHeights() {
  List<double> _itemsHeights = [];
  for (var i = 0; i < (items.length * 2) - 1; i++) {
    if (i.isEven) {
      _itemsHeights.add(40);
    }
    //Dividers indexes will be the odd indexes
    if (i.isOdd) {
      _itemsHeights.add(4);
    }
  }
  return _itemsHeights;
}

class AddPegawaiView extends GetView<AddPegawaiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Pegawai'),
          centerTitle: false,
          actions: [
            TextButton(
                onPressed: () => controller.addPegawai(),
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
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(wDimension.screenWidth * 0.01),
              decoration: const BoxDecoration(color: Color(0xff7c94b6)),
              child: Expanded(
                child: Row(
                  children: [
                    Stack(
                      children: [
                        AvatarGlow(
                          endRadius: wDimension.radius15 * 5,
                          glowColor: Colors.blue,
                          duration: const Duration(seconds: 3),
                          child: Container(
                            margin: EdgeInsets.all(wDimension.height20),
                            width: wDimension.screenWidth * 0.5,
                            height: wDimension.screenHeight * 0.5,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    wDimension.radius30 * 5),
                                child:
                                    // authC.user.value.photoUrl == "noimage" ?
                                    Image.asset("assets/logo/noimage.png",
                                        fit: BoxFit.cover)

                                // : Image.network(authC.user.value.photoUrl!,
                                //     fit: BoxFit.cover)
                                ),
                          ),
                        ),
                        Positioned(
                          bottom: 25,
                          right: 25,
                          child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                              child: wAppIcon(
                                icon: Icons.photo_camera,
                                size: wDimension.iconSize24,
                              )),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: wDimension.screenWidth * 0.6,
                          child: TextField(
                            controller: controller.nameC,
                            textInputAction: TextInputAction.next,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: "Nama Pegawai",
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
                                vertical: wDimension.height15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: wDimension.height10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            wSmallText(
                                text: "Hak akses",
                                color: Colors.black,
                                size: wDimension.font16),
                            SizedBox(
                              width: wDimension.width10,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  searchController: controller.hakC,
                                  isExpanded: true,
                                  hint: Text(
                                    'Pilih Hak akses',
                                    style: TextStyle(
                                      fontSize: wDimension.font16,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: _addDividersAfterItems(items),
                                  customItemsHeights: _getCustomItemsHeights(),
                                  value: selectedValue,
                                  onChanged: (value) {
                                    selectedValue = value as String;
                                    Get.snackbar("Pesan", selectedValue!);
                                  },
                                  buttonHeight: wDimension.height45,
                                  buttonWidth: wDimension.width20 * 7,
                                  dropdownMaxHeight: wDimension.height10 * 20,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //Container 2
            SizedBox(height: wDimension.height10),
            Container(
                padding: EdgeInsets.all(wDimension.screenWidth * 0.03),
                decoration: BoxDecoration(color: const Color(0xff7c94b6)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      wBigText(text: "Detail Pegawai", color: Colors.black),
                      SizedBox(height: wDimension.height20),
                      TextField(
                          controller: controller.jabatanC,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              labelText: "Jabatan",
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
                                vertical: wDimension.height15,
                              ))),
                      SizedBox(height: wDimension.height10),
                      TextField(
                          controller: controller.teleponC,
                          textInputAction: TextInputAction.next,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              labelText: "Telepon",
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
                                vertical: wDimension.height15,
                              ))),
                      SizedBox(height: wDimension.height10),
                      TextField(
                        controller: controller.emailC,
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                              color: Colors.black, fontSize: wDimension.font16),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  wDimension.radius30 * 10),
                              borderSide: const BorderSide(color: Colors.red)),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(wDimension.radius30 * 10),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: wDimension.width30,
                            vertical: wDimension.width15,
                          ),
                        ),
                      ),
                      SizedBox(height: wDimension.height10),
                      TextField(
                          controller: controller.passC,
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.done,
                          maxLength: 5,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Pin",
                              counterText: "",
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
                                vertical: wDimension.width15,
                              )))
                    ])),

            //Button
            SizedBox(
                width: wDimension.screenWidth,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: EdgeInsets.symmetric(
                        horizontal: wDimension.width30,
                        vertical: wDimension.height15,
                      ),
                    ),
                    onPressed: () => controller.addPegawai(),
                    child: wSmallText(
                      text: "Simpan",
                      weight: FontWeight.bold,
                      color: Colors.white,
                    )))
          ],
        ));
  }
}
