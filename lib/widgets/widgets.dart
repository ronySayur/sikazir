import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'theme.dart';

const primaryColor = Color(0xFFD32F2F);
const secondaryColor = Color.fromARGB(255, 248, 248, 248);
const bgColor = Color(0xFF212332);

const defaultPadding = 16.0;

class wDimension {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;
//ukuran bottomview
  static double bottomHeightBar = screenHeight / 7.03;

//ukuran font
  static double font16 = screenHeight / 52.75;

  static double font20 = screenHeight / 42.2;
  static double font26 = screenHeight / 32.46;
//Ketingggian
  static double height10 = screenHeight / 84.4;

  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 18.76;

  static double heightSetengah = screenHeight * 0.5;

  static double iconSize16 = screenHeight / 52.75;
//ukuran icon
  static double iconSize24 = screenHeight / 35.17;

//ukuran image
  static double listViewImgSize = screenWidth / 3.25;

  static double listViewTextContSize = screenWidth / 3.9;
//ukuran page
  static double pageView = screenHeight / 2.64;

  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 7.03;
//lekuk radius
  static double radius15 = screenHeight / 56.27;

  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;

//Lebar
  static double width10 = screenHeight / 84.4;

  static double width15 = screenHeight / 56.27;
  static double width20 = screenHeight / 42.2;
  static double width30 = screenHeight / 28.13;
  static double widthSetengah = screenHeight * 0.5;
}

// ignore: must_be_immutable
class wBigText extends StatelessWidget {
  wBigText({
    super.key,
    this.color = const Color(0xFF1e81b0),
    required this.text,
    this.size = 0,
    this.weight = FontWeight.normal,
    this.align = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
  });

  Color? color;
  TextOverflow overflow;
  double size;
  final String text;
  TextAlign align;
  FontWeight weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? 20 : size,
        fontWeight: weight,
      ),
    );
  }
}

// ignore: must_be_immutable
class wSmallText extends StatelessWidget {
  wSmallText(
      {super.key,
      required this.text,
      this.weight = FontWeight.normal,
      this.color = const Color(0xFF1e81b0),
      this.size = 12,
      this.height = 1.2,
      this.align = TextAlign.start});

  Color? color;
  FontWeight weight;
  double height;
  double size;
  final String text;
  TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontSize: size,
        height: height,
        fontWeight: weight,
      ),
    );
  }
}

//Widget icon
class wAppIcon extends StatelessWidget {
  const wAppIcon({
    Key? key,
    required this.icon,
    this.backgroundColor = const Color.fromARGB(0, 255, 255, 255),
    this.iconColor = const Color.fromARGB(255, 255, 255, 255),
    this.size = 40,
    this.iconSize = 24,
  }) : super(key: key);

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double iconSize;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: backgroundColor),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}

Widget wTimeBoxUI(String title, String deskripsi) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: DesignAppTheme.nearlyWhite,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        boxShadow: [
          BoxShadow(
              color: DesignAppTheme.grey.withOpacity(0.2),
              offset: const Offset(1.1, 1.1),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                letterSpacing: 0.27,
                color: DesignAppTheme.nearlyBlue,
              ),
            ),
            Text(
              deskripsi,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14,
                letterSpacing: 0.27,
                color: DesignAppTheme.grey,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void loading() {
  Get.defaultDialog(
      title: "Tunggu Sebentar",
      content: const CircularProgressIndicator(),
      barrierDismissible: false);

}
  Center dataKosong(String descData) {
    return Center(
      child: Column(
        children: [
          Lottie.asset("assets/lottie/empty.json"),
          wBigText(text: "Data $descData kosong")
        ],
      ),
    );
  }

Future<bool> willPopScope() async {
  return (await Get.defaultDialog(
          title: "Konfirmasi",
          content: Column(
            children: [
              wSmallText(text: "Apakah anda yakin untuk kembali?"),
              SizedBox(height: wDimension.height10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                      onPressed: () => Get.back(), child: const Text("Batal")),
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                        Get.back();
                      },
                      child: Text("Konfirmasi"))
                ],
              ),
            ],
          ))) ??
      false;
}
