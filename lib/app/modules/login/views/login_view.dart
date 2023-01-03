import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sikasir/widgets/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
          // ignore: prefer_const_constructors
          image: DecorationImage(
              image: const AssetImage("assets/background/bglogin.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  wBigText(
                      text: "Point Of Sales",
                      color: Colors.red,
                      weight: FontWeight.bold,
                      size: wDimension.font26 * 2.5),
                  wBigText(
                      text: "Aida Putra",
                      color: Colors.white,
                      weight: FontWeight.bold,
                      size: wDimension.font26 * 2.5),
                ],
              ),
            ),
            SlidingUpPanel(
              maxHeight: wDimension.heightSetengah,
              minHeight: wDimension.heightSetengah / 1.5,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(wDimension.radius20),
                  topRight: Radius.circular(wDimension.radius20)),
              panel: Container(
                padding: EdgeInsets.all(wDimension.screenWidth * 0.06),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    wBigText(
                        text: "Selamat Datang",
                        color: Colors.red,
                        weight: FontWeight.bold,
                        size: wDimension.font26 * 1.25),
                    wSmallText(
                      text: "Silahkan masuk dengan akun yang sudah diberikan",
                      size: wDimension.font16 * 0.86,
                    ),
                    SizedBox(height: wDimension.height20 * 1.5),
                    TextField(
                      controller: controller.emailC,
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                            color: Colors.black, fontSize: wDimension.font16),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(wDimension.radius30 * 10),
                            borderSide: const BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(wDimension.radius30 * 10),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: wDimension.width30,
                          vertical: wDimension.width15,
                        ),
                      ),
                    ),
                    SizedBox(height: wDimension.height10),
                    TextField(
                      controller: controller.passC,
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.done,
                      maxLength: 5,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Pin",
                        counterText: "",
                        labelStyle: TextStyle(
                            color: Colors.black, fontSize: wDimension.font16),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(wDimension.radius30 * 10),
                            borderSide: const BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(wDimension.radius30 * 10),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: wDimension.width30,
                          vertical: wDimension.width15,
                        ),
                      ),
                    ),
                    SizedBox(height: wDimension.height15),
                    SizedBox(
                      width: wDimension.screenWidth,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[900],
                          shape: const StadiumBorder(),
                          padding: EdgeInsets.symmetric(
                            horizontal: wDimension.width30,
                            vertical: wDimension.width15,
                          ),
                        ),
                        onPressed: () {},
                        child: wSmallText(
                            text: "Login",
                            weight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
