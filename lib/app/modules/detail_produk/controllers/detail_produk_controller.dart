import 'dart:ffi';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class DetailProdukController extends GetxController
    with GetTickerProviderStateMixin {
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
