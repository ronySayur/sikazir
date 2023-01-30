import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sikasir/widgets/widgets.dart';

import '../../../../widgets/theme.dart';
import '../controllers/detail_transaksi_controller.dart';

class DetailTransaksiView extends GetView<DetailTransaksiController> {
  var data = Get.arguments;
  final rpid = NumberFormat("#,##0", "ID");

  @override
  Widget build(BuildContext context) {
    controller.tagihan.value = data[0];
    controller.diskon.value = data[1];
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Detail Transaksi'),
          centerTitle: false,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        wBigText(
                          text: "Total Tagihan",
                          color: Colors.black,
                          size: 20,
                          weight: FontWeight.w900,
                        ),
                        wBigText(
                          text: "Rp. ${rpid.format(data[0])}",
                          size: 28,
                          weight: FontWeight.w400,
                          color: Colors.red,
                        )
                      ],
                    )
                  ],
                )),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.all(defaultPadding),
                color: Colors.white,
                child: TextField(
                  onEditingComplete: () {
                    controller.cekTagihan();
                  },
                  controller: controller.uangDiterima,
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  maxLength: 15,
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'ID',
                      decimalDigits: 0,
                      symbol: 'Rp. ',
                    ),
                  ],
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
                  child: Container(
                    color: Colors.white,
                    child: TextButton(
                      onPressed: () {
                        controller.cekTagihan();
                      },
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
                            "Bayar",
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
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
