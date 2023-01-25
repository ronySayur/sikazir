import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikasir/app/models/toko_model.dart';
import 'package:sikasir/app/modules/toko/home_toko/views/grid_item.dart';
import 'package:sikasir/app/routes/app_pages.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/home_toko_controller.dart';

class HomeTokoView extends GetView<HomeTokoController> {
  HomeTokoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(wDimension.height30 * 4.25),
        child: AppBar(
          backgroundColor: Colors.red[900],
          title: wBigText(text: "Toko", color: Colors.white),
          centerTitle: false,
          flexibleSpace: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextField(
                      onChanged: (value) => controller.searchSupplier(value),
                      controller: controller.searchC,
                      cursorColor: Colors.red[900],
                      autocorrect: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(wDimension.height45),
                            borderSide: BorderSide(
                                color: Colors.white,
                                width: wDimension.width10 / 10)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(wDimension.height45),
                            borderSide: BorderSide(
                                color: Colors.white,
                                width: wDimension.width10 / 10)),
                        hintText: "Search..",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: wDimension.height30,
                            vertical: wDimension.height20),
                      )))),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamToko(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snap.data!.docs.isEmpty) {
              return dataKosong('Toko');
            }

            return GetBuilder<HomeTokoController>(builder: (controller) {
              if (controller.searchC.text.isEmpty) {
                List<TokoModel> dataToko = [];

                for (var element in snap.data!.docs) {
                  dataToko.add(TokoModel.fromJson(element.data()));
                }

                return showToko(dataToko);
              } else {
                if (controller.tempSearch.isNotEmpty) {
                  List<TokoModel> search = [];

                  for (var element in controller.tempSearch) {
                    search.add(TokoModel.fromJson(element));
                  }
                  return showToko(search);
                } else {
                  return dataKosong('Toko');
                }
              }
            });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_TOKO),
        child: const Icon(Icons.add),
      ),
    );
  }

  SingleChildScrollView showToko(List<TokoModel> allToko) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: allToko.length,
              itemBuilder: (context, index) {
                final int count = allToko.length;
                final Animation<double> animation =
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: controller.animationController!,
                    curve: Interval((1 / count) * index, 1.0,
                        curve: Curves.fastOutSlowIn),
                  ),
                );
                controller.animationController?.forward();
                return GetBuilder<HomeTokoController>(
                  init: HomeTokoController(),
                  initState: (_) {},
                  builder: (c) {
                    return GridViewToko(
                      animation: animation,
                      animationController: controller.animationController,
                      dataToko: allToko[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
