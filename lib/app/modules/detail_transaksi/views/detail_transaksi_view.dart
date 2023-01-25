import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../../../../widgets/theme.dart';
import '../controllers/detail_transaksi_controller.dart';

class DetailTransaksiView extends GetView<DetailTransaksiController> {
  final int totalTagihhan = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.tagihan.value=totalTagihhan;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Detail Transaksi'),
          centerTitle: false,
        ),
        body: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child: TextField(
                    controller: controller.uangDiterima,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: "Uang yang diterima",
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
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      
                      onPressed: () {},
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: DesignAppTheme.nearlyBlue,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    DesignAppTheme.nearlyBlue.withOpacity(0.5),
                                offset: const Offset(1.1, 1.1),
                                blurRadius: 10.0)
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "Lanjutkan",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              letterSpacing: 0.0,
                              color: DesignAppTheme.nearlyWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),

            ],
          ),
        ));
  }
}
