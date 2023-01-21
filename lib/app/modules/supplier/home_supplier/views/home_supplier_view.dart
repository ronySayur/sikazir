import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sikasir/app/models/supplier_model.dart';
import 'package:sikasir/app/routes/app_pages.dart';
import 'package:sikasir/widgets/widgets.dart';
import 'grid_item.dart';

import '../controllers/home_supplier_controller.dart';

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
              padding: EdgeInsets.fromLTRB(
                  wDimension.height30,
                  wDimension.height10 * 5,
                  wDimension.height20,
                  wDimension.height20),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextField(
                      onChanged: (value) {
                        controller.searchSupplier(value);
                        controller.ontap.toggle();
                      },
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

            List<SupplierModel> allSupplier = [];

            for (var element in snap.data!.docs) {
              allSupplier.add(SupplierModel.fromJson(element.data()));
            }
            return Obx(() => controller.ontap.isTrue
                ? controller.tempSearch.isEmpty
                    ? dataKosong()
                    : searchSupplier()
                : showSupplier(allSupplier));
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
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 32.0,
                crossAxisSpacing: 32.0,
                childAspectRatio: 0.8,
              ),
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
                return GridViewS(
                  animation: animation,
                  animationController: controller.animationController,
                  dataSupplier: allSup[index],
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

  SingleChildScrollView searchSupplier() {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 32.0,
                crossAxisSpacing: 32.0,
                childAspectRatio: 0.8,
              ),
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: controller.tempSearch.length,
              itemBuilder: (context, index) {
                final int count = controller.tempSearch.length;
                final Animation<double> animation =
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: controller.animationController!,
                    curve: Interval((1 / count) * index, 1.0,
                        curve: Curves.fastOutSlowIn),
                  ),
                );
                controller.animationController?.forward();
                return SearchGridViewS(
                  animation: animation,
                  animationController: controller.animationController,
                  dataSupplier: controller.tempSearch[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
