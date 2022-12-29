import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

import '../../../../widgets/widgets.dart';
import '../../../routes/app_pages.dart';
import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Bertransaksi dengan mudah",
          body:
              "Jadilah pemilik bisnis yang lebih efisien dengan aplikasi point of sales kami yang intuitif dan mudah digunakan!",
          image: Container(
            width: Get.width * 0.6,
            height: Get.width * 0.6,
            child: Center(
              child: Lottie.asset("assets/lottie/payment.json"),
            ),
          ),
        ),
        PageViewModel(
          title: "Mencatat lebih menyenangkan",
          body:
              "Biarkan aplikasi point of sales kami menangani transaksi dan laporan keuangan bisnis Anda, sehingga Anda dapat fokus pada hal-hal yang lebih penting",
          image: Container(
            width: Get.width * 0.6,
            height: Get.width * 0.6,
            child: Center(
              child: Lottie.asset("assets/lottie/pos-machine.json"),
            ),
          ),
        ),
        PageViewModel(
          title: "Laporan lebih lengkap",
          body:
              "Dengan aplikasi point of sales kami, Anda dapat mengelola bisnis Anda dengan lebih mudah dan efektif, di mana saja dan kapan saja.",
          image: Container(
            width: Get.width * 0.6,
            height: Get.width * 0.6,
            child: Center(
              child: Lottie.asset("assets/lottie/reportTransaction.json"),
            ),
          ),
        ),
      ],
      showSkipButton: true,
      skip: wBigText(text: "Skip", weight: FontWeight.bold),
      next: wBigText(text: "Next", weight: FontWeight.bold),
      done: wBigText(text: "Login", weight: FontWeight.bold),
      onDone: () => Get.offAllNamed(Routes.LOGIN),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    ));
  }
}
