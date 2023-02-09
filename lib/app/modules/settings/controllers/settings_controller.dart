import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../widgets/widgets.dart';

class SettingsController extends GetxController {
  @override
  void onInit() {
    tokoC.value = box.read('toko');
    super.onInit();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  GetStorage box = GetStorage();

  var tokoC = "".obs;
  Stream<QuerySnapshot<Map<String, dynamic>>> streamToko() async* {
    yield* firestore.collection("toko").snapshots();
  }

  Container kategoriDialog() {
    return Container(
      child: Column(
        children: [
          Container(
            width: wDimension.widthSetengah,
            height: wDimension.heightSetengah / 2,
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: streamToko(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.data?.docs.length == 0 ||
                            snapshot.data == null) {
                          return SizedBox(
                            height: wDimension.height20 * 10,
                            child: const Center(child: Text("Belum ada toko")),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> data =
                                snapshot.data!.docs[index].data();

                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    tokoC.value = data["nama_toko"];
                                    Get.back();
                                  },
                                  title: Text(data["nama_toko"]),
                                ),
                                const Divider()
                              ],
                            );
                          },
                        );
                      }),
                  const Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
