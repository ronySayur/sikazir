import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../widgets/widgets.dart';
import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Password baru'), centerTitle: false,backgroundColor: Colors.red,),
        body: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: wDimension.width10, vertical: wDimension.height20),
          children: [
            TextField(
              controller: controller.newPassC,
              cursorColor: Colors.black,
              textInputAction: TextInputAction.done,
              maxLength: 6,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Pin",
                counterText: "",
                labelStyle:
                    TextStyle(color: Colors.black, fontSize: wDimension.font16),
                focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(wDimension.radius30 * 10),
                    borderSide: const BorderSide(color: Colors.red)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(wDimension.radius30 * 10),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: wDimension.width30,
                  vertical: wDimension.height15,
                ),
              ),
            ),

            //Button
            Container(
                padding: EdgeInsets.only(
                    top: wDimension.height15,
                    right: wDimension.width10,
                    left: wDimension.width10,
                    bottom: wDimension.height10),
                width: wDimension.screenWidth,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: EdgeInsets.symmetric(
                            horizontal: wDimension.width30,
                            vertical: wDimension.height15)),
                    onPressed: () => controller.newPaswword(),
                    child: wSmallText(
                      text: "Simpan",
                      weight: FontWeight.bold,
                      color: Colors.white,
                    )))
          ],
        ));
  }
}
