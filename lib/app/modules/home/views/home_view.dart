import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikasir/widgets/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  // const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Dashboard'),
        centerTitle: false,
      ),
      body: SlidingUpPanel(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(wDimension.radius20),
            topRight: Radius.circular(wDimension.radius20)),
        maxHeight: wDimension.heightSetengah,
        minHeight: wDimension.screenHeight * 0.1,
        panel: Container(
          padding: EdgeInsets.all(wDimension.screenWidth * 0.06),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  wBigText(
                    color: Colors.black,
                    weight: FontWeight.bold,
                    text: "Laporan Hari ini",
                  ),
                  wSmallText(
                    color: Colors.red,
                    weight: FontWeight.bold,
                    text: "30 Des 2022",
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: wBigText(text: "lihat semua"),
              )
            ],
          ),
        ),
        body: Center()
      ),
    );
  }
}
