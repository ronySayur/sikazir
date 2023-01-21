import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikasir/widgets/widgets.dart';

class DetailProdukController extends GetxController
    with GetTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  var opacity1 = 0.obs;
  var opacity2 = 0.obs;
  var opacity3 = 0.obs;

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    opacity1.value = 1;
    print("1");
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    opacity2.value = 1;
    print("2");
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    opacity3.value = 1;
    print("3");
  }

  Future<Map<String, dynamic>> deleteProduct(String IDdelete) async {
    loading();
    try {
      await firestore.collection("produk").doc(IDdelete).delete();

      Get.back();
      Get.back();
      Get.back();

      return {
        "error": false,
        "message": "Produk berhasil dihapus.",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Produk gagal dihapus.",
      };
    }
  }

  @override
  void onInit() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.onInit();
  }
}
