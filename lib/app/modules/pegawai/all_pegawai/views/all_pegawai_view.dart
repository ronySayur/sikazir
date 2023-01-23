import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sikasir/app/models/pegawai_model.dart';
import 'package:sikasir/app/modules/pegawai/all_pegawai/views/grid_item.dart';

import '../../../../../widgets/widgets.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/all_pegawai_controller.dart';

class AllPegawaiView extends GetView<AllPegawaiController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Semua Pegawai'),
        centerTitle: false,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamPegawai(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snap.data!.docs.isEmpty) {
              return dataKosong("Pegawai");
            }

            return GetBuilder<AllPegawaiController>(builder: (controller) {
              if (controller.searchC.text.isEmpty) {
                List<PegawaiModel> allPeg = [];

                for (var element in snap.data!.docs) {
                  allPeg.add(PegawaiModel.fromJson(element.data()));
                }

                return showData(allPeg);
              } else {
                if (controller.tempSearch.isNotEmpty) {
                  List<PegawaiModel> searchSup = [];

                  for (var element in controller.tempSearch) {
                    searchSup.add(PegawaiModel.fromJson(element));
                  }
                  return showData(searchSup);
                } else {
                  return dataKosong('Pegawai');
                }
              }
            });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_PEGAWAI),
        child: const Icon(Icons.add),
      ),
    );
  }

  SingleChildScrollView showData(List<PegawaiModel> allPegawai) {
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
              itemCount: allPegawai.length,
              itemBuilder: (context, index) {
                
                final int count = allPegawai.length;
                final Animation<double> animation =
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: controller.animationController!,
                    curve: Interval((1 / count) * index, 1.0,
                        curve: Curves.fastOutSlowIn),
                  ),
                );
                controller.animationController?.forward();
                return GetBuilder<AllPegawaiController>(
                  init: AllPegawaiController(),
                  initState: (_) {},
                  builder: (c) {
                    return GridViewPegawai(
                      animation: animation,
                      animationController: controller.animationController,
                      dataPegawai: allPegawai[index],
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
