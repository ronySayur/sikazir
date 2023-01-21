import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sikasir/app/models/supplier_model.dart';
import 'package:sikasir/app/routes/app_pages.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../controllers/home_supplier_controller.dart';
import 'grid_item.dart';

class HomeSupplierView extends GetView<HomeSupplierController> {
  HomeSupplierView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(wDimension.height30 * 4.25),
        child: AppBar(
          backgroundColor: Colors.red[900],
          title: wBigText(text: "Supplier", color: Colors.white),
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
          stream: controller.streamSupplier(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snap.data!.docs.isEmpty) {
              return dataKosong();
            }

            return GetBuilder<HomeSupplierController>(builder: (controller) {
              if (controller.searchC.text.isEmpty) {
                List<SupplierModel> allSupplier = [];

                for (var element in snap.data!.docs) {
                  allSupplier.add(SupplierModel.fromJson(element.data()));
                }

                return showSupplier(allSupplier);
              } else {
                if (controller.tempSearch.isNotEmpty) {
                  List<SupplierModel> searchSup = [];

                  for (var element in controller.tempSearch) {
                    searchSup.add(SupplierModel.fromJson(element));
                  }
                  return showSupplier(searchSup);
                } else {
                  return dataKosong();
                }
              }
            });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_SUPPLIER),
        child: const Icon(Icons.add),
      ),
    );
  }

  SingleChildScrollView showSupplier(List<SupplierModel> allSup) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: allSup.length,
              itemBuilder: (context, index) {
                final int count = allSup.length;
                final Animation<double> animation =
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: controller.animationController!,
                    curve: Interval((1 / count) * index, 1.0,
                        curve: Curves.fastOutSlowIn),
                  ),
                );
                controller.animationController?.forward();
                return GetBuilder<HomeSupplierController>(
                  init: HomeSupplierController(),
                  initState: (_) {},
                  builder: (c) {
                    return GridViewS(
                      animation: animation,
                      animationController: controller.animationController,
                      dataSupplierModel: allSup[index],
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

  Center dataKosong() {
    return Center(
      child: Column(
        children: [
          Lottie.asset("assets/lottie/empty.json"),
          wBigText(text: "Data suplier Kosong")
        ],
      ),
    );
  }
}
